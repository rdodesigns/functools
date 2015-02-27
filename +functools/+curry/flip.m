%FLIP Flip the input arguments to a function.
%
%  Takes the inputs to a function and flips them around. For example, for
%  the following function
%
%  f = @(x, y) x^2 + y
%
%  Then the function g = flip(f) is equivalent to
%
%  g = @(y, x) x^2 + y
%
%  This is mostly useful for higher order functions and for partial
%  application.

function g = flip(f)
  g = @(y, x) f(x, y);
end
