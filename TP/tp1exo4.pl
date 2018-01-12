:- use_module(library(clpfd)). % Pour les contraintes

% Send more money :
puzzle(Vars) :-
    Vars = [S,E,N,D,M,O,R,Y], % ceux sont les variables du problèmes
    Vars ins 0..9 ,            % Elles sont entre 0 et 9
    all_different(Vars), % Prédicat permettant d'exprimer que tous les éléments
    % d'une certaine liste doivent etre différents.
    % On exprime l'opération :
                 S*1000 + E*100 + N*10 + D 
	       + M*1000 + O*100 + R*10 + E 
    #= M*10000 + O*1000 + N*100 + E*10 + Y,
    % Et le fait que M et S sont différents de 0 :
    M #\= 0, S #\= 0, D #= 7,label([S,E,N,D,M,O,R,Y]).

% Pour faire une requete du puzzle, on fait :
% ?- puzzle([S,E,N,D,M,O,R,Y]).
% ou
% ?- puzzle(X).
% en appliquant cette requete, on peut deja voir que certains calculs
% sont déjà produits par le moteur de résolution (label([S,E,N,D,M,O,R,Y]):
% S = 9,
% M = 1,
% O = 0,
% E in 4..7,
% N in 5..8,
% D in 2..8,
% R in 2..8,
% Y in 2..8.

% En ajoutant label([S,E,N,D,M,O,R,Y]), on obtient la solution :
% ?- puzzle([S,E,N,D,M,O,R,Y]), label([S,E,N,D,M,O,R,Y]).
% S = 9,
% E = 5,
% N = 6,
% D = 7,
% M = 1,
% O = 0,
% R = 8,
% Y = 2 

% Carré magique.
% Le concept est simple avoir des sommes égales sur toutes les lignes et 
% tous les colones et les deux diagonales.
% En gros on veut exprimer l'égalité de sommes entre N listes de 3 éléments.

% On peut déjà avoir un prédicat qui contraint la somme des éléments d'une 
% liste a avoir une certaine valeur :
sum_equal([], 0).
sum_equal([Head|Tail], N) :-
    sum_equal(Tail, PartialSum),
    N #= PartialSum + Head.
% On remarque que cela ressemble beaucoup à "sum" sauf qu'ici on contraint
% la valeur du N, on ne la calcule pas.

% Ensuite on peut contraindre X listes à avoir cette somme N :
all_sum_equal([], _).
all_sum_equal([HeadList | OtherLists], N) :-
    sum_equal(HeadList, N),
    all_sum_equal(OtherLists, N).

% Finalement, on peut définir notre carré magique comme ceci :

magic_square(Vars, N) :-
    Vars = [ A, B, C,
	     D, E, F,
	     G, H, I ],
    Rows = [ [A, B, C], [D, E, F], [G, H, I] ],
    Cols = [ [A, D, G], [B, E, H], [C, F, I] ],
    Diag = [ [A, E, I], [G, E, C] ],
    Vars ins 1..9,       % toutes les valeurs sont entre 1 et 9
    all_different(Vars), % et toutes différentes.
    % finalement, toutes les sommes sont égales :
    all_sum_equal(Rows, N),
    all_sum_equal(Cols, N),
    all_sum_equal(Diag, N).

% Finalement on peut faire notre requete et recevoir tous les carrés magiques :
% ?- magic_square(Vars, N), label(Vars).
% Vars = [2, 7, 6, 9, 5, 1, 4, 3, 8],
% N = 15 ;
% Vars = [2, 9, 4, 7, 5, 3, 6, 1, 8],
% N = 15 ;
% Vars = [4, 3, 8, 9, 5, 1, 2, 7, 6],
% N = 15 ;
% Vars = [4, 9, 2, 3, 5, 7, 8, 1, 6],
% N = 15 ;
% Vars = [6, 1, 8, 7, 5, 3, 2, 9, 4],
% N = 15 ;
% Vars = [6, 7, 2, 1, 5, 9, 8, 3, 4],
% N = 15 ;
% Vars = [8, 1, 6, 3, 5, 7, 4, 9, 2],
% N = 15 ;
% Vars = [8, 3, 4, 1, 5, 9, 6, 7, 2],
% N = 15 ;
