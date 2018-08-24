%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes max over R \in risk envelope of E[ R*J_k+1( x_k+1, y*R ) | x_k, y, u_k ]
% INPUT: 
    % J_k+1 : optimal cost-to-go at time k+1, array
    % x : state at time k, real number
    % u : control at time k, real number
    % y : confidence level at time k, real number
    % X : row of states repeated [ xs; xs; ... ], array
    % L : column of confidence levels repeated [ ls ls ... ], array
% OUTPUT: 
    % maximum over R \in risk envelope of E[ R*J_k+1( x_k+1, y*R ) | x_k, y, u_k ]

% AUTHOR: Margaret Chapman
% DATE: August 24, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bigexp = maxExp( J_kPLUS1, x, u, y, X, L )

nd = 3; % # of possible values that disturbance can take on

w = [ -1; 0; 1 ]; % possible values of the disturbance

p = [ 1/3; 1/3; 1/3 ]; % p(j) = probability that w(j) occurs

cvx_begin

    variable R(nd,1)
    
    maximize( R'*[0.1; 4; -0.7] ) % need to write the objective function!
    
    subject to
    
        R <= 1/y;
    
        R >= 0;
    
        R'*p == 1;
    
cvx_end

bigexp = cvx_optval;