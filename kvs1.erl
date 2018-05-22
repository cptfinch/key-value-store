-module(kvs1).
-export([start/0, store/2, lookup/1]).

start() -> register(kvs1, spawn(fun() -> loop() end)).

store(Key, Value) -> rpc({store, Key, Value}).

lookup(Key) -> rpc({lookup, Key}).

rpc(Q) ->
  kvs1 ! {self(), Q},
  receive
    {kvs1, Reply} ->
      Reply
  end.

loop() ->
  receive
    {From, {store, Key, Value}} ->
      put(Key, {ok, Value}),
      From ! {kvs1, true},
      loop();
    {From, {lookup, Key}} ->
      From ! {kvs1, get(Key)},
      loop()
  end.
