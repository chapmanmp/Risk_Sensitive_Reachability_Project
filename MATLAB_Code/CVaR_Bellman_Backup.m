%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Performs the CVaR Bellman backwards recursion
% INPUT: 
    % J_k+1 : optimal cost-to-go at time k+1, array
    % X : row of states repeated [ xs; xs; ... ], array
    % L : column of confidence levels repeated [ ls ls ... ], array
% OUTPUT: 
    % J_k : optimal cost-to-go starting at time k, array

% AUTHOR: Margaret Chapman
% DATE: August 24, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function J_k = CVaR_Bellman_Backup( J_kPLUS1, X, L ) 

us = [ -1, 1 ];         % possible control actions

[ nl, nx ] = size( X ); % nx = # states in grid, nl = # confidence levels in grid

J_k = J_kPLUS1;         % initialization

for i = 1 : nx
    
    for j = 1 : nl
        
        x = X(i,j); % state at (i,j)-grid point
        
        y = L(i,j); % confidence level at (i,j)-grid point
        
        maxExp_u1 = maxExp( J_kPLUS1, x, us(1), y, X, L ); 
        
        maxExp_u2 = maxExp( J_kPLUS1, x, us(2), y, X, L );
        
        J_k(i,j) = stage_cost(x) + min( maxExp_u1, maxExp_u2 );
        
    end
    
end