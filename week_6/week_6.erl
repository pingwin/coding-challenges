#!/usr/bin/env escript
%% -*- erlang -*-
%%! -sname week_6
-include_lib("stdlib/include/assert.hrl").

-spec compare(atom(), integer(), integer()) -> boolean().
compare(asc,  L, R) -> L =< R;
compare(desc, L, R) -> L >= R.

-spec bubble_sort_single_pass(atom(), list(integer()), list(integer()), boolean()) -> {list(integer()), boolean()}.
% list iteration is complete, return Acc with boolean indicating if mutated
bubble_sort_single_pass(_Direction, [], Acc, Changed) ->
  {Acc, Changed};

% start with empty Acc
bubble_sort_single_pass(Direction, [H,N|Tail], [], Changed) ->
  case compare(Direction, H, N) of
    true  -> bubble_sort_single_pass(Direction, Tail, [H, N], Changed);
    false -> bubble_sort_single_pass(Direction, Tail, [N, H], true)
  end;

% iterate over remaining elements
bubble_sort_single_pass(Direction, [H|Tail], Acc, Changed) ->
  Last = lists:last(Acc),
  case compare(Direction, Last, H) of
    true  -> bubble_sort_single_pass(Direction, Tail, Acc ++ [H], Changed);
    false -> bubble_sort_single_pass(Direction, Tail, lists:droplast(Acc) ++ [H, Last], true)
  end.

-spec bubble_sort(atom(), list(integer())) -> list(integer()).
bubble_sort(Direction, List) ->
  case bubble_sort_single_pass(Direction, List, [], false) of
    {PartialySorted, true} -> bubble_sort(Direction, PartialySorted);
    {Sorted, false} -> Sorted
  end.

main(_) ->
  lists:foreach(fun({Direction, Test, Expected}) ->
            Answer = bubble_sort(Direction, Test),
            ?assertEqual(Expected, Answer, Direction)
        end, [
            % (direction, test, expected),
            {asc, [8, 5, 2, 9, 5, 6, 3], [2, 3, 5, 5, 6, 8, 9]},
            {desc, [8, 5, 2, 9, 5, 6, 3], [9, 8, 6, 5, 5, 3, 2]}
        ]).
