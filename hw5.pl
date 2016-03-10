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
	novel(X,Y), between(1800,1900,Y).

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
	
/* 420 BLAZE IT, THIRD PARRT */	

state(X,Y,Z,W).
state(left,left,left,left).
state(left,left,left,right).
state(left,left,right,left).
state(left,left,right,right).
state(left,right,left,left).
state(left,right,left,right).
state(left,right,right,left).
state(left,right,right,right).
state(right,left,left,left).
state(right,left,left,right).
state(right,left,right,left).
state(right,left,right,right).
state(right,right,left,left).
state(right,right,left,right).
state(right,right,right,left).
state(right,right,right,right).

opposite(left, right).
opposite(right, left).

unsafe(state(left,right,right,_)).
unsafe(state(left,_,right,right)).
unsafe(state(right,left,left,_)).
unsafe(state(right,_,left,left)).

safe(A) :- \+(unsafe(A)).

/* moving object from A to B */

take(none, X, Y) :- opposite(X,Y).
take(wolf, X, Y) :- opposite(X,Y).
take(goat, X, Y) :- opposite(X,Y).
take(cabbage, X, Y) :- opposite(X,Y).

/*going between states*/
arc(take(none,X,Y), state(X,B,C,D),state(Y,B ,C,D)) :- opposite(X,Y), safe(state(Y,B,C,D)).
arc(take(goat,X,Y), state(X,B,X,D), state(Y,B,Y,D)) :- opposite(X,Y), safe(state(Y,B,Y,D)). 
arc(take(wolf,X,Y), state(X,X,C,D), state(Y,Y,C,D)) :- opposite(X,Y), safe(state(Y,B,Y,D)).
arc(take(cabbage,X,Y), state(X,B,C,X),state(Y,B,C,Y)) :- opposite(X,Y), safe(state(Y,B,C,Y)).




go(state(right,right,right,right), state(right,right,right,right), PATH, []) :- !.
go(state(A,B,C,D), state(A2,B2,C2,D2), PATH, [M | TMOVES]) :-
	arc(M, state(A,B,C,D), state(X,Y,Z,W)) ,
	\+(isMember(state(X,Y,Z,W), PATH)),
	go(state(X,Y,Z,W), state(A2,B2,C2,D2), [state(A,B,C,D) | PATH ], TMOVES).


solve :- go(state(left, left, left, left), state(right, right, right, right), [], Z), myPrint(Z),!.

myPrint([]).
myPrint([X|Y]):- write(X), nl,  myPrint(Y), nl.
			
