% NIRYO NED2 TASK SPACE TRAJECTORIES
% This script is designed for trajectory planning of the Niryo NED2 robot, 
% utilizing the trapezoidal approach within its operational space.
% ------------------------------------------------------------------------
% AUTHORS: 
% - Nicola Saltarelli 
% - Francesco Stasi
% - Davide Tonti
% ------------------------------------------------------------------------
% Date modified 27/04/2024

%% Setup
clear, clc, close all

% Import Niryo Ned2 robot features
[ned2, numJoints] = ned2_import;

% Uncomment the lines below to verify the robot's construction
% and avoid showing this information every time the code is launched.
% "showdetails" lists all the bodies in the MATLAB® command window.
% showdetails(ned2)

% Define the starting position and orientation 
toolPositionHome = [0.25, 0, 0.15, 0, 0, 0];
% toolPositionHome = [0.25, 0, 0.15, 0, 0.5, 0];

% Define the end-effector name
eeName = 'hand_link';

% Define the string to be followed by the robot
inputString = 'poliba';

% Define the distance between each letter
distance_between_letters = 0.1;

% Set the scale of the string (scale down to achieve a higher dimension)
scale = 6;

% Generate waypoints
waypoints = generateWaypoints(inputString, distance_between_letters, toolPositionHome, scale);

% Specify the desired mean velocity (e.g., in meters per second)
meanVelocity = 0.06; % 0.468 m/s is the max speed of Niryo Ned 2

% Calculate the distance between trajectory points
distances = sqrt(sum(diff(waypoints,[],2).^2));

% Calculate time required to reach each point based on distance and mean velocity
waypointTimes = [0, cumsum(distances / meanVelocity)];

% Trajectory sample time
ts = 0.1; % s
% Generate a vector of sample times with interval 'ts'
trajTimes = 0:ts:waypointTimes(end);

% Duration of acceleration phase of velocity profile
waypointAccelTimes = diff(waypointTimes)/10;

% Duration of each trajectory segment
endTimes = diff(waypointTimes);

% Define inverse kinematics (IK) solver
ik = inverseKinematics('RigidBodyTree',ned2, 'SolverAlgorithm','LevenbergMarquardt');

% Define weights for pose tolerances
ikWeights = [0 0 0 1 1 1]; % [orientation_weight, position_weight]

% Initial guess of robot configuration
ikInitGuess = ned2.homeConfiguration;

% Plot setup for trajectory simulation
figure(1);
show(ned2,ikInitGuess,'Frames','off','PreservePlot',false);
xlim([-1 1]), ylim([-1 1]), zlim([0 1.2])
hold on
hTraj = plot3(waypoints(1,1),waypoints(2,1),waypoints(3,1),'b.-');

%% Generate trajectory
[q,qd,qdd] = trapveltraj(waypoints,numel(trajTimes),'AccelTime',repmat(waypointAccelTimes,[3 1]), ... 
    'EndTime',repmat(endTimes,[3 1]));
                            
% Show the full trajectory with the rigid body tree
set(hTraj,'xdata',q(1,:),'ydata',q(2,:),'zdata',q(3,:));

%% Trajectory following loop
for idx = 1:numel(trajTimes) 
    % Solve IK
    tgtPose = trvec2tform(q(:,idx)');
    [config, info] = ik(eeName, tgtPose, ikWeights, ikInitGuess);
    ikInitGuess = config;

    % Show the robot
    figure(1)
    show(ned2,ikInitGuess,'Frames','off','PreservePlot',false);
    title(['Trajectory at t = ' num2str(trajTimes(idx))])
    drawnow    
end

%% Generation of plots

% Waypoints plot
figure(2);
scatter3(waypoints(1,:), waypoints(2,:), waypoints(3,:), 'filled', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b');
xlim([min(waypoints(1,:))-0.05 max(waypoints(1,:))+0.05]), ylim([min(waypoints(2,:))-0.05 max(waypoints(2,:))+0.05]), zlim([min(waypoints(3,:)) max(waypoints(3,:))])
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Waypoints');

% Trajectories positions, trapezoidal velocity profile and acceleration
% profile.
figure(3)
subplot(3,1,1)
plot(trajTimes, q)
xlabel('Time (s)')
ylabel('Positions (m)')
legend('X','Y', 'Z')
subplot(3,1,2)
plot(trajTimes, qd)
xlabel('Time (s)')
ylabel('Velocities (m/s)')
legend('X','Y', 'Z')
subplot(3,1,3)
plot(trajTimes, qdd)
xlabel('Time (s)')
ylabel('Accelerations (m/s^2)')
legend('X','Y', 'Z')
