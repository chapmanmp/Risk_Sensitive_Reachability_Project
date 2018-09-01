%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Compares J0 computed via brute force versus dynamic programming
%    -J0(x,y) := min_pi CVaR_y[ exp(g(x0)) + ... + exp(g(xN)) | x0 = x, pi ]
% DYNAMICS: xk+1 = xk + uk + wk, wk \in {-1, 0, 1} equally probable
% AUTHORS: Margaret Chapman, Donggun Lee, Jonathan Lacotte
% DATE: August 31, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clearvars; clc;

load('Results_LTISystem\brute_force_computation_LTI_aug31.mat');
% J0_Brute_Force(l_index, x_index): J0 evaluated at state xs(x_index), confidence level ls(l_index) computed via Main_BruteForce.m

load('Results_LTISystem\dynamic_programming_LTI_aug31.mat');
% Js{1}(l_index, x_index): J0 evaluated at state xs(x_index), confidence level ls(l_index) computed via Main_DynProgram.m

array_diff = abs( J0_Brute_Force-Js{1} ); % element-wise absolute value

max_diff = max( array_diff(:) );          % largest difference




