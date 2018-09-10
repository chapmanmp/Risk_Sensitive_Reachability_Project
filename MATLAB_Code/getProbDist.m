%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Generates finite probability distribution of surface runoff rate [ft^3/s] into pond
% INPUT: 
    % ws(i): = ith possible value of wk
% OUTPUT: 
    % P(i): probability that wk = ws(i)
% AUTHOR: Margaret Chapman
% DATE: September 5, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function P = getProbDist( ws )

nw = length(ws);

cvx_solver sdpt3;

cvx_begin

    variables p(nw,1)

        maximize ( p(2)+p(nw-3)+p(nw-2)+p(nw-1)+p(nw) ) % fat tail

        subject to
    
            ws*p == 10; % expected value of wk [ft^3/s]
        
            p>=0.01;
        
            p<=1;
        
            sum(p) == 1;
    
cvx_end

P = p;