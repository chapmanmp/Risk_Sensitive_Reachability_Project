%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Main script for risk-sensitive reachability computations
% AUTHOR: Margaret Chapman
% DATE: August 24, 2018

% One-dimensional dynamics example: x_k+1 = x_k + u_k + w_k
%                                   w_k \in {-1, 0, 1}, equally probable
%                                   u_k \in {-1, 1}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clearvars; clc;

dx = 1/4;                                       % State discretization

K_lb = 2; K_ub = 4;                             % Constraint set, K = (2, 4)

xs = K_lb - 1 : dx : K_ub + 1;                  % Discretized states

ls = [ 0.95, 1/2, 0.05 ];                       % Discretized confidence levels

[ X, L ] = meshgrid( xs, ls );

N = 2;                                          % Time horizon is {0, 1, ..., N}. (x0, x1, ..., xN) is a sample path.

Js = cell( N+1, 1 );                            % Contains optimal cost functions to be solved via DP recursion
                                                % Js{1} is J0, Js{2} is J1, ..., Js{N+1} is JN

Js{N+1} = stage_cost( X );                      % Initialization, JN(x,y) = stage_cost(x) for each y

figure(N+1); mesh( X, L, Js{N+1} ); xlabel('state, x'); ylabel('confidence level, y'); zlabel(['J_', num2str(N), '(x,y)']);

for k = N: -1: 1 
    
    Js{k} = CVaR_Bellman_Backup( Js{k+1}, X, L ); 
    
    figure(k); mesh( X, L, Js{k} ); xlabel('state, x'); ylabel('confidence level, y'); zlabel(['J_', num2str(k-1), '(x,y)']);

end

%% Brute Force implementation by Donggun


                                                

        
        
