%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Defines the stage cost as an exponential of the signed distance w.r.t. constraint set, K = (2, 4)
% INPUT: State xk, or state trajectory (x0, x1, ..., xN)
% OUTPUT: Stage cost
% AUTHOR: Margaret Chapman
% DATE: August 24, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function c = stage_cost( x ) 

gx = signed_distance( x );  % signed distance with respect to the constraint set, K = (2, 4)

m = 1;                      % larger m for closer approximation to max, but less numerically stable

c = exp( m*gx );