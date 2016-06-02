-module(cli).
-author("edwardpond").

-export([cli/1, test/0]).

cli(CanvasPid) ->
  Input = io:read("Enter command: "),
  case Input of
    {ok, q} -> io:format("bye bye o/~n");
    {ok, Command} ->
      Result = drawing:draw(CanvasPid, Command),
      io:write(Result),
      cli(CanvasPid);
    _ -> io:format("get out of my garden.~n"),
      cli(CanvasPid)
  end.

%% fyi. some comment.

test() ->
  C = drawing:create_canvas(20, 20),
  cli(C).