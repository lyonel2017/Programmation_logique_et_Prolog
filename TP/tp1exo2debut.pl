% member :
% un élément est membre d'une liste dans deux situtations :
% - il est au début :
my_member(X, [X | _]).
% équivalent à : 
%   member(X, L) :- 
%     L = [X | _].
% - il est plus loin (il est membre de la liste privée de son premier elt) :
my_member(X, [_ | L]) :- my_member(X, L).
% équivalent à : 
% member(X, L) :- 
%   L = [_ | Reste], 
%   member(X, Reste).


% concat :
% une liste Res est la concaténation de deux listes L1, L2, 
% dans deux situations :
% - la première liste est vide, et donc le résultat est juste l'autre liste :
my_concat([], Res, Res).
% équivalent à : 
% concat([], L, Res) :- 
%   L = Res.
% - la liste L1 n'est pas vide, auquel cas, il faut que le Res soit
%   la concaténation du première élément de L1, avec la concaténation
%   du reste de la liste L1 lui meme concaténé à l2 :
my_concat([X | Tl_L1], L2, [X | Tl_Res]) :-
    my_concat(Tl_L1, L2, Tl_Res).
%équivalent à :
%concat(L1, L2, Res) :-
%    L1 = [X | Tl_L1],
%    concat(Tl_L1, L2, Tl_Res),
%    Res = [X | Tl_Res].
