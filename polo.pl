operator(OP) :-
    OP =:= "+" ;
    OP =:= "-" ;
    OP =:= "/" ;
    OP =:= "*".

eval("+", X1, X2, RES) :- RES is X1+X2.
eval("-", X1, X2, RES) :- RES is X1-X2.
eval("/", X1, X2, RES) :- RES is X1/X2.
eval("*", X1, X2, RES) :- RES is X1*X2.

polo([],[Result],Result).
polo([OP|Exp_Tl], [X2, X1 |Stack], Result) :-
    operator(OP), !,
    eval(OP, X1, X2, Top),
    polo(Exp_Tl, [Top|Stack], Result).
polo([N|Exp_Tl], Stack, Result) :-
    polo(Exp_Tl, [N|Stack], Result).

%==============================================

%% polo_op([],[R],R).

%% polo_op([N|Exp_Tl], Stack, Res) :-
%%     number(N), !,
%%     polo_op(Exp_Tl, [N|Stack], Res).

%% polo_op([OP|Exp_Tl], [X2,X1|Stack], Res) :-
%%     Expr =.. [OP, X1, X2],
%%     Top is Expr,
%%     polo_op(Exp_Tl, [Top|Stack], Res).
