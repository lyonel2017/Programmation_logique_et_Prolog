mere(trude,sally).
mere(trude,eric).
mere(marie,trude).
pere(tom,sally).
pere(tom,erica).
pere(mike,tom).
parent(X,Y) :- pere(X,Y).
parent(X,Y) :- mere(X,Y).
grandpere(X,Y) :- pere(X,P), parent(P,Y).
grandmere(X,Y) :- mere(X,P), parent(P,Y).
frere_ou_soeur(X,Y) :- parent(Z,X), parent(Z,Y), X\=Y.

