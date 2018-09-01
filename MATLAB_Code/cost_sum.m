%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION:  Returns sum of exponentials, exp(g(x0)) + exp(g(x1)) + ... + exp(g(xN)); g(x) = signed distance w.r.t. constraint set, K = (2,4)
%               Approximates max{ g(xk) : k = 0, 1, ..., N }
% INPUT: State trajectory (x0, x1, ..., xN), xk is a real number
% OUTPUT: Sum of exponentials (real number)
% AUTHOR: Margaret Chapman
% DATE: August 31, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cost = cost_sum( x )

cost = sum( stage_cost(x) );