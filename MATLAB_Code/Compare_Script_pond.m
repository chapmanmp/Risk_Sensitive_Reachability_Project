%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Analysis of results, pond example
% AUTHOR: Margaret Chapman
% DATE: September 6, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Compares [Monte Carlo, max] vs. [Dynamic Programming, soft-max] 

close all; clearvars; clc;

load('Pond_Results\monte_carlo_max_pond_results\monte_carlo_max_addnoise_nt100000.mat');
% Results from Main_MonteCarlo_Pond.m, type_sum = 0
% J0(x,y) := min_pi CVaR_y[ max{ g(xk) : k = 0,...,N } | x0 = x, pi ] via Monte Carlo for pond example
% nt = 100000, number of trials per (x,y)

J0_cost_max = J0_MonteCarlo;

load('Pond_Results\dyn_prog_mis1_pond_results\dyn_program_mis1_pond.mat');
% Results from Main_DynamicProgramming_Pond.m, m = 1
% J0(x,y) := min_pi CVaR_y[ exp(m*g(x0)) + ... + exp(m*g(xN)) | x0 = x, pi ] via dynamic programming for pond example

J0_cost_sum = Js{1};

rs = [-0.1, 0, 0.5, 1.6 ]; % risk levels to be plotted

[ U, S ] = getRiskySets_pond( ls, xs, rs, m, J0_cost_sum, J0_cost_max ); % xticklabels are hardcoded, should be function of xs
