%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Provides U(y,r), S(y,r) at given confidence level y, risk level r
    % U(y,r) := { x | min_pi CVaR_y[ exp(m*g(x0)) + ... + exp(m*g(xN)) | x0 = x, pi ] < exp(m*r) }
    % S(y,r) := { x | min_pi CVaR_y[ max{ g(x0), ..., g(xN) }          | x0 = x, pi ] < r        }
    % U(y,r) is a subset of S(y,r)
    % g is the signed distance function w.r.t constraint set, K = (2,4)
% INPUT:
    % l_index: index of confidence level
    % ls: discretized confidence levels, vector
    % xs: discretized states, vector
    % r: risk level
    % m: soft-max parameter
    % J0_cost_sum(l_index, x_index) = min_pi CVaR_y[ exp(m*g(x0)) + ... + exp(m*g(xN)) | x0 = x, pi ]
    % J0_cost_max(l_index, x_index) = min_pi CVaR_y[ max{g(x0), ..., g(xN)}        | x0 = x, pi ]
        % at y = ls(l_index), x = xs(x_index)
% OUTPUT: 
    % U_r{l_index} = U(y,r), y = ls(l_index)
    % S_r{l_index} = S(y,r), y = ls(l_index)
% AUTHOR: Margaret Chapman
% DATE: August 30, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ U_r, S_r ] = getRiskySets( ls, xs, r, m, J0_cost_sum, J0_cost_max )

nl = length(ls); % # discretized confidence levels

U_r = cell(nl, 1); S_r = U_r;

figure; FigureSettings;

for l_index = 1 : length(ls)
    
    U_ry = []; S_ry = []; y = ls(l_index);

    for x_index = 1 : length(xs)
    
        if J0_cost_sum(l_index, x_index) < exp(m*r),    U_ry = [ U_ry, xs(x_index) ]; end
    
        if J0_cost_max(l_index, x_index) < r,           S_ry = [ S_ry, xs(x_index) ]; end
    
    end

    plot(U_ry, ones(size(U_ry))*y, '*r'); U_r{l_index} = U_ry; hold on;
    
    plot(S_ry, ones(size(S_ry))*y, 'ob'); S_r{l_index} = S_ry; hold on;

end

legend('U(r,y)','S(r,y)'); xlabel('State, x'); ylabel('Confidence level, y'); title(['r = ', num2str(r)]);
    



