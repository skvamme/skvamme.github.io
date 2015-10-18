-module(demo).
-export([start/0,init/0,loop/0]).

start() -> 
   spawn_link(?MODULE,init,[]).

init() ->
	io:format("Started New Process: ~p~n", [?MODULE]),
	loop().

loop() ->
	receive
		quit -> io:format("~p quits~n",[?MODULE]);
			fragile -> io:formatx("~p got a fragile message~n",[?MODULE]),
			?MODULE:loop();
		Any -> io:format("~p got msg: ~p~n",[?MODULE, Any]),
			?MODULE:loop()
	end.
