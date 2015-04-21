%CELLFILT Filter a cell array given a predicate function p.
%
%  Filters a cell array as a higher order function. This function is
%  curried, see the calling structure below.
%
%  g = cellfilt(p) returns a function g that, given a cell array x filters it
%      using the predicate function p.
%
%  x_filtered = cellfilt(p, x) filters a cell array using a predicate
%      function p.

function out = cellfilt(p, x)

  narginchk(1, 2);

  switch nargin
    case 1, out = @(x) cellfilt(p, x);
    case 2, out = x(cellfun(@(y) p(y), x));
  end

end
