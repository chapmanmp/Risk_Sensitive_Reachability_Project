%% Script to generate probability distribution of surface runoff into first pond
% Pr{wk = ws(i)} = P(i)
% Fix possible values of wk & expected value of wk to generate P

%% Sample mean and moments
mean = 12.16;
variance = 3.22;
skewness = 1.68;
kurtosis = 8.31;

%range of 
ws = mean-2*sqrt(variance):0.5*sqrt(variance):mean+2.5*sqrt(variance); %ft^3/s, possible values of wk

nw = length(ws);

%% calculation feasible probability distribution
cvx_begin

variables P(nw,1)

    minimize ( 1 )

    subject to
    
        ws*P == mean; % expected value of ws
        (ws-mean).^2*P == variance; %variance of ws
        (ws-mean).^3*P == skewness*variance^(3/2); %skewness of ws 
        %(ws-mean).^4*P == kurtosis*variance^2; %kurtosis of ws
        
        P>=0;
        
        P<=1;
        
        sum(P) == 1;
    
cvx_end
