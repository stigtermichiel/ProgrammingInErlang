-module(geometry1).
-author("michielstigter").

%% API
-export([test/0, area/1]).

test() ->
  12 = area({rectangle, 4, 3}),
  100 = area({square, 10}),
  tests_worked.

area({rectangle, Width, Height}) -> Width * Height;
area({square, Side}) -> Side * Side.