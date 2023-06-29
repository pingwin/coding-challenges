#!/usr/bin/env escript
%% -*- erlang -*-
%%! -sname week_5
-include_lib("stdlib/include/assert.hrl").

-export([find_shortest_sum/2]).

% detailed implementation for this sum function
-spec sum(list(), integer(), integer(), integer()) -> integer().
sum([H|_T], Carried, Count, Limit) when (Carried+H) >= Limit ->
	Count+1;
sum([H|T], Carried, Count, Limit) ->
	sum(T, Carried + H, Count+1, Limit);
sum([], _, _, _) ->
	0.

% Simplified caller for sum function
-spec sum(list(), integer()) -> integer().
sum(Data, Limit) ->
	sum(Data, 0, 0, Limit).


% walk over the list finding the smallest non-zero sum
-spec walk_list(list(), integer(), integer()) -> integer().
walk_list([_|T], Limit, Acc) ->
	Acc1 = case sum(T, Limit) of
		X when X < Acc andalso X > 0 -> X;
		_ -> Acc
	end,
	walk_list(T, Limit, Acc1);

walk_list([], _, Acc) ->
	Acc.

% Simplified caller for walking to solve the challenge
-spec find_shortest_sum(list(integer()), integer()) -> integer().
find_shortest_sum(Data, Limit) ->
	Acc0 = sum(Data, Limit),
	walk_list(Data, Limit, Acc0).

main(_) ->
	lists:foreach(fun({Name, S, Expected, Data}) ->
						Answer = find_shortest_sum(Data, S),
						?assertEqual(Expected, Answer, Name)
				end, [
						% (name, s, answer, data),
						{"1", 7, 2, [2, 1, 5, 2, 3, 2]},
						{"2", 7, 1, [2, 1, 5, 2, 8]},
						{"3", 8, 3, [3, 4, 1, 1, 6]},
						{"Return 0 if no such subarray exists", 9, 0, [4, 1, 1, 1]}
				]).
