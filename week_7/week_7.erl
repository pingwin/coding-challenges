#!/usr/bin/env escript
%% vim: set tabstop=4 :
%% -*- erlang -*-
%%! -sname week_6
-include_lib("stdlib/include/assert.hrl").

encode([], Prev, Count, Acc) ->
	lists:flatten(Acc++io_lib:format("~w~c", [Count, Prev]));

encode([C|T], Prev, Count, Acc) when C == Prev, Count == 9 ->
	encode(T, Prev, 1, Acc++io_lib:format("~w~c", [Count, C]));

encode([C|T], Prev, Count, Acc) when C == Prev ->
	encode(T, Prev, Count+1, Acc);

encode([C|T], Prev, Count, Acc) ->
	encode(T, C, 1, Acc++io_lib:format("~w~c", [Count, Prev])).




encode([C|T]) ->
	encode(T, C, 1, "").


main(_) ->
	lists:foreach(fun({Sample, Expect}) ->
						  Answer = encode(Sample),
						  ?assertEqual(Expect, Answer, "encode")
				  end, [
						{"AAAAAAAAAAAAABBCCCCDD", "9A4A2B4C2D"},
						{"************^^^^^^^$$$$$$%%%%%%%!!!!!!AAAAAAAAAAAAAAAAAAAA","9*3*7^6$7%6!9A9A2A"}
					   ]).



