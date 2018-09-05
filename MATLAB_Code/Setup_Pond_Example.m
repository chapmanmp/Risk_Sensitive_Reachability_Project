%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Set-up script for pond example, time-invariant finite probability distribution
    % wk : average surface runoff rate on [k,k+1), [ft^3/s]
% AUTHOR: Margaret Chapman
% DATE: September 5, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dt = 300;       % Duration of [k, k+1) [sec], 5min = 300sec

T = 4*3600;     % Design storm length [sec], 4h = 4*3600sec
                                    
N = T/dt;       % Time horizon: {0, 1, 2, ..., N} = {0, 5min, 10min, ..., 240min} = {0, 300sec, 600sec, ..., 14400sec}