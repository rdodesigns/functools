%APPLY Application operator
%
%  apply(f, x) is the same as f(x) for some function f with input x. Useful
%  in higher order functions.
%
%  This function is curried, see the calling structure below.
%
%  g = apply(f) returns a function g that, when given a value x, performs f(x).
%  val = apply(f, x) returns f(x)
%
%  Note that if flip is used with apply (flip(@apply)) then the result is a
%  continuation passing style computation.
%
%  >> suspended = feval(flip(@apply), 2);
%  >> suspended(@(x) x^2 + 2)
%
%  ans =
%       6

function out = apply(f, x)
  import functools.curry.apply;

  narginchk(1, 2);

  switch nargin
    case 1, out = @(x) apply(f, x);
    case 2, out = f(x);
  end

end
