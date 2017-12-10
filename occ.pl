my_occ(_, [], 0).
my_occ(Elt, [X| Tail], N) :- my_occ(Elt, Tail, N), Elt \= X.
my_occ(Elt, [Elt| Tail],N) :- my_occ(Elt, Tail, M),  N is M+1.
