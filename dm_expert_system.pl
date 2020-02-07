% Discrete Mathematics | Expert System Assignment
% This expert system is about medical illnesses and conditions.
% 
% Authors: Mustafa Yücesan & Mohamed el Hadiyen
% --------------------------------
/**
 * Requirements
 * 
 * Minimal:
 * 		1) Based on Tweety but different domain.
 * 		2) The four unique queries (using different rules) give the expected results. 
 * 		   These unique queries are asking at least four separate questions.
 * 		3) The program contains minimal two different rules of inference.
 * 		4) Every query runs without errors
 * 		5) The predicates have logical names
 * 		6) Manual: Explanation how each rule of inference works and rationale, and the explanation refers 
 * 		   to the actual source code. 
 * 		7) Manual: detailed Instructions for querying the expert system are provided in the manual
 * 
 * +1 for Organization:
 * 		1) Two files are delivered separately: manual.pdf and pa1.pl.txt (text version of the expert system)
 * 		2) Comments in the code are useful and helpful per rule of inference.
 * 
 * +3.5 as Extra:
 * 		1) The manual contains one or more diagrams to help to understand how the expert system works.
 * 		2) The program is entirely different from the Tweety example. More specifically, the code does not 
 * 		   have the set of prove rules, present in the example code.
 * 		3) More than two inference rules are present.
 * 		4) More than four queries are present, and the rationale per query is described.
 * 		5) All the extra features are documented in the manual.
. 
. 
 */ 

. 
/* Here a list of 5 conditions with their symptoms which will be the limit of our expert system.
 * 
 * Chronic Kidney Disease:
 * 		tiredness (unique)
 * 		swollen body parts (unique)
 * 		shortness of breath (unique)
 * 		nausea (common)
 * 		blood in the urine (unique)
 * Chickenpox:
 * 		red rash (unique)
 * 		nausea (common)
 * 		aching muscles (common with food poisoning)
 * 		headache (common with cold sore, diarrhoea)
 * 		generally feeling unwell (unique, might also see as nausea, which was described as feeling unwell)
 * 		loss of appetite (common with diarrhoea, food poisoning)
 * Cold sore:
 * 		swollen and irritated gums (unique)
 * 		sore throat and swollen glands (unique)
 * 		producing more saliva than normal (unique)
 * 		high temperature (common with food poisoning)
 * 		dehydration (unique)
 * 		nausea (common)
 * 		headache (common with chickenpox, diarrhoea)
 * Diarrhoea:
 * 		stomach cramps (common with food poisoning)
 * 		nausea (common)
 * 		vomiting (common with food poisoning)
 * 		headache (common with cold sore, chickenpox)
 * 		loss of appetite (common with chickenpox, food poisoning)
 * Food poisoning:
 * 		nausea (common)
 * 		vomiting (common with diarhoea)
 * 		diarrhoea (unique)
 * 		stomach cramps (common with food diarrhoea)
 * 		abdominal pain (unique)
 * 		lack of energy (unique)
 * 		loss of appetite (common with diarrhoea, chickenpox)
 * 		high temperature (common with cold sore)
 * 		aching muscles (common with chickenpox)
 * 		chills (unique)
 * */
    

prove(true) :- !.
prove((B, Bs)) :- !,
    prove(B),
    prove(Bs).
prove(H) :-
    clause(H, B),
    prove(B).
prove(H) :-
    askable(H),
    writeln(H),
    read(Answer),
	Answer == yes.


good_pet(X) :- bird(X), small(X).
good_pet(X) :- cuddly(X), yellow(X).

bird(X) :- has_feathers(X), tweets(X).

yellow(tweety).

askable(tweets(_)).
askable(small(_)).
askable(cuddly(_)).
askable(has_feathers(_)).


/** <examples>

?- prove(good_pet(tweety)).

*/
