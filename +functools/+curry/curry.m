%CURRY Curry a function so that it can be partially applied.
%
%  This converts functions into ones where only a subset of the arguments
%  are applied. For example, say we have a simple add function as follows.
%
%    function out = add(a, b)
%        out = a + b
%    end
%
%  If we curry this function, we apply only some of the arguments are
%  returned a function that takes in the rest.
%
%  Example
%  -------
%  cadd = curry(add);
%  add5 = cadd(5); % add5 is a function of one input
%  add5(4) % 9
%  add5(9) % 14
%
%  inc = curry(add, 1);
%  inc(4) % 5
%  inc(9) % 10
%
%
%  Writing curried functions
%  -------------------------
%
%  It can be very helpful to write a function such that it is curried by
%  default. Let's walk through how to do this by walking through an example
%  of making an addition function in the file `add.m`. The initial uncurried
%  implementation is the following.
%
%      function out = add(a, b)
%          out = a + b;
%      end
%
%  To curry this function by default we need to call the curry function
%  before the calling the addition function. We can do this by moving the
%  definition of add to another function named `add_definition` and inside
%  `add` curry the `add_definition` function, like the following version
%  of `add.m`.
%
%      function out = add(varargin)
%          import functools.curry.curry
%
%          out = curry(add_definition, varargin{:});
%      end
%
%      function out = add_definition(a, b)
%          out = a + b;
%      end
%
%  Now Add can be used in the curry form.
%
%  feval(add(4), 5) % 9
%
%  Note that any error thrown inside the curried function will be percolated
%  up to the user once they provide a minimal set of arguments to call the
%  function, should an error occur.

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
