%FOLDR1: Same as foldr but does not need an initial value.
%
%   See also FOLDR, FOLDR, FOLDR1, BUFFERFOLDL, BUFFERFOLDR

function out = foldr1(accumulator, list)
  import functools.list.foldr1

  switch nargin
    case 1
      out = @(list) foldr(accumulator, list(1), list(2:end));
    otherwise
      out = foldr(accumulator, list(1), list(2:end));
  end

end
