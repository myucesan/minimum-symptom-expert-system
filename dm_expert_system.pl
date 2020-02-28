% Discrete Mathematics | Expert System Assignment
% This expert system is about medical illnesses and conditions.
% 
% Authors: Mustafa Yücesan & Mohamed el Hadiyen
% --------------------------------
/*
 * Requirements
 * 
 * Minimal:
 * 		1) Based on Tweety but different domain. // CHECK
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
 */ 
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
 * 		stomach cramps (common with diarrhoea)
 * 		abdominal pain (unique)
 * 		lack of energy (unique)
 * 		loss of appetite (common with diarrhoea, chickenpox)
 * 		high temperature (common with cold sore)
 * 		aching muscles (common with chickenpox)
 * 		chills (unique)
 * */

/*
 * 
 * Query: What disease could I have with the following symptoms? (Deze is echt alleen if. 
 * Rules of inference: modus ponens) 
 * 
 * */

/*animal(dog)  :- is_true('has fur'), is_true('says woof').
animal(cat)  :- is_true('has fur'), is_true('says meow').
animal(duck) :- is_true('has feathers'), is_true('says quack').

is_true(Q) :-
        format("~w?\n", [Q]),
        read(yes).*/

has_disease(X) :-
    X == "Food poisoning",
    food_poisoning.
    
	
food_poisoning :-
    has_symptom(nauseau),
    has_symptom(aching_muscles),
    has_symptom(loss_appetite).

has_symptom(X) :-
    format('Do you have the symptom ~w?\n', [X]),
    read(yes).
    


/*
% Food poisoning has following symptoms:
symptom(foodPoisoning, nauseau).% Food poisoning has the symptom nauseau
symptom(foodPoisoning, aching_muscles).
symptom(foodPoisoning, loss_of_appetite).
symptom(foodPoisoning, high_temperature).
symptom(foodPoisoning, stomach_cramps).
symptom(foodPoisoning, vomiting).
symptom(foodPoisoning, diarrhoea).
symptom(foodPoisoning, abdominal_pain).
symptom(foodPoisoning, lack_of_energy).
symptom(foodPoisoning, chills).

% Chronic kidney disease has following symptoms:
symptom(chronicKidneyDisease, nauseau).
symptom(chronicKidneyDisease, tiredness).
symptom(chronicKidneyDisease, swollen_body_parts).
symptom(chronicKidneyDisease, shortness_of_breath).
symptom(chronicKidneyDisease, blood_in_urine).
symptom(chronicKidneyDisease, nauseau).

% Chickenpox symptoms:
symptom(chickenpox, nauseau).
symptom(chickenpox, red_rash).
symptom(chickenpox, aching_muscles).
symptom(chickenpox, headache).
symptom(chickenpox, loss_of_appetite).

% Cold sore symptoms:
symptom(coldSore, nauseau).
symptom(coldSore, headache).
symptom(coldSore, swollen_and_irritated_gums).
symptom(coldSore, sore_throat_and_swollen_glands).
symptom(coldSore, producing_more_saliva_than_normal).
symptom(coldSore, high_temperature).
symptom(coldSore, dehydration).

% diarrhoea symptoms:
symptom(diarrhoea, nauseau).
symptom(diarrhoea, headache).
symptom(diarrhoea, loss_of_appetite).
symptom(diarrhoea, stomach_cramps).
symptom(diarrhoea, vomiting).

*/
