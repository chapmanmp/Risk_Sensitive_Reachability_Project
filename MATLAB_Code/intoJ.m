function val = intoJ( x_next, y, r, X, L, J )

[ nl, nx ] = size( X ); % nx = # states in grid, nl = # confidence levels in grid

x_next_index = 1;

for i = 1 : nl-1
    
    yi = L( i, x_next_index ); yiPLUS1 = L( i+1, x_next_index );
    
    if r <= yi/y && r >= yiPLUS1/y %cvx does not like '<='!
        
        slope = ( yiPLUS1*J(i+1, x_next_index) - yi*J(i, x_next_index) )/( yiPLUS1 - yi );
        
        val = yi/y*J(i, x_next_index) + slope*(r - yi/y);
        
        break;
       
    end
    
end

