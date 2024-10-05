function waypoints = generateWaypoints(inputString, offset, toolPositionHome, scale)
    % GENERATEWAYPOINTS - Generate waypoints for a trajectory to be executed by the Niryo Ned 2 robot.
    %
    %   This function takes as input a string to be traced, the offset between each letter,
    %   the starting position of the robotic arm, and the size of the letters. It generates
    %   a set of points constituting waypoints for computing a trajectory to be executed by
    %   the Niryo Ned 2 robot. The waypoints are positioned at the center of the starting
    %   position, and a check is performed to determine whether the trajectory points
    %   are within the robot's operational space and thus reachable.
    %
    %   Input:
    %       inputString - String to be traced (e.g., 'poliba')
    %       offset - Offset between each letter
    %       toolPositionHome - Starting position of the robotic arm
    %       scale - Size of the letters
    %
    %   Output:
    %       waypoints - Matrix containing the coordinates of the generated waypoints

    % Define the mapping of letters to their respective sets of coordinates
    coordinates = createCoordinates();
    coordinateMap = containers.Map('KeyType', 'char', 'ValueType', 'any');
    coordinateMap('p') = [coordinates.pCoordinates];
    coordinateMap('o') = [coordinates.oCoordinates];
    coordinateMap('l') = [coordinates.lCoordinates];
    coordinateMap('i') = [coordinates.iCoordinates];
    coordinateMap('b') = [coordinates.bCoordinates];
    coordinateMap('a') = [coordinates.aCoordinates];
    
    % Initialize the coordinates of the waypoints
    waypoints = [];
    
    % Calculate the coordinates for each letter in the input string
    for i = 1:length(inputString)
        letter = inputString(i);
        if isKey(coordinateMap, letter)
            coordinates = coordinateMap(letter);
            if isempty(waypoints)
                waypoints = coordinates;
            else
                coordinates(:,2) = coordinates(:,2) + min(waypoints(:,2)) - offset;
                waypoints = [waypoints; coordinates];
            end
        end
    end

    % Calculate the center of the generated waypoints
    center_y = mean(waypoints(:, 2));
    
    % Calculate the offset to center the waypoints around toolPositionHome on the y-axis
    offset_center_y = toolPositionHome(2) - center_y;

    % Adjust the waypoints to be centered around toolPositionHome only on the y-axis
    waypoints(:,2) = waypoints(:,2) + offset_center_y;

    % Calculate the waypoints
    waypoints = toolPositionHome(1:3)' + waypoints' ./ scale;

    % Ensure that the waypoints are within the operational space

    % Define the radius of the robot's workspace
    radius_workspace = 1.008/2; % m

    % Boolean variable for control
    checkbool = 0;

    % Check if waypoints are within the operational space
    for i = 1:size(waypoints, 2)
        x = waypoints(1, i);
        y = waypoints(2, i);
    
        % Calculate the upper limits allowed within the robot's operational space 
        % based on the specified workspace radius
        x_limit = sqrt(radius_workspace^2 - y^2);
        y_limit = sqrt(radius_workspace^2 - x^2);
    
        % Limit verification
        if x > -x_limit && x < x_limit && y > -y_limit && y < y_limit
        else
            checkbool = 1;
        end
    end

    % Display a warning if waypoints might exceed the workspace
    if checkbool == 0
        disp('The waypoints are inside the workspace.');
    else
        disp('Attention: The waypoints might exceed the workspace.');
    end

end
