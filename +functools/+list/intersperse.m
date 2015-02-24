%INTERSPERSE: Intersperses an input between the elements of a list.
%
%   new_list = intersperse(element, list)
function out = intersperse(element, list)
  import functools.list.foldl1
  out = foldl1(@(x,y) (horzcat(x,element,y)), list);
end
