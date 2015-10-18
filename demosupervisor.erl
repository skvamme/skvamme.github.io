-module(demosupervisor).


-export([start/0,init/0,loop/1]).

start() -> 
   spawn(?MODULE,init,[]).

init() ->
	io:format("Started New Process: ~p~n", [?MODULE]),
	process_flag(trap_exit, true),
	Pid = demo:start(),
	register(demo,Pid),
	loop(Pid). 

loop(Pid) ->
	receive
		{'EXIT', Pid, Why} -> io:format("In supervisor, demo exit reason: ~p~n",[Why]),
			Pid1 = demo:start(),
			register(demo,Pid1),
			?MODULE:loop(Pid1);
		Any -> io:format("~p got msg: ~p~n",[?MODULE, Any]),
			?MODULE:loop(Pid)
	end.
