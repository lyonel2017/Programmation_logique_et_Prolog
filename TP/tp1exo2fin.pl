% Somme des éléments d'une liste.
% On a deux cas :
% - la liste est vide : la somme est 0
my_sum([], 0).
% - la liste contient au moins un élément, il faut calculer la somme du reste
%   de la liste PUIS ajouter la valeur de l'élément de tete :
my_sum([Head | Tail], N) :-
    my_sum(Tail, M),
    N is M + Head. % Rappel : Cette opération est forcément faite
                   % Après le calcul de la somme sur le reste
                   % de la liste car M doit etre instancié.

% Occurrences d'un élément dans une liste.
% On a trois cas :
% - la liste est vide, l'élément est présent 0 fois :
my_occ(_, [], 0).
% - l'élément de tete est celui qu'on cherche, le nombre d'occurrences
%   est le nombre d'occurrences dans le reste de la liste + 1 (l'élément
%   de tete :
my_occ(Elt, [Elt | Tail], N) :-
    !,                 % on n'aura pas d'autre essai à faire pour cette liste
                       % et cet élément précis.
    my_occ(Elt, Tail, M),
    N is M+1.          % encore une fois, on fait le calcul après car M doit
                       % etre connu.
% - l'élément n'était pas l'élément de tete (on en est sur car dans le cas
%   contraire on a coupé dans la clause précédente). Dans ce cas, le nombre
%   d'occurrences est simplement le nombre d'occurrences dans le reste de la 
%   liste :
my_occ(Elt, [_| Tail], N) :-
    my_occ(Elt, Tail, N).

% Liste d'entiers.
% - on veut la liste des 0 premiers entiers :
my_integer_list(0, [0]).
% - on veut la liste des n premiers entiers, sachant qu'on sait (par 
%   construction) produire la liste des n-1 premiers entiers :
my_integer_list(N, L) :-
    N > 0, % on s'assure de ne pas passer dans les négatifs pour ce calcul :
    N_1 is N-1,
    my_integer_list(N_1, L_1),
    append(L_1, [N], L).

% On peut aussi produire une version qui va d'abord descendre avec un paramètre
% supplémentaire et ensuite remonter en ajoutant (et donc sans append):
my_integer_list_2(N, 0, [N]) :- !.
my_integer_list_2(N, M, L) :-
    Sub is M-1,
    my_integer_list_2(N, Sub, LTmp),
    Front is N-M,
    L = [Front|LTmp].

% prédicat inverse (avec append) :
% Encore une fois, deux cas :
% - la liste est vide :
my_reverse([], []).
% - la liste contient au moins un élément, on inverse la liste privé du premier
%   élément puis on ajoute l'élément en queue :
my_reverse([Head | Tail], Inv) :-
    my_reverse(Tail, InvTail),
    append(InvTail, [Head], Inv).

% prédicat inverse (sans append) :
% Le principe est de penser la liste comme une pile et de depiler 
% progressivement une liste en plaçant les éléments dans l'autre.
% Quand on a plus d'éléments, on a terminé et on connait la liste inverse.
% Deux cas, 
% - on a terminé de dépiler :
my_reverse_aux([], Built, Built).
% - on a encore des éléments a placer dans la pile en cours de construction :
my_reverse_aux([Head | Tail], AlreadyBuilt, Unknown) :-
    my_reverse_aux(Tail, [Head | AlreadyBuilt], Unknown).

% et on peut se faire un prédicat utilitaire :
my_fast_rev(L, Inv) :- my_reverse_aux(L, [], Inv).

% Palindrome, version avec reverse :
palindrome(L) :- fast_rev(L,L). % un palindrome est identique a son inverse.

% Palindrome en utilisant append.
% On a deux manière de faire : on peut d'abord considérer que le palindrome 
% est la concaténation de deux chaine inverse. Mais on peut meme se passer
% de inverse en supprimant à chaque fois l'élément de tete et de queue 
% recursivement :
palindrome_app([]). % la chaine vide est un palindrome.
palindrome_app([_]). % de meme que la chaine ne contenant qu'un élément.

% Dernier cas : en virant l'élément de tete et de fin, la chaine
% résultante doit elle meme etre un palindrome.
%                                  [  1    2    3    2    1   ]
palindrome_app([Head | Tail]) :- %   Head [       Tail        ]
    append(Tmp, [Head], Tail),   %   Head [    Tmp    ]  Head 
    palindrome_app(Tmp).
