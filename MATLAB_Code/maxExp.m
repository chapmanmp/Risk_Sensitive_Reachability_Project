%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes max over R \in risk envelope of E[ R*J_k+1( x_k+1, y*R ) | x_k, y, u_k ]
%              Uses Chow 2015 linear interpolation method on confidence level
%              Uses change of variable, Z := y*R 
% INPUT: 
    % J_k+1 : optimal cost-to-go at time k+1, array
    % x : state at time k, real number
    % u : control at time k, real number
    % y : confidence level at time k, real number
    % xs : x values, row vector
    % ls : confidence levels, row vector
% OUTPUT: 
    % approximation of maximum over R \in risk envelope of E[ R*J_k+1( x_k+1, y*R ) | x_k, y, u_k ]
% AUTHOR: Margaret Chapman
% DATE: August 24, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bigexp = maxExp( J_kPLUS1, x, u, y, xs, ls )

nd = 3; % # of possible values that disturbance can take on

ws = [ -1; 0; 1 ]; % possible values of the disturbance

P = [ 1/3; 1/3; 1/3 ]; % p(j) = probability that w(j) occurs

[ As, bs ] = getLMIs( x, u, ws, xs, ls, J_kPLUS1 ); % As{1} & bs{1} are column vectors; 
% Each LMI encodes the linear interpolation of Z*J_k+1( x_k+1, Z ) versus Z, at fixed x_k+1

cvx_begin

    variables Z(nd,1) t(nd,1)
    
    maximize( P' * t / y )
    
    subject to
                                     % one LMI per disturbance realization (equivalently, per next state realization)
        As{1}*Z(1) + bs{1} >= t(1);  % column vector * scalar + column vector
        
        As{2}*Z(2) + bs{2} >= t(2);  
        
        As{3}*Z(3) + bs{3} >= t(3);
    
        Z <= 1;
    
        Z >= 0;
    
        P' * Z == y;
    
cvx_end

bigexp = cvx_optval;