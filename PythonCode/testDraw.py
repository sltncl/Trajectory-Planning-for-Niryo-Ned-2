# Libraries import
from pyniryo import *
import numpy as np
import trajectories

robot = NiryoRobot("169.254.200.200")
robot.calibrate_auto()

case_N = 3

if case_N == 1:
    waypoints = trajectories.waypoints_circle
elif case_N == 2:
    waypoints = trajectories.waypoints_poliba_normal
elif case_N == 3:
    waypoints = trajectories.trajectory_used
else:
    robot.move_pose(0.25,0.12711241113395,0.140,0,0.5,0)

if case_N != 0:
    w=[]
    for i in waypoints:
        w.append(i)

    robot.execute_trajectory_from_poses(w)