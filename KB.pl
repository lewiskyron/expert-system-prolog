% Dynamic declarations for known facts and multivalued predicates
:- dynamic known/3, multivalued/1.
:- dynamic answer/2.


% Define the initial question
initial_question(study_spot_preference).

%rule on dynamic next question generation
next_question(study_spot_preference, coffee_available) :- answer(study_spot_preference, paid).
next_question(study_spot_preference, walking_distance) :- answer(study_spot_preference, free).
next_question(food_available, meal_type) :- answer(food_available, yes).
next_question(food_available, walking_distance) :- answer(food_available, no).


% Asking clauses
ask(Attribute, Value):-
    known(yes, Attribute, Value), % Succeed if true
    !.  % Stop looking

ask(Attribute, Value):-
    known(_, Attribute, Value), % Fail if false
    !, fail.

% If not multivalued, and already known to be something else, dont ask again for a different value.
ask(Attribute, Value):-
    \+multivalued(Attribute),
    known(yes, Attribute, OtherValue),
    Value \== OtherValue,
    !, fail.

ask(Attribute, Value):-
    read_py(Attribute, Value, UserResponse), % Get the answer
    assertz(known(UserResponse, Attribute, Value)), % Remember it
    UserResponse == yes.  % Succeed or fail
