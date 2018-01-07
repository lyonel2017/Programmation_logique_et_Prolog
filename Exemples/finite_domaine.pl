use_module(library(clpfd)).

p1(X,Y) :- X > Y.
p2(X,Y) :- 
    [X,Y] ins -10..10, 
    X #> Y.
