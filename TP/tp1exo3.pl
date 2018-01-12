% Tri par insertion.
% Principe : on va prendre tous les éléments d'une liste et on va 
% progressivement les ajouter en maintenant les éléments triés.

% D'abord on a besoin d'un prédicat capable d'insérer trié.
% On a trois cas,
% - la liste est vide :
insert(X, [], [X]).
% - on a trouvé le premier élément plus grand que nous dans la liste,
%   on s'insère en tete :
insert(X, [Head | Tail], [X, Head | Tail]) :-
    X =< Head,
    !. % si on ne cut pas, l'autre clause est valide.
% - on doit aller plus loin car on n'a pas déclenché la clause précédente :
insert(X, [Head | Tail], [Head | NewTail]) :-
    insert(X, Tail, NewTail). % l'appel récursif génère une nouvelle queue
                              % avec X inséré dedans.

% Une fois le prédicat d'insertion écris, on peut produire notre tri :
% - la liste est vide, rien à faire :
insertion_sort([],[]).
% - il y a un élément en tete, on doit produire le tri du reste de la liste,
%   et insérer notre élément dans cette version triee du reste :
insertion_sort([Head | Tail], Sorted) :-
    insertion_sort(Tail, SortedTail),
    insert(Head, SortedTail, Sorted).

% Tri par sélection :
% Principe : on va chercher le minimum de la liste et on le met au début de la 
% version triée.
%
% On a donc besoin de trois prédicats : la recherche du minimum, la suppression
% d'un élément, le tri.
%
% Minimum, deux cas :
% - la liste contient un unique élément :
minimum([X], X).
% - l'élément de tete est le plus petit :
minimum([Head | Tail], Head) :-
    minimum(Tail, MinInTail),
    Head < MinInTail, 
    !. % on doit couper pour ne pas essayer la clause suivante.
% - l'élément de tete n'est pas le plus petit :
minimum([_ | Tail], Min) :-
    minimum(Tail, Min).

% Enlevement.
% Note : on ne veut pas enlever tous les éléments qui correspondent. Puisque
% s'il est présent plusieurs fois, il faudra l'ajouter plusieurs fois pendant
% le tri.
% On a trois cas,
% - la liste est vide : rien a enlever :
remove_first(_, [], []).
% - l'élément de tete est celui qu'on doit enlever :
remove_first(X, [X | Tail], Tail) :- !. % on coupe car on a trouvé l'élément, 
                                        % comme dans le prédicat occ.
% - l'élément de tete est différent (par le cut précédent) :
remove_first(X, [Head | Tail], [Head | NewTail]) :-
    % on supprime X dans le reste de la liste
    remove_first(X, Tail, NewTail).

% Tri par sélection, deux cas,
% - la liste est vide, rien à faire :
selection_sort([],[]).
% - sinon, on trouve le minimum qu'on enlève à la liste, et qu'on ajoute
%   a la version triée de cette liste amputée :
selection_sort(L, [Min| SortedRest]) :-
    minimum(L, Min),
    remove_first(Min, L, Rest),
    selection_sort(Rest, SortedRest).


% Tri fusion :
% Principe : on divise recursivement la liste en deux, on tri chacune des deux 
% listes puis on fusionne les résultats en bon ordre.

% On a besoin de trois prédicats : la division, la fusion et le tri.

% Division, trois cas,
% - liste vide, rien à diviser :
divide([],[],[]).
% - un élément, on génère une liste contenant l'élément et une liste vide :
divide([X],[X],[]).
% - au moins deux éléments, il s'agit alors de diviser le reste de la liste
%   en deux nouvelles listes et d'ajouter chaque élément à l'une des deux :
divide([X1,X2 | Tail], [X1 | Tail1], [X2 | Tail2]) :-
    divide(Tail, Tail1, Tail2).

% Fusion, le principe est de prendre deux liste et de fusionner les éléments
% dans une troisième en maintenant le tri.
% On a 4 cas,
% Deux premiers cas : une des deux listes est vide :
merge([], L, L).
merge(L, [], L).
% Cas suivant, l'élément de la première liste est plus petit, il sera 
% en tete de la fusion de la queue de la première liste avec la seconde liste :
merge([X1 | Tail1], [X2 | Tail2], [X1 | MergedRest]) :-
    X1 =< X2, 
    !, % on cut car on a pas d'autres cas à tester si la liste 1 correspond
    merge(Tail1, [X2 | Tail2], MergedRest).
% Dernier cas, le plus petit est donc la tete de la liste 2 :
merge(L1, [X2 | Tail2], [X2 | MergedRest]) :-
    merge(L1, Tail2, MergedRest).

% Tri fusion, trois cas,
% - la liste est vide, rien à faire :
merge_sort([],[]).
% - la liste contient un unique élément, pareil :
merge_sort([X],[X]).
% - la liste contient au moins deux éléments, on divise, on tri les deux,
%   on fusionne :
merge_sort([X,Y|Tail], Sorted) :-
    divide([X,Y|Tail], L1, L2),
    merge_sort(L1, SortedL1),
    merge_sort(L2, SortedL2),
    merge(SortedL1, SortedL2, Sorted).
