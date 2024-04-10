% Dynamic declarations for known facts and multivalued predicates
:- dynamic answer/2.


% Define the initial question
initial_question(payment_preference).

%rule on dynamic next question generation
next_question(payment_preference, coffee_available) :- answer(payment_preference, paid).
next_question(payment_preference, walking_distance) :- answer(payment_preference, free).
next_question(food_available, meal_type) :- answer(food_available, yes).
next_question(food_available, walking_distance) :- answer(food_available, no).


payment_preference(X) :- ask(payment_preference, X).
coffee_available(X) :- ask(coffee_available, X).
food_available(X) :- ask(food_available, X).
meal_type(X) :- ask(meal_type, X).
walking_distance(X) :- ask(walking_distance, X).
travel_distance(X) :- ask(travel_distance, X).
plug_needed(X) :- ask(plug_needed, X).
wifi_needed(X) :- ask(wifi_needed, X).
minimum_stars(X) :- ask(minimum_stars, X).
wheelchair_accessible(X) :- ask(wheelchair_accessible, X).



recommendation(gecko_coffeehouse) :- payment_preference(paid), coffee_available(yes), food_available(yes), walking_distance(yes), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.5), wheelchair_accessible(yes).
recommendation(british_library) :- payment_preference(free), coffee_available(yes), food_available(no), walking_distance(yes), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.5), wheelchair_accessible(yes).
recommendation(saint_espresso) :- payment_preference(paid), coffee_available(yes), food_available(no), walking_distance(no), travel_distance(less_than_5km), plug_needed(no), wifi_needed(yes), minimum_stars(4.3), wheelchair_accessible(yes).
recommendation(goswell_road_coffee) :- payment_preference(paid), coffee_available(yes), food_available(yes), walking_distance(yes), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.5), wheelchair_accessible(yes). 



% Asking clauses
ask(Attribute, Value):-
    answer(Attribute, Value), % Succeed if true
    !.  % Stop looking

ask(Attribute, Value):-
    answer(Attribute, Value), % Fail if false
    !, fail.

ask(Attribute, Value):-
    read_py(Attribute, Value, UserResponse), % Get the answer
    assertz(answer(Value, Attribute, UserResponse)).
