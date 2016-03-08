/*******************************************/
/**    Your solution goes in this file    **/ 
/*******************************************/
year_1953_1996_novels(X) :- 
	novel(X,Y), (Y=1953; Y = 1996).

period_1800_1900_novels(X) :- 
	novel(X,Y), between(1830,1900,Y).