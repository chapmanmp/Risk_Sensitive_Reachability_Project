% Script to generate probability distribution of surface runoff into first pond
% Pr{wk = ws(i)} = P(i)
% Fix possible values of wk & expected value of wk to generate P

ws = 38000:1000:48000; %ft^3, possible values of wk

nw = length(ws);

cvx_begin

variables P(nw,1)

    minimize ( 1 )

    subject to
    
        ws*P == 45000; % expected value of wk
        
        P>=0;
        
        P<=1;
        
        sum(P) == 1;
    
cvx_end