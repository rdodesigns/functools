Functools
=========

Functional programming tools for Matlab. It includes the following
subpackages.

- list: list related functions (foldl, foldr, zipWith2, etc)
- curry: higher order functions to change the calling structure of a
         function. This includes `partial`, `rpartial`, and `curry`.
- util: Some useful utility functions that don't fit elsewhere.


Install
-------

Global installation can be done through the user's MATLAB directory. Place
this entire directory in a directory under the `userpath` location (such as
'/home/user/Documents/MATLAB/functools/'). The result will look like so.

```
Documents\
    MATLAB\
        functools\
            README.md
            +functools\
                +curry\
                    ...
                +list\
                    ...
                +util\
                    ...
                ...
```

Now, create or edit the function `Documents/MATLAB/startup.m` (or wherever
your `startup.m` is) to include the following.

```matlab
disp('Adding functools') % not needed but I like the reminder.
addpath('functools')
```

Start a new instance of Matlab and the functools package should be ready to
use.
