/*******************************************/
/**    Your solution goes in this file    **/ 
/*******************************************/
isMember(X, [X|_]).
isMember(X, [_| T]) :- isMember(X,T).

isUnion([], X, X).
isUnion([X|R], Y, Z) :- isMember(X,Y), !, isUnion(R, Y, Z).
isUnion([X|R], Y, [X|Z]) :- isUnion(R, Y, Z).

subset([], Y).
subset([A|X], Y) :- isMember(A, Y), subset(X,Y).
isEqual(X,Y) :- subset(Y,X), subset(X,Y).

isIntersection([], X, []).
isIntersection([X|R], Y, [X|Z]) :-
	isMember(X,Y),
	!,
	isIntersection(R,Y,Z).
isIntersection([X|R], Y, Z) :- isIntersection(R, Y, Z).

year_1953_1996_novels(X) :- 
	novel(X,Y), (Y=1953; Y = 1996).

period_1800_1900_novels(X) :- 
	novel(X,Y), between(1830,1900,Y).

lotr_fans(X) :-
	fan(X,TList), member(the_lord_of_the_rings, TList).

author_names(A) :-
	fan(X, NLIST), X='chandler', author(A, NOVELS), member_helper(NLIST, NOVELS).

member_helper(L, N) :-
member(X, L),
member(X, N),
!.

fans_names(N) :- 
	author(A, NLIST), A='brandon_sanderson', fan(N, NOVELS), member(Y, NOVELS), member(Y, NLIST). 

mutual_novels(N) :-
	fan(monica, NC), fan(ross, ND), member(N, NC), member(N, ND);
	fan(monica, NA), fan(phoebe, NB), member(N, NA), member(N, NB);
	fan(ross, NE), fan(phoebe, NF), member(N, NE), member(N, NF).


append([],X,X) :- !.
append([A|X],Y,[A|Z]) :- append(X,Y,Z).

insertHead(X,[],[]):- !.
insertHead(X, [H1|N] , [H2|V]) :- insertHead(X, N, V), append(H1, X, H2).

powerSet([], [[]]).
powerSet([X|T],Y) :- powerSet(T, N), insertHead([X], N, V), append(N, V, Y).
	
