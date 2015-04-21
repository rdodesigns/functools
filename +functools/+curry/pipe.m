%PIPE Compose functions together.
%
% Composes any number of functions together. For example, the command
% pipe(h, g, f) returns a function that performs the calculation
% h(g(f(x))) for some input x.

function out = pipe(varargin)

  %% Rename the input functions, flip them to get the order for correct
  %  for loop in piped function.
  fs = varargin;
  fs = fliplr(fs);

  %% Pull out the first function as we will allow it to have
  %  multiple inputs.
  f = fs{1};
  fs = fs(2:end);

  %% The function returned that performs the composition operation.
  function out = piped(varargin)
    out = f(varargin{:});

    for g = fs
      % Have to take the function handle out of the cell array. T_T
      g = g{1};
      out = g(out);
    end
  end

  out = @piped;
end
