%COMPLEMENT Negate a predicate function.
%
%  not_pred = complement(pred) returns a function that negates the output
%      of the predicate function pred.

function out = complement(f)
  out = @(varargin) ~f(varargin{:});
end
