-module(drawing).
-author("michielstigter").

-export([create_canvas/2, canvas/1, draw/2]).

canvas(Canvas) ->
  receive
    {Client, {draw_line, X1, Y, X2, Y}} -> Client ! {self(), ok};
    {Client, {get}} -> Client ! {self(), Canvas};
    {Client, X} -> Client ! {self(), {error, invalid_command, X}}
  end,
  canvas(Canvas)
.

create_canvas(W, H) ->
  spawn(drawing, canvas, [[[32 || _ <- lists:seq(1, W)] || _ <- lists:seq(1, H)]])
.

draw(Canvas, Command) ->
  Canvas ! {self(), Command},
  receive
    {Canvas, X} -> X
  end.