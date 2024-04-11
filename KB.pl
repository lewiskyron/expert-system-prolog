% Dynamic declarations for known facts and multivalued predicates
:- dynamic answer/3.


% Define the initial question
initial_question(payment_preference).

%rule on dynamic next question generation
next_question(payment_preference, coffee_available) :- answer(payment_preference, paid).
next_question(payment_preference, walking_distance) :- answer(payment_preference, free).
next_question(food_available, meal_type) :- answer(food_available, yes).
next_question(food_available, walking_distance) :- answer(food_available, no).


%askables
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


recommendation(saint_espresso) :- payment_preference(paid), coffee_available(yes), food_available(no), walking_distance(no), travel_distance(less_than_5km), plug_needed(no), wifi_needed(yes), minimum_stars(4.3), wheelchair_accessible(yes).
recommendation(goswell_road_coffee) :- payment_preference(paid), coffee_available(yes), food_available(yes), walking_distance(yes), travel_distance(more_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(3), wheelchair_accessible(no).
recommendation(gecko_coffeehouse) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.5), wheelchair_accessible(yes).
recommendation(the_british_library) :- payment_preference(free), coffee_available(yes), food_available(yes), meal_type(snack_pastry), walking_distance(no), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.5), wheelchair_accessible(yes).
recommendation(saint_espresso) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(snack_pastry), walking_distance(yes), travel_distance(less_than_5km), plug_needed(no), wifi_needed(no), minimum_stars(4.3), wheelchair_accessible(yes).
recommendation(goswell_road_coffee) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.5), wheelchair_accessible(yes).
recommendation(fwd_coffee) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(snack_pastry), walking_distance(yes), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.4), wheelchair_accessible(yes).
recommendation(cafebotanical) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.5), wheelchair_accessible(yes).
recommendation(barbican_centre) :- payment_preference(free), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.6), wheelchair_accessible(yes).
recommendation(attendant_coffee_roasters_shoreditch) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(snack_pastry), walking_distance(yes), travel_distance(less_than_5km), plug_needed(no), wifi_needed(yes), minimum_stars(4.3), wheelchair_accessible(no).
recommendation(national_art_library) :- payment_preference(free), coffee_available(no), food_available(no), meal_type(no_full_meal), walking_distance(no), travel_distance(more_than_5km), plug_needed(yes), wifi_needed(no), minimum_stars(4.4), wheelchair_accessible(yes).
recommendation(wellcome_collection) :- payment_preference(free), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(no), travel_distance(less_than_5km), plug_needed(no), wifi_needed(yes), minimum_stars(4.5), wheelchair_accessible(yes).
recommendation(senate_house_library) :- payment_preference(free), coffee_available(yes), food_available(no), meal_type(no_full_meal), walking_distance(no), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.5), wheelchair_accessible(yes).
recommendation(chestnut_bakery) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(no), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.2), wheelchair_accessible(yes).
recommendation(bench) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(no), travel_distance(less_than_5km), plug_needed(no), wifi_needed(yes), minimum_stars(4.3), wheelchair_accessible(yes).
recommendation(briki) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.5), wheelchair_accessible(yes).
recommendation(katsute_100) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(no_full_meal), walking_distance(yes), travel_distance(less_than_5km), plug_needed(no), wifi_needed(yes), minimum_stars(4.5), wheelchair_accessible(yes).
recommendation(burr_co_london) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(3.8), wheelchair_accessible(yes).
recommendation(commons_at_old_street_works) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(5.0), wheelchair_accessible(no).
recommendation(the_hoxton) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.4), wheelchair_accessible(yes).
recommendation(waterstones) :- payment_preference(paid), coffee_available(yes), food_available(no), meal_type(no_full_meal), walking_distance(yes), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(no), minimum_stars(4.6), wheelchair_accessible(yes).
recommendation(dishoom_kings_cross) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(no), travel_distance(less_than_5km), plug_needed(no), wifi_needed(yes), minimum_stars(4.6), wheelchair_accessible(yes).
recommendation(foyles) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(no), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.7), wheelchair_accessible(yes).
recommendation(kensington_central_library) :- payment_preference(free), coffee_available(no), food_available(no), meal_type(no_full_meal), walking_distance(no), travel_distance(more_than_5km), plug_needed(yes), wifi_needed(yes), minimum_stars(4.5), wheelchair_accessible(yes).
recommendation(hilton_london_tower_bridge) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(no), travel_distance(less_than_5km), plug_needed(yes), wifi_needed(no), minimum_stars(4.4), wheelchair_accessible(yes).
recommendation(redemption_roasters) :- payment_preference(paid), coffee_available(yes), food_available(yes), meal_type(full_meal), walking_distance(yes), travel_distance(less_than_5km), plug_needed(no), wifi_needed(yes), minimum_stars(4.1), wheelchair_accessible(yes).


ask(Attribute, Value) :-
  answer(yes, Attribute, Value).  % Succeed if true

ask(Attribute, Value) :-
  answer(_, Attribute, _),  % Check for any answer with the attribute
  !.  % Stop searching after first answer (assuming all options are considered in the rule)

ask(Attribute, Value) :-
  read_py(Attribute, Value, Response),
  assertz(answer(Response, Attribute, Value)),
  Response == yes.