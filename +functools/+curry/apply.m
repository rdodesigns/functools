%APPLY Application operator
%
%  apply(f, x) is the same as f(x) for some function f with input x. Useful
%  in higher order functions.
%
%  This function is curried, see the calling structure below.

function out = apply(f, x)
  import functools.curry.apply;

  narginchk(1, 2);

  switch nargin
    case 1, out = @(x) apply(f, x);
    case 2, out = f(x);
  end

end
