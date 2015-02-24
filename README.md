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


Using functools
---------------

Functools is defined as a Matlab package, which means the functions inside
this package are called a bit differently that normal functions. In order to call the functions, their full namespace must be specified

```matlab
functools.list.head([1 2 3 4])
```

or a function can be imported specifically

```matlab
import functools.list.head
head([1 2 3 4])
```

or an entire subpackage of functions can be imported.

```matlab
import functools.list.*
head([1 2 3 4])
```

If you would like to use the functools functions inside your own function,
the same import rules will apply.

```matlab
function out = add(a, b)
    import functools.list.zipWith2

    out = zipWith2(@plus, a, b);
end
```
