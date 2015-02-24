%CURRY Curry a function so that it can be partially applied.
%
%  This converts functions into ones where only a subset of the arguments
%  are applied. For example, say we have a simple add function as follows.
%
%    function out = add(a, b)
%      out = a + b
%    end
%
%  If we curry this function, we apply only some of the arguments are
%  returned a function that takes in the rest.
%
%  >> cadd = curry(add);
%  >> add5 = cadd(5); % add5 is a function of one input
%  >> add5(4)
%  9
%  >> add5(9)
%  14
%  >> inc = curry(add, 1);
%  >> inc(4)
%  5
%  >> inc(9)
%  10
function out = curry(f, varargin)
  import functools.curry.partial
  import functools.curry.curry

  args = varargin;

  try
    out = f(varargin{:});
  catch err

    switch err.identifier
      case 'MATLAB:TooManyInputs'
        rethrow(err)
      case 'MATLAB:minrhs'
        out = @(varargin) curry(partial(f, args{:}), varargin{:});
      otherwise
        rethrow(err)
    end

  end % catch

end % function
