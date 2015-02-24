%TEE: A buffered pipe. Similar in concept to the UNIX tee command.
%
%   tee acts as a buffered pipe. It captures its input and returns it as the
%   output. The buffer is a horizontal cell array of the inputs, allowing
%   any type to be captured. Even a series of inputs of different types can
%   be captured!
%
%   This is not thread safe! Do not use with the parallel toolbox! I would
%   need a semaphore, if MATLAB ever provided one. But they suck.
%
%   Creating a new tee buffer
%   -------------------------
%
%   t = tee() returns a new unbounded buffered pipe function.
%   t = tee(buffer_size) returns a new bounded buffered pipe function. A
%       buffer size of 0 is a bit silly but it means that you capture
%       nothing.
%
%
%   Using the tee buffer
%   --------------------
%
%   t(input) captures an input into the internal buffer.
%
%   input = t(input) captures the input and returns a copy as the output.
%
%   [input, buffer] = t(input) captures the current input and returns both
%       the current input and the current buffer.
%
%   [~, buffer] = t() returns just the buffer without adding anything.
%
%
%   Convert cell arrays into regular matrices
%   ------------------------------------------
%
%   If the tee was holding a series of matrices (for example, a time
%   series), this can be converted into a block matrix using the following
%   commands. Note that this only works when all of the captured inputs are
%   of the same type.
%
%       [~, buffer] = t();
%       time_series = horzcat(buffer{:});

function t = tee(buffer_size)

  if nargin == 1
    try
      catchInputErrors(buffer_size);
    catch err
      error(err.identifier, err.message);
    end
  else
    buffer_size = inf;
  end

  t = teeclosure(buffer_size);

end


function closure = teeclosure(buffer_size)
  buffer = {};
  closure = @teec;

  function [out, current_buffer] = teec(in)

    current_buffer = buffer;

    % If we don't have an input, just return the current buffer. This is a
    % common use pattern to obtain the current buffer.
    if nargin == 0
      out = [];
      return
    end

    % If we don't have a buffer, then the function is a silly pipe!
    if buffer_size == 0
      out = in;
      return
    end

    if isfinite(buffer_size)
      % Chop off the first few elements before appending the new one.
      if length(buffer) >= buffer_size
        % The chopping statement is written using the length of the buffer
        % in case someone attempts to use tee in a threaded environment.
        buffer = buffer(length(buffer) - buffer_size + 2 : end);
      end
    end

    % Since we had an input and non-zero buffer, concatenate input and
    % return.
    buffer = [buffer, {in}];

    out = in;
    current_buffer = buffer;

  end % end function teec

end % end function teeclosure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Support Functions                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = catchInputErrors(buffer_size)

  if ~isnumeric(buffer_size)
    error('tee:NonNumericBufferSize', 'Buffer size must be numeric');
  end

  if buffer_size < 0
    error('tee:NegativeBufferSize', 'Buffer size must be positive');
  end

  if (buffer_size ~= floor(buffer_size))
    error('tee:FloatBufferSize', 'Buffer size must be an integer');
  end

end
