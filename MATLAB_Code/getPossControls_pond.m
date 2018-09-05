%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION: Returns possible control actions given current state
% INPUT: 
    % x : current state (real number)
    % xs : discretized state space (array)
    % ws : possible disturbance values (array)
    % dt : Duration of [k, k+1) 
    % A : surface area of pond 
% OUTPUT:
    % us : possible control actions at current state (array)

% AUTHOR: Margaret Chapman
% DATE: September 5, 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function us = getPossControls_pond( x, xs, ws, dt, A )

na = 2;                         % two possible control actions at each time point

BIG_STEP = dt / A * max(ws);    % largest | x_k+1 - x_k |

if x > max(xs) - BIG_STEP
    
   us = ones(na,1);             % set u = 1 (let water out of pond, reduce x) to stay in grid (does not work, sys will always step outside the grid)

else
    
   us = [0; 1];                 % otherwise, allow u = 0 or 1
    
end


