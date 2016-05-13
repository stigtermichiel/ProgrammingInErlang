-module(e6).
-author("michielstigter").

-export([read/1, map_search_pred/2]).


read(File) ->
  case file:read_file(File) of
    {ok, Bin} -> Bin;
    {error, Why} -> throw(Why)
  end.

map_search_pred(Map, Pred) ->
  case [{X, V} || {X, V} <- maps:to_list(Map), Pred(X, V)] of
    [H | _] -> H
  end.



