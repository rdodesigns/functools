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
%
%  The function returned from flip is curried.

function out = flip(f)

  function out = flipped(y, x)

    narginchk(1, 2);

    switch nargin
      case 1, out = @(x) f(x, y);
      case 2, out = f(x, y);
    end

  end

  out = @flipped;

end
