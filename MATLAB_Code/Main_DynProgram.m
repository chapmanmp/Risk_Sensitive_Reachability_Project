%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes J0(x,y) := min_pi CVaR_y[ exp(g(x0)) + ... + exp(g(xN)) | x0 = x, pi ] via dynamic programming
    % CVaR Bellman recursion & interpolation over y proposed originally by Chow et al., NIPS, 2015
% DYNAMICS: xk+1 = xk + uk + wk, wk \in {-1, 0, 1} equally probable
% AUTHORS: Margaret Chapman, Donggun Lee, Jonathan Lacotte
% DATE: August 30, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clearvars; clc;

Setup_LTI_Dynamics;             % provides grid, constraint set, probability distribution, time horizon, etc.

Js = cell( N+1, 1 );            % Contains optimal value functions to be solved via dynamic programming
                                % Js{1} is J0, Js{2} is J1, ..., Js{N+1} is JN
                                
mus{N} = cell( N, 1 );          % Optimal policy, mus{N} is \mu_N-1, ..., mus{1} is \mu_0
                                % mu_k(x,y) provides optimal control action at time k, state x, confidence level y

Js{N+1} = stage_cost( X );      % Initial value function, JN(x,y) = stage_cost(x) for each y

figure(N+1); FigureSettings; mesh( X, L, Js{N+1} ); title('Dynamic programming');

xlabel('State, x'); ylabel('Confidence level, y'); zlabel(['J_', num2str(N), '(x,y)']);

%% Do CVaR-Bellman Recursion

for k = N: -1: 1,  [ Js{k} , mus{k} ] = CVaR_Bellman_Backup( Js{k+1}, X, L, ws, P ); end

%% View Results

for k = N: -1: 1
    
    figure(k); FigureSettings; mesh( X, L, Js{k} ); title('Dynamic programming');
    
    xlabel('State, x'); ylabel('Confidence level, y'); zlabel(['J_', num2str(k-1), '(x,y)']);
    
end



                                                

        
        
