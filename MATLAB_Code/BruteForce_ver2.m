%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Brute force computation of J0(x,y) := min_pi CVaR_y[ sum_k exp(g(xk)) | xk = x, pi ]
% DYNAMICS: x_k+1 = x_k + u_k + w_k, u_k \in {-1, 1}, w_k \in {-1, 0, 1} equally probable
% AUTHORS: Donggun Lee & Margaret Chapman
% DATE: August 30, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clearvars; clc;

dx = 1/10;                                      % State discretization

K_lb = 2; K_ub = 4;                             % Constraint set, K = (2, 4)

xs = K_lb - 1 : dx : K_ub + 1;                  % Discretized states

ls = [ 0.95, 1/2, 0.05 ];                       % Discretized confidence levels

%% Define costs

max_g = @(x) max( flat_g(x,xs) );                       % max{ g(xk) : k = 0, 1, 2 }

sum_exp_g = @(x) sum( exp(flat_g(x,xs)) );              % sum of exponentials, approximates z1

%% Set up

policy_u0 = [-1; 1]; policy_u1 = policy_u0;             % possible values of u_k for k = 0, 1

na = length( policy_u0 );                               % number of possible u_k

possible_w0 = [-1; 0; 1]; possible_w1 = possible_w0;    % possible values of w_k for k = 0, 1

[ X, L ] = meshgrid( xs, ls );

%% Compute CVaR for each policy, each confidence level

for l_index = 1 : length(ls) % for each confidence level
for x_index = 1 : length(xs) % for each x0
        x0 = xs( x_index );
        %cost_realiz = cell( na, na );
        for ii = 1 : na % for each (u0, u1)
        for jj = 1 : na
            for kk = 1 : length(possible_w0) % for each (w0, w1)   
            for ll = 1 : length(possible_w1)
                x1 = x0 + policy_u0(ii) + possible_w0(kk);  
                x2 = x1 + policy_u1(jj) + possible_w1(ll);              % get path (x0, x1, x2)
                cost_realiz{ii,jj}(kk,ll) = sum_exp_g([ x0; x1; x2 ]);  % get cost realization
            end  
            end                       %CVaR of cost realizations at fixed (u0, u1)
        CVaR{l_index, x_index}(ii,jj) = getCVaR( cost_realiz{ii,jj}, ls(l_index) );
        end 
        end              % min_u { CVaR(u) | confidence level, x0 }
    J0(l_index, x_index) = min( min(CVaR{l_index, x_index}) );
end
end
%% View results

figure; mesh( X, L, J0 ); 
title('Brute force'); xlabel('state, x'); ylabel('confidence level, y'); zlabel(['J_0', '(x,y)']);









