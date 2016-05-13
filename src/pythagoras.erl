-module(pythagoras).
-author("michielstigter").

-export([compute_pythagoras/1]).


compute_pythagoras(N) ->
  [{A, B, C} ||
    A <- lists:seq(1, N),
    B <- lists:seq(1, N),
    C <- lists:seq(1, N),
    A + B + C < N,
    A * A + B * B =:= C * C
  ].