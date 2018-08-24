%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Main script for risk-sensitive reachability computations
% AUTHOR: Margaret Chapman
% DATE: August 24, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clearvars; clc;

% Example for state space = the real line

dx = 1;                                         % State discretization

K_lb = 2; K_ub = 4;                             % Constraint set, K = (2, 4)

xs = K_lb - dx : dx : K_ub + dx;                % Discretized states

ls = [ 0.95, 1/2, 0.05 ];                       % Discretized confidence levels

[ X, L ] = meshgrid( xs, ls );

N = 2;                                          % Time horizon is {0, 1, ..., N}. (x0, x1, ..., xN) is a sample path.

Js = cell( N+1, 1 );                            % Contains optimal cost functions to be solved via DP recursion
                                                % Js{1} is J0, Js{2} is J1, ..., Js{N+1} is JN

Js{N+1} = stage_cost( X );                      % JN(x,y) = stage_cost(x) for each y

%% 
for k = N: -1: 1
    
    Js{k} = CVaR_Bellman_Backup( Js{k+1}, X, L );
    
end
                                                

        
        
