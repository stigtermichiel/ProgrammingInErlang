-module(totalcalc).
-author("michielstigter").

%% API
-export([total/1]).


test() =

total([{What, HowMany} | Tail]) -> shop:cost(What) * HowMany + total(Tail);
total([]) -> 0.