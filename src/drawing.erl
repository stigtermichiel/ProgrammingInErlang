-module(drawing).
-author("michielstigter").

-export([create_canvas/2, canvas/3, draw/2, test/0]).

canvas(W, H, Canvas) ->
  canvas(W, H,
    receive
      {Client, {draw_line, X1, Y, X2, Y}} ->
        NewCanvas = draw_line(Canvas, X1, Y, X2, Y),
        Client ! {self(), ok},
        NewCanvas;
      {Client, {draw_line, X, Y1, X, Y2}} ->
        NewCanvas = draw_line(Canvas, X, Y1, X, Y2),
        Client ! {self(), ok},
        NewCanvas;
      {Client, {get}} ->
        Client ! {self(), Canvas},
        Canvas;
      {Client, X} ->
        Client ! {self(), {error, invalid_command, X}},
        Canvas
    end).

draw_line(Canvas, X, Y, X, Y) ->
  Canvas#{{X, Y} => "x"};
draw_line(Canvas, X1, Y, X2, Y) when X1 < X2 ->
  draw_line(Canvas#{{X1,Y} => "x"}, X1+1, Y, X2, Y);
draw_line(Canvas, X1, Y, X2, Y) ->
  draw_line(Canvas, X2, Y, X1, Y);
draw_line(Canvas, X, Y1, X, Y2) when Y1 < Y2 ->
  draw_line(Canvas#{{X,Y1} => "x"}, X, Y1+1, X, Y2);
draw_line(Canvas, X, Y1, X, Y2) ->
  draw_line(Canvas, X, Y2, X, Y1).

test() ->
  C = create_canvas(10, 10),
  draw(C, {draw_line, 1, 1, 5, 1}),
  draw(C, {draw_line, 5, 2, 1, 2}),
  draw(C, {get}).

create_canvas(W, H) ->
  spawn(drawing, canvas, [W, H, #{}])
.

draw(Canvas, Command) ->
  Canvas ! {self(), Command},
  receive
    {Canvas, X} -> X
  after
    1000 -> {error, time_out}
  end.