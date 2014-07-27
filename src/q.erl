%%
%%   Copyright 2012 - 2013 Dmitry Kolesnikov, All Rights Reserved
%%
%%   Licensed under the Apache License, Version 2.0 (the "License");
%%   you may not use this file except in compliance with the License.
%%   You may obtain a copy of the License at
%%
%%       http://www.apache.org/licenses/LICENSE-2.0
%%
%%   Unless required by applicable law or agreed to in writing, software
%%   distributed under the License is distributed on an "AS IS" BASIS,
%%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%   See the License for the specific language governing permissions and
%%   limitations under the License.
%%
%% @description
%%   pure functional queue
-module(q).
-include("datum.hrl").

-export([
   new/0
  ,new/1

  % q - interface
  ,head/1
  ,tail/1
  ,enq/2
  ,deq/1

  ,is_empty/1
  ,length/1
  ,dropwhile/2
]).

%%
%% create new queue
-spec(new/0 :: () -> datum:q()).
-spec(new/1 :: (list()) -> datum:q()).

new() ->
   ?NULL.
new(List) ->
   make_deq_head(erlang:length(List), List).

%%
%% queue head element
-spec(head/1 :: (datum:q()) -> any()).

head({q, _N, _Tail, [Head|_]}) ->
   Head;
head({q, _N, [Head], []}) ->
   Head;
head({q, _N, [_|Tail], []}) ->
   lists:last(Tail);
head(_) ->
   exit(badarg).

%%
%% queue tail
-spec(tail/1 :: (datum:q()) -> datum:q()).

tail(Q) ->
   {_, Tail} = deq(Q),
   Tail.

%%
%% enqueue element
-spec(enq/2 :: (any(), datum:q()) -> datum:q()).

enq(E, {q, N, [_]=Tail, []}) ->
   {q, N + 1, [E], Tail};

enq(E, {q, N, Tail, Head}) ->
   {q, N + 1, [E|Tail], Head};

enq(E, ?NULL) ->
   {q, 1, [E], []}.

%%
%% dequeue element
-spec(deq/1 :: (datum:q()) -> {any(), datum:q()}).

deq({q, _N, [E], []}) ->
   {E, deq:new()};

deq({q, N, [Last|Tail], []}) ->
   [E|Head] = lists:reverse(Tail, []),
   {E, {q, N - 1, [Last], Head}};

deq({q, N, Tail, [E]}) ->
   {E, make_deq_tail(N - 1, Tail)};

deq({q, N, Tail, [E|Head]}) ->
   {E, {q, N - 1, Tail, Head}}.


%%
%% check if the queue is empty
-spec(is_empty/1 :: (datum:q()) -> boolean()).

is_empty(?NULL) ->
   true;
is_empty(_) ->
   false.

%%
%%
length({q, N, _, _}) ->
   N;
length({}) ->
   0.

%%
%% dropwhile head of queue
-spec(dropwhile/2 :: (function(), datum:q()) -> datum:q()).

dropwhile(Pred, {q, _N, _Tail, _Head}=Q) ->
   {Head, Tail} = deq(Q),
   case Pred(Head) of
      true  -> dropwhile(Pred, Tail); 
      false -> Q
   end;

dropwhile(_,  {}) ->
   q:new().

%%%------------------------------------------------------------------
%%%
%%% private
%%%
%%%------------------------------------------------------------------

%%
%% make dequeue from list (supplied list is tail)
make_deq_tail(N, [_]=List) ->
   {q, N, [], List};

make_deq_tail(N, [X,Y]) ->
   {q, N, [X],[Y]};

make_deq_tail(N, [X,Y|List]) ->
   {q, N, [X,Y], lists:reverse(List, [])};

make_deq_tail(_, []) ->
   ?NULL.

%%
%% make dequeue from list (supplied list is head)
make_deq_head(N, [_]=List) ->
   {q, N, List, []};

make_deq_head(N, [X,Y]) ->
   {q, N, [X],[Y]};

make_deq_head(N, [X,Y|List]) ->
   {q, N, lists:reverse(List, []), [X,Y]};

make_deq_head(_, []) ->
   ?NULL.



%%%------------------------------------------------------------------
%%%
%%% private
%%%
%%%------------------------------------------------------------------
