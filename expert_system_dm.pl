% Discrete Mathematics | Expert System Assignment
% This expert system is about medical illnesses and conditions.
% 
% Authors: Mustafa Yücesan & Mohamed el Hadiyen
% --------------------------------

/* Here a list of 5 conditions and with their symptoms and medicine 
 * which will be the limit of our expert system.
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
 * 		aching muscles (common)
 * 		headache (common)
 * 		generally feeling unwell (unique)
 * 		loss of appetite (common)
 * Cold sore:
 * 		swollen and irritated gums (unique)
 * 		sore throat and swollen glands (unique)
 * 		producing more saliva than normal (unique)
 * 		high temperature (common)
 * 		dehydration (unique)
 * 		nausea (common)
 * 		headache (common)
 * Diarrhoea:
 * 		stomach cramps (common)
 * 		nausea (common)
 * 		vomiting (common)
 * 		headache (common)
 * 		loss of appetite (common)
 * Food poisoning:
 * 		nausea (common)
 * 		vomiting (common)
 * 		diarrhoea (unique)
 * 		stomach cramps (common)
 * 		abdominal pain (unique)
 * 		lack of energy (unique)
 * 		loss of appetite (common)
 * 		high temperature (common)
 * 		aching muscles (common)
 * 		chills (unique)
 * Medicine:
 * 		acyclovir
 *		antibiotics
 *		Anti-hypertensives
 *		Diuretics
 *		Erythropoietin
 *		vitamin D
 *		valacyclovir
 *		famciclovir
 *		loperamide
 *		bismuth subsalicylate
 */

/*
 * Question 1: Do I have disease X?
 * X can be: "Food poisoning", "Chronic kidney disease", 
 * "Cold sore", "Chickenpox", or "Diarrhoea"
 * 
 * For this question, has_disease(X) will be true
 * if forall(has_symptom(disease(X), Y, _), ask_for_symptom(Y)) is true, then
 * disease(X) must be true. Modus Ponens is being used: 
 * if p (for all..), then q (has_disease). p, therefore, q.
 */

has_disease(X) :-
    ask_about_disease(X), true.

/*
 * Question 2: Does disease Y contain a common symptom that occurs 
 * with every disease included in this system?
 * Y can be: "Food poisoning", "Chronic kidney disease", 
 * "Cold sore", "Chickenpox", or "Diarrhoea"
 * 
 * For every common symptom of disease Y, it is being checked whether that
 * symptom is also a symptom for all the other diseases in the set(universal).
 * If so, that means that there is a common symptom, and the question will respond
 * with that symptom. Conjunction is being used.
 */

does_disease_contain_very_common_symptom(Y) :-
    has_symptom(disease(Y), X, "common"), % Selects all common symptoms of disease Y
    forall(disease(Z), has_symptom(disease(Z), X, "common")), % Goes through all diseases in set to see if all diseases have that common symptom
    format("A very common symptom is: ~w\n", [X]).

/*
 * Question 3: Can disease Y lead to another disease?
 * Y can be: "Food poisoning", "Chronic kidney disease", 
 * "Cold sore", "Chickenpox", or "Diarrhoea"
 * 
 * According to our facts, it is possible for a disease to be a symptom for
 * another disease in the set. To check this, each disease is being looped through to see
 * if it can be a symptom of another disease(Pay attention to Y, which is the disease that
 * is being checked as a symptom in has_symptom), Conjunction is being used.
 */

can_disease_lead_to_another(Y) :-
    disease(Y),
    has_symptom(disease(X), Y, _), % Checks if disease Y is a symptom of any disease
    format("~w can lead to ~w\n", [Y, X]). % If yes, output that disease.

/*
 * Question 4: Since I know the unique symptom and the possible diseases I have,
 * would I have disease X or disease Y?
 * Y and X can be: "Food poisoning", "Chronic kidney disease", 
 * "Cold sore", "Chickenpox", or "Diarrhoea". Diarrhoea will always be false because
 * it does not have any unique symptom, and it is assumed the user knows
 * the unique symptom, he/she can never have Diarrhoea.
 * 
 * Since our database knows which symptoms are unique, we can eliminate
 * one of the two diseases since we know the unique symptom and the possible diseases.
 * Conjunction and Elimination are being used here. 
 */

which_disease_likely(X, Y) :- 
    check_disease_on_unique(X, Y). 


/*
 * Question 5: Query for potential medicine for a disease
 * X can be: "Food poisoning", "Chronic kidney disease", 
 * "Cold sore", "Chickenpox", or "Diarrhoea".
 */

check_medicine_for_disease(X):-
    has_medicine(disease(X), Y),
    format('You can use the following medicine: ~w\n', [Y]).


/* 
 * Question 6: Does a medicine of disease X help against disease Y? 
 * For  this to be true, disease Y has to be a symptom of disease X.
 * First, the system checks whether there is a disease X for medicine Z. 
 * Then, it checks whether there is a disease Y that is a symptom for
 * disease X. The system then confirms that medicine Z could be used for disease X. 
 * This is done using the 
 * rules of inference: Transivity.  
 * if medicine, then disease X
 * if disease X, then disease Y
 * therefore, if medicine, then disease Y
 */

