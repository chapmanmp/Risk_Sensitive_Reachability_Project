%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Analysis of results, pond example
% AUTHOR: Margaret Chapman
% DATE: September 6, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Compares [Monte Carlo, soft-max] vs. [Dynamic Programming, soft-max] to justify number of trials per grid point in Monte Carlo

close all; clearvars; clc;

x_index_clip = 56; %xs(56) = 5.5ft, clip so we don't analyze inaccuracies near boundary of grid?

load('monte_carlo_mis1_pond_results\monte_carlo_mis1_ntis1000_pond.mat'); 
% Results from Main_MonteCarlo_Pond.m, type_sum = 1, m = 1
% J0(x,y) := min_pi CVaR_y[ exp(m*g(x0)) + ... + exp(m*g(xN)) | x0 = x, pi ] via Monte Carlo for pond example
% nt = 1000 trials per (x,y)

J0_MC_clip = J0_MonteCarlo( 1:end-1, 1:x_index_clip );     % analyze results for x \in [0, 5.5ft], y not equal to 0.001

load('dynamics_programming_mis1_pond_results\dynamic_programming_mis1_pond.mat');
% Results from Main_DynamicProgramming_Pond.m, m = 1
% J0(x,y) := min_pi CVaR_y[ exp(m*g(x0)) + ... + exp(m*g(xN)) | x0 = x, pi ] via dynamic programming for pond example

J0_DP_clip = Js{1}( 1:end-1, 1:x_index_clip );             % analyze results for x \in [0, 5.5ft], y not equal to 0.001

array_diff = abs( J0_MC_clip - J0_DP_clip );               % element-wise absolute value

max_diff = max( array_diff(:) );                           % largest difference for...
                                                                % x \in [0, 5.5ft], 
                                                                % y not equal to 0.001, 
                                                                % m = 1                 is 5.14

