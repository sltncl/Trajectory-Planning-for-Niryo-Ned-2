# Trajectory Planning for Niryo Ned 2 Robot

This repository contains the materials and code related to the trajectory planning methodology developed for the Niryo Ned 2 robot. The approach is based on inverse kinematics in the operational space and the trapezoidal velocity profile.

## Project Overview

The methodology was first tested through simulations in Matlab, utilizing the Robotics System Toolbox to graphically visualize the planned trajectory. Subsequently, we implemented the approach practically by transferring the waypoints obtained in Matlab to Python, using the `pyniryo` library for real-world execution on the Niryo Ned 2 robot.

In order to improve the precision and stability during the task, a custom-designed end-effector was created and manufactured. This was designed specifically to enhance the grip on the pen during trajectory execution.

## Repository Structure

The project folder is organized as follows:

- **MatlabCode**: Contains the Matlab scripts used for trajectory planning and simulation. Each file includes a description of its purpose.
- **PythonCode**: Includes Python scripts to control the Niryo Ned 2 robot. These scripts pass the waypoints obtained from the Matlab simulation to the robot for real-world testing.
- **Nyrio-Ned-2-Pen-Support**: Contains the files and configuration details of the custom-designed pen holder end-effector used in the trajectory task.
- **Trajectory Planning Nyrio Ned 2.pdf**: Project documentation file, detailing the methodology, implementation, and results.
  
## Requirements

- **Matlab** with Robotics System Toolbox
- **Python** with `pyniryo` library for communication with the Niryo Ned 2 robot
- **Niryo Ned 2 Robot**

Feel free to explore the code and files, and refer to the documentation for a detailed explanation of the project.
