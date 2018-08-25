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

nd = 2; % # of possible values that disturbance can take on

w = [ -1; 1 ]; % possible values of the disturbance

p = [ 1/2; 1/2 ]; % p(j) = probability that w(j) occurs

cvx_begin

    variable R(nd,1)
    
    % intoJ does not work. cvx does not like line search over r
    maximize(  R(1)*p(1)*intoJ( x+u+w(1), y, R(1), X, L, J_kPLUS1 ) + R(2)*p(2)*intoJ( x+u+w(2), y, R(2), X, L, J_kPLUS1 ) )
    
    subject to
    
        R <= 1/y;
    
        R >= 0;
    
        R'*p == 1;
    
cvx_end

bigexp = cvx_optval;