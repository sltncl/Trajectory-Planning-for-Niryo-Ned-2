% This is the first script to be executed in order to call the functions 
% in the Utilities folder recursively
clc, clear all 
% Enter the path
addpath('./')
toolPath = genpath('./');
addpath(toolPath)