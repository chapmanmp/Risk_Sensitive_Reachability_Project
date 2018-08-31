%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Computes CVaR of a discrete cost Z, where P(Z = zi) = 1/9
% INPUT: 
    % array_of_samples(i,j): one sample, real number 
    % alpha: confidence level, real number
% OUTPUT: 
    % CVaR(Z) at confidence level alpha
% AUTHOR: Donggun Lee and Margaret Chapman
% DATE: August 30, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function CVaR = getCVaR( array_of_samples, alpha )

zis = array_of_samples(:);  % zis(j): one sample

N = length(zis);            % number of samples

p = 1/9;                    % each sample has a probability of 1/9 occurring 

cvx_begin

    variable c(1,1)
    
        cost = c;
        
        for i = 1 : N, cost = cost + 1/alpha * max( zis(i) - c, 0 ) * p; end
            
        minimize( cost ) 

cvx_end

CVaR = cvx_optval;
