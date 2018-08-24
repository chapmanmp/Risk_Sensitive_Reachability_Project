%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Defines the stage cost in terms of the signed distance with respect to the constraint set
% INPUT: System state x (real number)
% OUTPUT: Stage cost (real number)

% AUTHOR: Margaret Chapman
% DATE: August 24, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function c = stage_cost( x ) 

gx = abs( x - 3 ) - 1; % signed distance with respect to the constraint set, K = (2, 4)

m = 1;                 % larger m for closer approximation to max, but less numerically stable

c = exp( m*gx );