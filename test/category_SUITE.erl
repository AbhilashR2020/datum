%%
%%   Copyright (c) 2016, Dmitry Kolesnikov
%%   All Rights Reserved.
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
%% @doc
%%   category pattern test suite
-module(category_SUITE).
-include_lib("common_test/include/ct.hrl").
-compile({parse_transform, category}).

%%
%% common test
-export([
   all/0
  ,groups/0
  ,init_per_suite/1
  ,end_per_suite/1
  ,init_per_group/2
  ,end_per_group/2
]).

-export([
   f_syntax/1, f_left_id/1, f_right_id/1, f_associativity/1,
   x_syntax/1, x_left_id/1, x_right_id/1, x_associativity/1
]).

%%%----------------------------------------------------------------------------   
%%%
%%% suite
%%%
%%%----------------------------------------------------------------------------   
all() ->
   [
      {group, function}
     ,{group, 'xor'}
   ].

groups() ->
   [
      {function, [parallel], 
         [f_syntax, f_left_id, f_right_id, f_associativity]}

     ,{'xor',  [parallel], 
         [x_syntax, x_left_id, x_right_id , x_associativity]}
   ].

%%%----------------------------------------------------------------------------   
%%%
%%% init
%%%
%%%----------------------------------------------------------------------------   
init_per_suite(Config) ->
   Config.

end_per_suite(_Config) ->
   ok.

%% 
%%
init_per_group(_, Config) ->
   Config.

end_per_group(_, _Config) ->
   ok.


%%%----------------------------------------------------------------------------   
%%%
%%% unit(s) 
%%%
%%%----------------------------------------------------------------------------   

%%
%% function category
f_id(X) ->
   X.

f_m2(X) ->
   X * 2.

f_s5(X) ->
   X + 5.

f_s1(X) ->
   X + 1.

f_syntax(_Config) ->
   10 = [$. || f_id(5), f_m2(_)],
   10 = [$. || f_id(5), fun f_m2/1],
   10 =([$. || f_id(_), f_m2(_)])(5),
   10 =([$. || fun f_id/1, f_m2(_)])(5),
   10 =([$. || fun f_id/1, fun f_m2/1])(5).

f_left_id(_Config) ->
   10 = [$. || f_id(5), fun f_m2/1].

f_right_id(_Config) ->
   10 = [$. || f_m2(5), fun f_id/1].

f_associativity(_Config) ->
   A = [$. || fun f_s5/1, [$. || fun f_s1/1, fun f_m2/1]],
   B = [$. || [$. || fun f_s5/1, fun f_s1/1], fun f_m2/1],
   X = A(5),
   X = B(5).


%%
%% xor category
x_id(X) ->
   {ok, f_id(X)}.

x_m2(X) ->
   {ok, f_m2(X)}.

x_s5(X) ->
   {ok, f_s5(X)}.

x_s1(X) ->
   {ok, f_s1(X)}.

x_syntax(_Config) ->
   {ok, 10} = [$^ || x_id(5), x_m2(_)],
   {ok, 10} = [$^ || x_id(5), fun x_m2/1],
   {ok, 10} =([$^ || x_id(_), x_m2(_)])(5),
   {ok, 10} =([$^ || fun x_id/1, x_m2(_)])(5),
   {ok, 10} =([$^ || fun x_id/1, fun x_m2/1])(5).

x_left_id(_Config) ->
   {ok, 10} = [$^ || x_id(5), fun x_m2/1].

x_right_id(_Config) ->
   {ok, 10} = [$^ || x_m2(5), fun x_id/1].

x_associativity(_Config) ->
   A = [$^ || fun x_s5/1, [$^ || fun x_s1/1, fun x_m2/1]],
   B = [$^ || [$^ || fun x_s5/1, fun x_s1/1], fun x_m2/1],
   X = A(5),
   X = B(5).

