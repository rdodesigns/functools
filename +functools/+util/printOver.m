%PRINTOVER: Write messages over previous command line output.
%
%   buffer = printOver() returns a buffer that can
%       be continually printed over. Note that once a different print
%       command has been used the use of this function is invalid (the
%       results are not predictable).
%
%   buffer = printOver(f) returns a buffer that can be continually printed
%       over by calling f, which must return a string. The original case is
%       a subset of this calling style where f = @(x) x (an echo function).
%       The original design of this was to remove the constant requirement
%       for sprintf in the function call of buffer.
%
%   Example
%   -------
%
%   %% The standard echo string case.
%
%   print_buffer = printOver();
%   for k = 1:100
%     print_buffer(sprintf('%*d %*d', 3, k, 3, k));
%     pause(1/30);
%   end
%   fprintf('\n');
%
%   %% The applied function case
%
%   print_buffer = printOver(@sprintf);
%   for k = 1:100
%     print_buffer('%*d %*d', 3, k, 3, k);
%     pause(1/30);
%   end
%   fprintf('\n')

function out = printOver(f)

  % By default, use echo.
  if nargin == 0
    f = @(x) x;
  end

  reverse_str = '';

  function [] = printOverWithMsg(varargin)
    msg = f(varargin{:});
    assert(ischar(msg), 'printOver:FunctionReturnsNonString', ...
            'printOver attached function must return a string.');

    fprintf('%s%s', reverse_str, msg);
    reverse_str = repmat(sprintf('\b'), 1, length(msg));
  end

  out = @printOverWithMsg;

end
