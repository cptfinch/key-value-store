-module(kvs1).
% -export([start/0, store/2, lookup/1]).
-export([start/0]).

start() -> register(kvs1, spawn(
  fun() -> io:fwrite("hello there") end)
  ).
% start() -> register(kvs1, spawn(fun() -> loop() end)).
