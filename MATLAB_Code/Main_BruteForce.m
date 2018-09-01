%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes J0(x,y) := min_pi CVaR_y[ COST(x0, ..., xN) | x0 = x, pi ] via enumeration
%   COST(x0, ..., xN) = exp(g(x0)) + ... + exp(g(xN)) "cost_sum" or
%                     = max{ g(xk) : k = 0,...,N } "cost_max"
% DYNAMICS: xk+1 = xk + uk + wk, wk \in {-1, 0, 1} equally probable
% AUTHORS: Margaret Chapman, Donggun Lee, Jonathan Lacotte
% DATE: August 30, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clearvars; clc;

Setup_LTI_Dynamics;             % provides grid, constraint set, probability distribution, time horizon, etc.

type_sum = 1;                   % choose 1 if cost_sum, choose 0 if cost_max (not yet implemented)

J0_Brute_Force = Brute_Force_CVaR( type_sum, xs, ls, ws, P ); 

figure; FigureSettings; mesh( X, L, J0_Brute_Force );

title('Brute force computation'); 
xlabel('State, x'); ylabel('Confidence level, y'); zlabel(['J_0', '(x,y)']);









