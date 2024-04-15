% Dynamic declarations for known facts and multivalued predicates
:- dynamic known/3.
:- dynamic fact/2.

% Define the initial question
initial_question(payment_preference).

%askables8
payment_preference(X) :-  ask(payment_preference, X).
coffee_available(X) :-  ask(coffee_available, X).
food_available(X) :-  ask(food_available, X).
meal_type(X) :- ask(meal_type, X).
walking_distance(X) :- ask(walking_distance, X).
travel_distance(X) :- ask(travel_distance, X).
plug_needed(X) :- ask(plug_needed, X).
wifi_needed(X) :- ask(wifi_needed, X).
wheelchair_accessible(X) :- ask(wheelchair_accessible, X).


%recommendation rules
recommendation(saint_espresso) :- payment_preference(paid), coffee_available(yes), food_available(no), walking_distance(no), travel_distance(less_than_5km), plug_needed(no), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(goswell_road_coffee) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal),walking_distance(yes), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(no).
recommendation(gecko_coffeehouse) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), plug_needed(yes), wifi_needed(yes),wheelchair_accessible(yes).
recommendation(the_british_library) :- payment_preference(free),walking_distance(no), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(fwd_coffee) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(no_full_meal), walking_distance(yes), plug_needed(yes), wifi_needed(yes),wheelchair_accessible(yes).
recommendation(cafebotanical) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(barbican_centre) :- payment_preference(free), walking_distance(yes), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(attendant_coffee_roasters_shoreditch) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(no_full_meal), walking_distance(yes), plug_needed(no), wifi_needed(yes), wheelchair_accessible(no).
recommendation(national_art_library) :- payment_preference(free),walking_distance(no), travel_distance(more_than_5km), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(wellcome_collection) :- payment_preference(free), walking_distance(no), travel_distance(more_than_5km), plug_needed(no), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(senate_house_library) :- payment_preference(free),walking_distance(no), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(chestnut_bakery) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(no), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(bench) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(no), travel_distance(less_than_5km), plug_needed(no), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(briki) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(katsute_100) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(no_full_meal), walking_distance(yes), plug_needed(no), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(burr_co_london) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(commons_at_old_street_works) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(no).
recommendation(the_hoxton) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(waterstones) :- payment_preference(paid), coffee_available(yes), food_available(no), walking_distance(yes), plug_needed(yes), wifi_needed(no), wheelchair_accessible(yes).
recommendation(dishoom_kings_cross) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(no), travel_distance(less_than_5km), plug_needed(no), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(foyles) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(no), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(kensington_central_library) :- payment_preference(free),walking_distance(no), travel_distance(more_than_5km), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(hilton_london_tower_bridge) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(no), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(no), wheelchair_accessible(yes).
recommendation(redemption_roasters) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), plug_needed(no), wifi_needed(yes), wheelchair_accessible(yes).
recommendation(pretamanger) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), plug_needed(yes), wifi_needed(yes), wheelchair_accessible(yes).

% Asking clauses
ask(A, V):-
known(yes, A, V), % succeed if true
!.	% stop looking

ask(A, V):-
known(_, A, V), % fail if false
!, fail.

% if it is already known to be something else, the user does not need to be asked again
ask(A, V):-
known(yes, A, V2),
V \== V2,
!, fail.

ask(A, V):-
read_py(A,V,Y), % obtain the answer with that python function
assertz(known(Y, A, V)), % save it for future reference
Y == yes.	% succees or fail
