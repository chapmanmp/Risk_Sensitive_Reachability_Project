%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes the parameters for linear matrix inequalities 
% INPUT: 
    % x : state at time k, real number
    % u : control at time k, real number
    % ws(i) : ith realization of disturbance, real number
    % xs : x values, row vector
    % ls : confidence levels, row vector
    % J_k+1 : optimal cost-to-go at time k+1, array
% OUTPUT: 
    % As{i} & bs{i} are column vectors that encode the linear interpolation of Z*J_k+1( x_k+1, Z ) versus Z, at the ith realization of x_k+1
    % ith realization of x_k+1 = x + u + ws(i)
% NOTE:
    % max_t,Z { t | As{1}(i)*Z + bs{1}(i) >= t } is equivalent to max_Z { g(Z) := min_i As{1}(i)*Z + bs{1}(i) }                                          
    % g(Z) = linear interpolation of Z*J_k+1(x,Z) versus Z, at fixed x; concave & piecewise linear in Z
% AUTHOR: Margaret Chapman
% DATE: August 27, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ As, bs ] = getLMIs( x, u, ws, xs, ls, J_kPLUS1 )

nd = length(ws); % # disturbance realizations

nl = length(ls); % # confidence levels

As = cell(nd, 1); bs = cell(nd, 1); 

for i = 1 : nd % for each disturbance realization
    
    x_kPLUS1 = x + u + ws(i); % get next state realization
    
    Ai = zeros(nl-1,1); bi = zeros(nl-1,1);
        
    for j = 1 : nl-1 % for each confidence level line segment, [z_j, z_j+1]
        
        % Vq = interp1(X,V,Xq,'linear') interpolates to find Vq, the values of the underlying function V=F(X) at the query points Xq. 
        J_j = interp1( xs, J_kPLUS1(j,:), x_kPLUS1, 'linear'); 
        % approximates J_k+1(x_k+1, z_j) via J_k+1(xL, z_j) and J_k+1(xU, z_j), xL <= x_k+1 <= xU
        
        J_jPLUS1 = interp1( xs, J_kPLUS1(j+1,:), x_kPLUS1, 'linear'); 
        % approximates J_k+1(x_k+1, z_j+1) via J_k+1(xL, z_j+1) and J_k+1(xU, z_j+1), xL <= x_k+1 <= xU
                
        Ai(j) = ( ls(j+1)*J_jPLUS1 - ls(j)*J_j )/( ls(j+1) - ls(j) ); % approx slope of Z*J_k+1( x_k+1, Z ) versus Z
        
        bi(j) = ls(j) * (J_j - Ai(j));                                % approx y-intersept of Z*J_k+1( x_k+1, Z ) versus Z
        
    end
    
    As{i} = Ai; bs{i} = bi;
    
end