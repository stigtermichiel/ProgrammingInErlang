-module(shop).

%% API
-export([cost/1]).

cost(orange) -> 5;
cost(apple) -> 2;
cost(pear) -> 4;
cost(grapefruit) -> 3.