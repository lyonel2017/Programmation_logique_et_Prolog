digit_english(0,zero).
digit_english(1,one).
digit_english(2,two).

phone_engish([],[]).
phone_engish([Digit|Ds],[Word|Ws]) :-
    digit_english(Digit,Word),
    phone_engish(Ds,Ws).

digit_germen(0,null).
digit_germen(1,eins).
digit_germen(2,zwei).

phone_germen([],[]).
phone_germen([Digit|Ds],[Word|Ws]) :-
    digit_germen(Digit,Word),
    phone_germen(Ds,Ws).


phone_poly([],_,[]).
phone_poly([Digit|Ds],P,[Word|Ws]) :-
    Goal =.. [P,Digit,Word],
    Goal,
    phone_poly(Ds,P,Ws).
