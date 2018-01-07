

:- dynamic(mfibo/2).
mfibo(0,0) :- !.
mfibo(1,1) :- !.
mfibo(N,F) :- N>1, N1 is N-1, mfibo(N1,F1) ,
  	           N2 is N-2, mfibo(N2,F2) ,
		   F is F1+F2 ,
		   asserta((mfibo(N, F) :- !)) .
