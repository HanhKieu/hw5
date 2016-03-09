/*******************************************/
/**    Your solution goes in this file    **/ 
/*******************************************/

memberCheck(X, [X|_]) :- !.
memberCheck(X,[_|T]) :- memberCheck(X, T).

year_1953_1996_novels(X) :- 
	novel(X,Y), (Y=1953; Y = 1996).

period_1800_1900_novels(X) :- 
	novel(X,Y), between(1830,1900,Y).

lotr_fans(X) :-
	fan(X,TList), member(the_lord_of_the_rings, TList).

author_names(A) :-
	fan(X, NLIST), X='chandler', author(A, NOVELS), memberCheck(Y, NLIST), memberCheck(Y, NOVELS).

fans_names(N) :- 
	author(A, NLIST), A='brandon_sanderson', fan(N, NOVELS), member(Y, NOVELS), member(Y, NLIST). 

mutual_novels(N) :-
	fan(monica, NC), fan(ross, ND), member(N, NC), member(N, ND);
	fan(monica, NA), fan(phoebe, NB), member(N, NA), member(N, NB);
	fan(ross, NE), fan(phoebe, NF), member(N, NE), member(N, NF).


