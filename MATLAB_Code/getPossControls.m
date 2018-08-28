%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Returns possible control actions given current state
% INPUT: 
    % x : current state (real number)
    % xs : discretized state space (array)
% OUTPUT:
    % us : possible control actions at current state (array)
% NOTE: Need to revise for dx not equal to 1

% AUTHOR: Margaret Chapman
% DATE: August 28, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function us = getPossControls( x, xs )

na = 2;                     % two possible control actions at each time point

if x <= min(xs) + 1         % if x = 1 or 2, set u = +1 to stay in grid (regardless of disturbance)
    
    us = ones(na,1);

elseif x >= max(xs) - 1   % if x = 4 or 5, set u = -1 to stay in grid (regardless of disturbance)
    
    us = -ones(na,1);
    
else                        % otherwise, allow u to take on -1 or 1
    
    us = [-1; 1];
    
end


