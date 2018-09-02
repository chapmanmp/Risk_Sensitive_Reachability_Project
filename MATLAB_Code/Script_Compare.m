%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Script to compare results
% DYNAMICS: xk+1 = xk + uk + wk, wk \in {-1, 0, 1} equally probable
% AUTHORS: Margaret Chapman, Donggun Lee, Jonathan Lacotte
% DATE: August 31, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Compare [brute force, soft-max] versus [dynamic programming, soft-max]
       % J0(x,y) := min_pi CVaR_y[ exp(g(x0)) + ... + exp(g(xN)) | x0 = x, pi ]

close all; clearvars; clc;

load('Results_LTISystem\brute_force_cost_sum_mis1_LTI.mat');
% J0_Brute_Force(l_index, x_index): J0 evaluated at x = xs(x_index), y = ls(l_index) computed via Main_BruteForce.m, type_sum = 1, m = 1

load('Results_LTISystem\dynamic_programming_mis1_LTI.mat');
% Js{1}(l_index, x_index): J0 evaluated at x = xs(x_index), y = ls(l_index) computed via Main_DynProgram.m

array_diff = abs( J0_Brute_Force - Js{1} ); % element-wise absolute value

max_diff = max( array_diff(:) );            % largest difference is 0.0364

%% Compare [brute force, soft-max] versus [brute force, max]

close all; clearvars; clc;

load('Results_LTISystem\brute_force_cost_sum_mis10_LTI.mat'); J0_cost_sum = J0_Brute_Force;
% J0_Brute_Force(l_index, x_index) = min_pi CVaR_y[ exp(m*g(x0)) + ... + exp(m*g(xN)) | x0 = x, pi ]
    % at state y = ls(l_index), x = xs(x_index)
    % computed via Main_BruteForce.m, type_sum = 1
    
load('Results_LTISystem\brute_force_cost_max_LTI.mat'); J0_cost_max = J0_Brute_Force;
% J0_Brute_Force(l_index, x_index) = min_pi CVaR_y[ max{g(x0), ..., g(xN)} | x0 = x, pi ]
    % at state y = ls(l_index), x = xs(x_index)
    % computed via Main_BruteForce.m, type_sum = 0
 
m = 10; 

rs = 1/2: 1/4: 1; % risk levels to be plotted

[ U, S ] = getRiskySets( ls, xs, rs, m, J0_cost_sum, J0_cost_max ); % xticklabels are hardcoded, should be function of xs