check_multiple_use_medicine(X) :-
    does_disease_have_medicine(Y, X) -> disease(Y),
    format("Medicine can be used for disease: ~w\n", [Y]),
    format("Can medicine also be used for another disease?\n"),
    disease(Y) -> does_disease_have_disease_as_symptom(Y, Z),
    format("Medicine can also be used for disease: ~w\n", [Z]).
    
    


/*
 * Used to ask the user whether he/she has the symptoms that belong to the disease
 */

ask_about_disease(X) :- 
    forall(has_symptom(disease(X), Y, _), ask_for_symptom(Y)).
	
/*
 * These two predicates are being used for elimination. The second one will not happen
 * if the first one is true, which means that it is false by default, thus it can be 
 * eliminated. If first predicate is false, then that means the second one is true. To 
 * ignore the first predicate (if second is false), the !-sign is being used. 
 */
check_disease_on_unique(X, Y) :-
    not(X = Y),
    has_symptom(disease(X), Z, "unique"), % Takes all the unique symptoms for disease X
    ask_for_symptom(Z), % Keeps asking till it gets a true as response, or else its false
    format("You are likely to have the disease: ~w\n", [X]) % This will not happen if ask_for_symptom does not pass
    , !. % If everything is true, second predicate gets ignored. 

check_disease_on_unique(X, Y) :- % If not, then that means X is eliminated, thus Y is true
    not(X = Y),
    format("You are likely to have the disease: ~w\n", [Y]). % If X is false, then Y must be true. Therefore, this will be formatted.


/* 
 * Used to ask the user about symptom, which is needed to calculate the 
 * truth value in some questions 
 * */
ask_for_symptom(X) :-
    format('Do you have the symptom: ~w?\n', [X]),
    read(yes). 

/*
 * Asks if a disease has another disease as a symptom
 * 
 * 
 */
does_disease_have_disease_as_symptom(X, Y) :-
    has_symptom(disease(X), Y, _),
    disease(Y).

/*
 * Asks if a disease has a medicine
 */

does_disease_have_medicine(X, Y) :-
    has_medicine(disease(X), Y).
    

/* The database */
disease("Food poisoning").
disease("Chronic kidney disease").
disease("Cold sore").
disease("Chickenpox").
disease("Diarrhoea").
has_symptom(disease("Food poisoning"), "Nauseau", "common").
has_symptom(disease("Food poisoning"), "Aching muscles", "common").
has_symptom(disease("Food poisoning"), "Loss of appetite", "common").
has_symptom(disease("Food poisoning"), "High temperature", "common").
has_symptom(disease("Food poisoning"), "Stomach cramps", "common").
has_symptom(disease("Food poisoning"), "Vomiting", "common").
has_symptom(disease("Food poisoning"), "Diarrhoea", "unique").
has_symptom(disease("Food poisoning"), "Abdominal pain", "unique").
has_symptom(disease("Food poisoning"), "Lack of energy", "unique").
has_symptom(disease("Food poisoning"), "Chills", "unique").
has_symptom(disease("Chronic kidney disease"), "Nauseau", "common").
has_symptom(disease("Chronic kidney disease"), "Tiredness", "unique").
has_symptom(disease("Chronic kidney disease"), "Swollen body parts", "unique").
has_symptom(disease("Chronic kidney disease"), "Shortness of breath", "unique").
has_symptom(disease("Chronic kidney disease"), "Blood in urine", "unique").
has_symptom(disease("Cold sore"), "Nauseau", "common").
has_symptom(disease("Cold sore"), "Headache", "common").
has_symptom(disease("Cold sore"), "Swollen and irritated gums", "unique").
has_symptom(disease("Cold sore"), "Sore throat and swollen glands", "unique").
has_symptom(disease("Cold sore"), "Producing more saliva than normal", "unique").
has_symptom(disease("Cold sore"), "High temperature", "common").
has_symptom(disease("Cold sore"), "Dehydration", "unique").
has_symptom(disease("Chickenpox"), "Nauseau", "common").
has_symptom(disease("Chickenpox"), "Red rash", "unique").
has_symptom(disease("Chickenpox"), "Aching muscles", "common").
has_symptom(disease("Chickenpox"), "Headache", "common").
has_symptom(disease("Chickenpox"), "Loss of appetite", "common").
has_symptom(disease("Diarrhoea"), "Nauseau", "common").
has_symptom(disease("Diarrhoea"), "Headache", "common").
has_symptom(disease("Diarrhoea"), "Loss of appetite", "common").
has_symptom(disease("Diarrhoea"), "Stomach crumps", "common").
has_symptom(disease("Diarrhoea"), "Vomitting", "common").

has_medicine(disease("Chickenpox"), "Acyclovir").
has_medicine(disease("Food poisoning"), "Antibiotics").
has_medicine(disease("Chronic kidney disease"), "Anti-hypertensives").
has_medicine(disease("Chronic kidney disease"), "Diuretics").
has_medicine(disease("Chronic kidney disease"), "Erythropoietin").
has_medicine(disease("Chronic kidney disease"), "Vitamin D").
has_medicine(disease("Cold sore"), "Valacyclovir").
has_medicine(disease("Cold sore"), "Famciclovir").
has_medicine(disease("Cold sore"), "Acyclovir").
has_medicine(disease("Diarrhoea"), "Loperamide").
has_medicine(disease("Diarrhoea"), "Bismuth subsalicylate").
