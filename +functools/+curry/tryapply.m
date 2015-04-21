%TRYAPPLY Application operator that captures errors
%
%  tryapply(f, c, x) is the same as f(x) for some function f with input x.
%  However, if an exception is thrown by f, it is captured and returned and
%  given to the function c.
%
%  This function is curried, see the calling structure below.
%
%  g = tryapply(f) returns a function g that, when given an error handler c and
%      value x, performs f(x) or c(err) if an error err occurred.
%  h = apply(f, c) returns a function that takes a value c and does the same as
%      above.
%
%  Note that if flip is used with apply (flip(@apply)) then the result is a
%  continuation passing style computation.
%
%  >> suspended = feval(flip(@apply), 2);
%  >> suspended(@(x) x^2 + 2)
%
%  ans =
%       6

function out = apply(f, c, x)

  narginchk(1, 3);

  switch nargin
    case 1, out = @(c, x) tryapply(f, c, x);
    case 2, out = @(x) tryapply(f, c, x);
    case 3
      try
        out = f(x);
      catch err
        out = c(err);
      end
  end

end
