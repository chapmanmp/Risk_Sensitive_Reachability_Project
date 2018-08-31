function gx = flat_g( x, xs )

g = @(x) abs(x-3)-1;  % Signed distance w.r.t K = (2,4)

gx = g(max(xs)).*(x > max(xs)) + g(min(xs)).*(x < min(xs)) + g(x).*(x >= min(xs) & x <= max(xs));  


