% Correction TP1 - Prolog

% Exercice 1. 

% Question 1/2 : rien à faire juste taper ce qui est écrit.

% Question 3 : 

% Les hommes, les femmes :

homme(paul).
homme(leo).
homme(renaud).
homme(bob).
homme(philippe).
homme(rene).
homme(leonard).
homme(luc).
homme(pierre).
homme(stephane).
homme(martin).

femme(anna).
femme(sophie).
femme(marie).
femme(martine).
femme(sandrine).
femme(lea).
femme(isa).
femme(alice).

% Pour les relations entre les gens, on a deux manières de faire.
% Soit on indique qui est parent de qui, 
% soit on indique qui sont les pères et les mères de qui.
%
% La conséquence, c'est que soit parent est défini en tant que pere/mere.
% Soit c'est l'inverse.

% Possibilité 1 :

%% parent(renaud, paul).
%% parent(alice, renaud).
%% parent(lea, leo).
%% parent(bob, renaud).
%% parent(philippe, rene).
%% parent(leonard, rene).
%% parent(martine, luc).
%% parent(pierre, luc).
%% parent(sophie, martin).
%% parent(sephane, pierre).

%% parent(sophie, anna).
%% parent(stephane, sophie).
%% parent(pierre, marie).
%% parent(martine, marie).
%% parent(leonard, martine).
%% parent(philippe, lea).
%% parent(alice, isa).
%% parent(lea, sandrine).
%% parent(renaud, sandrine).

%% pere(Enfant, Parent) :- homme(Parent), parent(Enfant, Parent).
%% mere(Enfant, Parent) :- femme(Parent), parent(Enfant, Parent).

% Possibilité 2 :

pere(renaud, paul).
pere(alice, renaud).
pere(lea, leo).
pere(bob, renaud).
pere(philippe, rene).
pere(leonard, rene).
pere(martine, luc).
pere(pierre, luc).
pere(sophie, martin).
pere(stephane, pierre).

mere(sophie, anna).
mere(stephane, sophie).
mere(pierre, marie).
mere(martine, marie).
mere(leonard, martine).
mere(philippe, lea).
mere(alice, isa).
mere(lea, sandrine).
mere(renaud, sandrine).

parent(Enfant, Parent) :- pere(Enfant, Parent) ; mere(Enfant, Parent).

% Relation enfant :
enfant(Parent, Enfant) :- parent(Enfant, Parent).

% Relation grand parent :

grandparent(PetitEnfant,GrandParent) :- 
     parent(PetitEnfant, Quelquun),
     parent(Quelquun, GrandParent).

% Frere/Soeur (sans considération demi-frere/soeur) :
 %% frere(Enfant, Frere) :-
 %%    parent(Enfant, Parent), %meme parents
 %%    parent(Frere, Parent),
 %%    Enfant \= Frere, %pas la meme personne
 %%    homme(Frere).    %pour un etre un frere, il faut etre un homme

 soeur(Enfant, Soeur) :-
    parent(Enfant, Parent), %meme parents
    parent(Soeur, Parent),
    Enfant \= Soeur, %pas la meme personne
    femme(Soeur).    %pour un etre une soeur, il faut etre une femme

% Pour obtenir la considération qu'un demi-frere n'est pas un frere,
% il faut restreindre au deux memes parents :

  frere(Enfant, Frere) :-
     pere(Enfant, Pere), mere(Enfant, Mere),
     pere(Frere , Pere), mere(Frere , Mere),     
     Enfant \= Frere,
     homme(Frere).

% Oncle/tante
oncle(Enfant, Oncle) :-
    parent(Enfant, Parent),
    frere(Parent, Oncle).

tante(Enfant, Tante) :-
    parent(Enfant, Parent),
    soeur(Parent, Tante).

% Cousin

cousin(Enfant, Cousin) :-
  homme(Cousin), % pour cousine, c'est tout ce qu'on doit changer.
  (
      oncle(Enfant, Personne) ;
      tante(Enfant, Personne)
  ),
  parent(Cousin, Personne).

