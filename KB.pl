% Directive Declarations
% Tell compiler these predicates are defined in a non-contiguous manner throughout the knowledge base. 
:- discontiguous study_spot_preference/2.
:- discontiguous food_available/2.
:- discontiguous study_spot/1.
:- discontiguous coffee_available/2.
:- discontiguous walking_distance/2.
:- discontiguous meal_type/2.
:- discontiguous description/2.
:- discontiguous address/2.
:- discontiguous website/2.
:- discontiguous type/2.
:- discontiguous wifi_needed/2.
:- discontiguous plug_needed/2.
:- discontiguous wheelchair_accessible/2.
:- discontiguous stars_rating/2.
:- discontiguous travel_distance/2.
:- discontiguous closing_time_weekday/2.
:- discontiguous closing_time_weekend/2.


% Dynamic declarations for known facts and multivalued predicates
:- dynamic known/3, multivalued/1.
:- dynamic answer/2.

% Define the initial question?- consult('KB.pl').
initial_question(study_spot_preference).

% Rule on dynamic next question generation
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

% Study Spot: gecko_coffeehouse_
study_spot(gecko_coffeehouse_).
description(gecko_coffeehouse_, "Trendy coffee shop with a full menu and acclaimed coffee selection. ").
address(gecko_coffeehouse_, "49 Bethnal Grn Rd, London E1 6LA").
website(gecko_coffeehouse_, "https://geckocoffee.house/pages/menu").
type(gecko_coffeehouse_, cafe).
study_spot_preference(gecko_coffeehouse_, paid).
coffee_available(gecko_coffeehouse_, y).
food_available(gecko_coffeehouse_, y).
meal_type(gecko_coffeehouse_, full_meal).
meal_type(gecko_coffeehouse_, snack_pastry).
wifi_needed(gecko_coffeehouse_, y).
plug_needed(gecko_coffeehouse_, y).
wheelchair_accessible(gecko_coffeehouse_, y).
stars_rating(gecko_coffeehouse_, 4.5).
walking_distance(gecko_coffeehouse_, yes).
travel_distance(gecko_coffeehouse_, 2.1).
closing_time_weekday(gecko_coffeehouse_, 18:00 - 21:00).
closing_time_weekend(gecko_coffeehouse_, after_21).

% Study Spot: the_british_library
study_spot(the_british_library).
description(the_british_library, "Library containing the Magna Carta and handwritten Beatles lyrics on some 400 miles of shelves.").
address(the_british_library, "96 Euston Rd., London NW1 2DB").
website(the_british_library, "https://www.bl.uk/").
type(the_british_library, library).
study_spot_preference(the_british_library, free).
coffee_available(the_british_library, y).
food_available(the_british_library, y).
meal_type(the_british_library, no_full_meal).
meal_type(the_british_library, snack_pastry).
wifi_needed(the_british_library, y).
plug_needed(the_british_library, y).
wheelchair_accessible(the_british_library, y).
stars_rating(the_british_library, 4.5).
walking_distance(the_british_library, no).
travel_distance(the_british_library, 2.6).
closing_time_weekday(the_british_library, 18:00 - 21:00).
closing_time_weekend(the_british_library, after_21).

% Study Spot: saint_espresso_
study_spot(saint_espresso_).
description(saint_espresso_, "Hip cafe with bare brick and pendant lights, for carefully sourced coffee and artisan baked goods.").
address(saint_espresso_, "Angel House, 26 Pentonville Rd, London N1 9HJ").
website(saint_espresso_, "http://www.saintespresso.com/").
type(saint_espresso_, cafe).
study_spot_preference(saint_espresso_, paid).
coffee_available(saint_espresso_, y).
food_available(saint_espresso_, y).
meal_type(saint_espresso_, no_full_meal).
meal_type(saint_espresso_, snack_pastry).
wifi_needed(saint_espresso_, n).
plug_needed(saint_espresso_, n).
wheelchair_accessible(saint_espresso_, y).
stars_rating(saint_espresso_, 4.3).
walking_distance(saint_espresso_, yes).
travel_distance(saint_espresso_, 1.1).
closing_time_weekday(saint_espresso_, 18:00 - 21:00).
closing_time_weekend(saint_espresso_, after_21).

% Study Spot: goswell_road_coffee_
study_spot(goswell_road_coffee_).
description(goswell_road_coffee_, "Snacks served and coffee brewed in a hip hangout with bike store, squashy sofas and high ceilings.").
address(goswell_road_coffee_, "160-164 Goswell Rd., London EC1V 7DU").
website(goswell_road_coffee_, "https://www.instagram.com/goswellroadcoffee/").
type(goswell_road_coffee_, cafe).
study_spot_preference(goswell_road_coffee_, paid).
coffee_available(goswell_road_coffee_, y).
food_available(goswell_road_coffee_, y).
meal_type(goswell_road_coffee_, full_meal).
meal_type(goswell_road_coffee_, snack_pastry).
wifi_needed(goswell_road_coffee_, y).
plug_needed(goswell_road_coffee_, y).
wheelchair_accessible(goswell_road_coffee_, y).
stars_rating(goswell_road_coffee_, 4.5).
walking_distance(goswell_road_coffee_, yes).
travel_distance(goswell_road_coffee_, 0.6).
closing_time_weekday(goswell_road_coffee_, 18:00 - 21:00).
closing_time_weekend(goswell_road_coffee_, after_21).

% Study Spot: fwd:coffee
study_spot(fwd:coffee).
description(fwd:coffee, "Leather sofas and vintage chandeliers adorn this exposed-brick cafe for artisan coffee and snacks.").
address(fwd:coffee, "161A Whitecross St, London EC1Y 8JL").
website(fwd:coffee, "https://fwdcoffee.co.uk/").
type(fwd:coffee, cafe).
study_spot_preference(fwd:coffee, paid).
coffee_available(fwd:coffee, y).
food_available(fwd:coffee, y).
meal_type(fwd:coffee, no_full_meal).
meal_type(fwd:coffee, snack_pastry).
wifi_needed(fwd:coffee, y).
plug_needed(fwd:coffee, y).
wheelchair_accessible(fwd:coffee, y).
stars_rating(fwd:coffee, 4.4).
walking_distance(fwd:coffee, yes).
travel_distance(fwd:coffee, 0.8).
closing_time_weekday(fwd:coffee, 18:00 - 21:00).
closing_time_weekend(fwd:coffee, after_21).

% Study Spot: cafebotanical
study_spot(cafebotanical).
description(cafebotanical, "An all day cafe and lounge specialising in organic, sustainable and vegetable forward menu. At night we turn the coffee in to a Gin & Tonic inspired by our homegrown hydrophobic farm.").
address(cafebotanical, "136 High Holborn, London WC1V 6PX").
website(cafebotanical, "https://www.cafebotanicalcom/").
type(cafebotanical, cafe).
study_spot_preference(cafebotanical, paid).
coffee_available(cafebotanical, y).
food_available(cafebotanical, y).
meal_type(cafebotanical, full_meal).
meal_type(cafebotanical, snack_pastry).
wifi_needed(cafebotanical, y).
plug_needed(cafebotanical, y).
wheelchair_accessible(cafebotanical, y).
stars_rating(cafebotanical, 4.5).
walking_distance(cafebotanical, yes).
travel_distance(cafebotanical, 2.4).
closing_time_weekday(cafebotanical, 18:00 - 21:00).
closing_time_weekend(cafebotanical, after_21).

% Study Spot: barbican_centre
study_spot(barbican_centre).
description(barbican_centre, "Cultural venue with concert hall, theatres, cinema, galleries and home of London Symphony Orchestra.").
address(barbican_centre, "Silk St, Barbican, London EC2Y 8DS").
website(barbican_centre, "https://www.barbican.org.uk/").
type(barbican_centre, library).
study_spot_preference(barbican_centre, free).
coffee_available(barbican_centre, y).
food_available(barbican_centre, y).
meal_type(barbican_centre, full_meal).
meal_type(barbican_centre, snack_pastry).
wifi_needed(barbican_centre, y).
plug_needed(barbican_centre, y).
wheelchair_accessible(barbican_centre, y).
stars_rating(barbican_centre, 4.6).
walking_distance(barbican_centre, yes).
travel_distance(barbican_centre, 1.2).
closing_time_weekday(barbican_centre, 18:00 - 21:00).
closing_time_weekend(barbican_centre, after_21).

% Study Spot: attendant_coffee_roasters_shoreditch
study_spot(attendant_coffee_roasters_shoreditch).
description(attendant_coffee_roasters_shoreditch, "Laid-back cafe serving coffee, breakfasts & light lunches with ethically sourced ingredients.").
address(attendant_coffee_roasters_shoreditch, "74 Great Eastern St, London EC2A 3JL, United Kingdom").
website(attendant_coffee_roasters_shoreditch, "https://www.the-attendant.com/pages/shoreditch").
type(attendant_coffee_roasters_shoreditch, cafe).
study_spot_preference(attendant_coffee_roasters_shoreditch, paid).
coffee_available(attendant_coffee_roasters_shoreditch, y).
food_available(attendant_coffee_roasters_shoreditch, y).
meal_type(attendant_coffee_roasters_shoreditch, full_meal).
meal_type(attendant_coffee_roasters_shoreditch, snack_pastry).
wifi_needed(attendant_coffee_roasters_shoreditch, y).
plug_needed(attendant_coffee_roasters_shoreditch, n).
wheelchair_accessible(attendant_coffee_roasters_shoreditch, n).
stars_rating(attendant_coffee_roasters_shoreditch, 4.3).
walking_distance(attendant_coffee_roasters_shoreditch, yes).
travel_distance(attendant_coffee_roasters_shoreditch, 1.2).
closing_time_weekday(attendant_coffee_roasters_shoreditch, 18:00 - 21:00).
closing_time_weekend(attendant_coffee_roasters_shoreditch, after_21).

% Study Spot: national_art_library_
study_spot(national_art_library_).
description(national_art_library_, "The UK's most comprehensive public reference collection of literature on the fine and decorative arts, including books, journals and much more.").
address(national_art_library_, "Cromwell Rd, London SW7 2RL, United Kingdom").
website(national_art_library_, "http://www.vam.ac.uk/nal/").
type(national_art_library_, library).
study_spot_preference(national_art_library_, free).
coffee_available(national_art_library_, n).
food_available(national_art_library_, n).
meal_type(national_art_library_, no_full_meal).
meal_type(national_art_library_, no_snack_pastry).
wifi_needed(national_art_library_, n).
plug_needed(national_art_library_, y).
wheelchair_accessible(national_art_library_, y).
stars_rating(national_art_library_, 4.4).
walking_distance(national_art_library_, no).
travel_distance(national_art_library_, 6.7).
closing_time_weekday(national_art_library_, 18:00 - 21:00).
closing_time_weekend(national_art_library_, after_21).

% Study Spot: wellcome_collection
study_spot(wellcome_collection).
description(wellcome_collection, "Rotating exhibits connecting medicine & art, plus a library, reading room & shop.").
address(wellcome_collection, "183 Euston Rd., London NW1 2BE, United Kingdom").
website(wellcome_collection, "https://wellcomecollection.org/").
type(wellcome_collection, library).
study_spot_preference(wellcome_collection, free).
coffee_available(wellcome_collection, y).
food_available(wellcome_collection, y).
meal_type(wellcome_collection, full_meal).
meal_type(wellcome_collection, snack_pastry).
wifi_needed(wellcome_collection, y).
plug_needed(wellcome_collection, n).
wheelchair_accessible(wellcome_collection, y).
stars_rating(wellcome_collection, 4.5).
walking_distance(wellcome_collection, no).
travel_distance(wellcome_collection, 3.0).
closing_time_weekday(wellcome_collection, 18:00 - 21:00).
closing_time_weekend(wellcome_collection, after_21).

% Study Spot: senate_house_library_
study_spot(senate_house_library_).
description(senate_house_library_, "The central library for the University of London. One of the UK's largest academic libraries for arts, humanities & social sciences.").
address(senate_house_library_, "Senate House, University of, Malet St, London WC1E 7HU, United Kingdom").
website(senate_house_library_, "https://www.london.ac.uk/senate-house-library").
type(senate_house_library_, library).
study_spot_preference(senate_house_library_, free).
coffee_available(senate_house_library_, y).
food_available(senate_house_library_, n).
meal_type(senate_house_library_, no_full_meal).
meal_type(senate_house_library_, no_snack_pastry).
wifi_needed(senate_house_library_, y).
plug_needed(senate_house_library_, y).
wheelchair_accessible(senate_house_library_, y).
stars_rating(senate_house_library_, 4.5).
walking_distance(senate_house_library_, no).
travel_distance(senate_house_library_, 2.7).
closing_time_weekday(senate_house_library_, 18:00 - 21:00).
closing_time_weekend(senate_house_library_, after_21).

% Study Spot: chestnut_bakery
study_spot(chestnut_bakery).
description(chestnut_bakery, "Centrally located cafe serving artisanal baked goods with a nordic aesthetic. ").
address(chestnut_bakery, "24 Floral St, London WC2E 9DS, United Kingdom").
website(chestnut_bakery, "http://www.chestnutbakery.com/").
type(chestnut_bakery, cafe).
study_spot_preference(chestnut_bakery, paid).
coffee_available(chestnut_bakery, y).
food_available(chestnut_bakery, y).
meal_type(chestnut_bakery, full_meal).
meal_type(chestnut_bakery, snack_pastry).
wifi_needed(chestnut_bakery, y).
plug_needed(chestnut_bakery, y).
wheelchair_accessible(chestnut_bakery, y).
stars_rating(chestnut_bakery, 4.2).
walking_distance(chestnut_bakery, no).
travel_distance(chestnut_bakery, 3.2).
closing_time_weekday(chestnut_bakery, 18:00 - 21:00).
closing_time_weekend(chestnut_bakery, after_21).

% Study Spot: bench
study_spot(bench).
description(bench, "Trendy coffeehouse with daytime eats served in a hip, airy space with communal seating & a patio.").
address(bench, "42 Britton St, London EC1M 5AD, United Kingdom").
website(bench, "http://www.benchlondon.com/").
type(bench, cafe).
study_spot_preference(bench, paid).
coffee_available(bench, y).
food_available(bench, y).
meal_type(bench, full_meal).
meal_type(bench, snack_pastry).
wifi_needed(bench, y).
plug_needed(bench, n).
wheelchair_accessible(bench, y).
stars_rating(bench, 4.3).
walking_distance(bench, no).
travel_distance(bench, 4.3).
closing_time_weekday(bench, 18:00 - 21:00).
closing_time_weekend(bench, after_21).

% Study Spot: briki
study_spot(briki).
description(briki, "Light-filled cafe and deli for carefully sourced coffee and a Mediterranean-influenced menu.").
address(briki, "67 Exmouth Market, London EC1R 4QL, United Kingdom").
website(briki, "https://www.instagram.com/brikilondon/?hl=en").
type(briki, cafe).
study_spot_preference(briki, paid).
coffee_available(briki, y).
food_available(briki, y).
meal_type(briki, full_meal).
meal_type(briki, snack_pastry).
wifi_needed(briki, y).
plug_needed(briki, y).
wheelchair_accessible(briki, y).
stars_rating(briki, 4.5).
walking_distance(briki, yes).
travel_distance(briki, 0.9).
closing_time_weekday(briki, 18:00 - 21:00).
closing_time_weekend(briki, after_21).

% Study Spot: katsute_100
study_spot(katsute_100).
description(katsute_100, "Cosy hangout spotlighting creative Japanese desserts, plus sake, specialty drinks & loose leaf teas.").
address(katsute_100, "100 Islington High St, London N1 8EG, United Kingdom").
website(katsute_100, "http://www.katsute100.com/").
type(katsute_100, cafe).
study_spot_preference(katsute_100, paid).
coffee_available(katsute_100, y).
food_available(katsute_100, y).
meal_type(katsute_100, no_full_meal).
meal_type(katsute_100, snack_pastry).
wifi_needed(katsute_100, y).
plug_needed(katsute_100, n).
wheelchair_accessible(katsute_100, y).
stars_rating(katsute_100, 4.5).
walking_distance(katsute_100, yes).
travel_distance(katsute_100, 0.9).
closing_time_weekday(katsute_100, 18:00 - 21:00).
closing_time_weekend(katsute_100, after_21).

% Study Spot: burr_co_london
study_spot(burr_co_london).
description(burr_co_london, "Relaxed cafe with coffee, wine & creative takes on traditional fare, plus Saturday brunch with DJs.").
address(burr_co_london, "1 Russell Sq, London WC1B 5BE, United Kingdom").
website(burr_co_london, "https://www.kimptonfitzroylondon.com/us/en/london-restaurant/burr-and-co").
type(burr_co_london, cafe).
study_spot_preference(burr_co_london, paid).
coffee_available(burr_co_london, y).
food_available(burr_co_london, y).
meal_type(burr_co_london, full_meal).
meal_type(burr_co_london, snack_pastry).
wifi_needed(burr_co_london, y).
plug_needed(burr_co_london, y).
wheelchair_accessible(burr_co_london, y).
stars_rating(burr_co_london, 3.8).
walking_distance(burr_co_london, yes).
travel_distance(burr_co_london, 2.4).
closing_time_weekday(burr_co_london, 18:00 - 21:00).
closing_time_weekend(burr_co_london, after_21).

% Study Spot: commons_at_old_street_works
study_spot(commons_at_old_street_works).
description(commons_at_old_street_works, "Trendy cafe with pink interior, popular for studying and take out coffees. ").
address(commons_at_old_street_works, "207 City Rd, London EC1V 1JT, United Kingdom").
website(commons_at_old_street_works, "http://www.commonsat.co.uk/").
type(commons_at_old_street_works, cafe).
study_spot_preference(commons_at_old_street_works, paid).
coffee_available(commons_at_old_street_works, y).
food_available(commons_at_old_street_works, y).
meal_type(commons_at_old_street_works, full_meal).
meal_type(commons_at_old_street_works, snack_pastry).
wifi_needed(commons_at_old_street_works, y).
plug_needed(commons_at_old_street_works, y).
wheelchair_accessible(commons_at_old_street_works, n).
stars_rating(commons_at_old_street_works, 5.0).
walking_distance(commons_at_old_street_works, yes).
travel_distance(commons_at_old_street_works, 0.4).
closing_time_weekday(commons_at_old_street_works, 18:00 - 21:00).
closing_time_weekend(commons_at_old_street_works, after_21).

% Study Spot: the_hoxton
study_spot(the_hoxton).
description(the_hoxton, "High end hotel popular with business travelers, featuring a main-floor cafe and coworking area.").
address(the_hoxton, "81 Great Eastern St, London EC2A 3HU, United Kingdom").
website(the_hoxton, "https://thehoxton.com/london/shoreditch/hoxton-grill-restaurant/").
type(the_hoxton, cafe).
study_spot_preference(the_hoxton, paid).
coffee_available(the_hoxton, y).
food_available(the_hoxton, y).
meal_type(the_hoxton, full_meal).
meal_type(the_hoxton, snack_pastry).
wifi_needed(the_hoxton, y).
plug_needed(the_hoxton, y).
wheelchair_accessible(the_hoxton, y).
stars_rating(the_hoxton, 4.4).
walking_distance(the_hoxton, yes).
travel_distance(the_hoxton, 1.2).
closing_time_weekday(the_hoxton, 18:00 - 21:00).
closing_time_weekend(the_hoxton, after_21).

% Study Spot: waterstones
study_spot(waterstones).
description(waterstones, "A mainstream and academic book retailer that encourages browsing; some stores have cafes.").
address(waterstones, "11 Islington Grn, London N1 2XH, United Kingdom").
website(waterstones, "https://www.waterstones.com/bookshops/islington").
type(waterstones, cafe).
study_spot_preference(waterstones, paid).
coffee_available(waterstones, y).
food_available(waterstones, n).
meal_type(waterstones, no_full_meal).
meal_type(waterstones, no_snack_pastry).
wifi_needed(waterstones, n).
plug_needed(waterstones, y).
wheelchair_accessible(waterstones, y).
stars_rating(waterstones, 4.6).
walking_distance(waterstones, yes).
travel_distance(waterstones, 1.1).
closing_time_weekday(waterstones, 18:00 - 21:00).
closing_time_weekend(waterstones, after_21).

% Study Spot: dishoom_kings_cross
study_spot(dishoom_kings_cross).
description(dishoom_kings_cross, "Buzzy destination for Indian street food in Bombay-style digs with vintage decor & upscale touches.").
address(dishoom_kings_cross, "5 Stable St, London N1C 4AB, United Kingdom").
website(dishoom_kings_cross, "https://www.dishoom.com/kings-cross?utm_source=google&utm_medium=organic&utm_campaign=Yext&utm_content=D3-KingsCross&y_source=1_MjMwNDkyMDItNzE1LWxvY2F0aW9uLndlYnNpdGU%3D").
type(dishoom_kings_cross, cafe).
study_spot_preference(dishoom_kings_cross, paid).
coffee_available(dishoom_kings_cross, y).
food_available(dishoom_kings_cross, y).
meal_type(dishoom_kings_cross, full_meal).
meal_type(dishoom_kings_cross, snack_pastry).
wifi_needed(dishoom_kings_cross, y).
plug_needed(dishoom_kings_cross, n).
wheelchair_accessible(dishoom_kings_cross, y).
stars_rating(dishoom_kings_cross, 4.6).
walking_distance(dishoom_kings_cross, no).
travel_distance(dishoom_kings_cross, 2.5).
closing_time_weekday(dishoom_kings_cross, 18:00 - 21:00).
closing_time_weekend(dishoom_kings_cross, after_21).

% Study Spot: foyles
study_spot(foyles).
description(foyles, "Large, multi-genre bookstore spread over 5 floors, also selling CD/DVDs, plus jazz cafe and events.").
address(foyles, "107 Charing Cross Rd, London WC2H 0DT, United Kingdom").
website(foyles, "http://www.foyles.co.uk/").
type(foyles, cafe).
study_spot_preference(foyles, paid).
coffee_available(foyles, y).
food_available(foyles, y).
meal_type(foyles, full_meal).
meal_type(foyles, snack_pastry).
wifi_needed(foyles, y).
plug_needed(foyles, y).
wheelchair_accessible(foyles, y).
stars_rating(foyles, 4.7).
walking_distance(foyles, no).
travel_distance(foyles, 3.0).
closing_time_weekday(foyles, 18:00 - 21:00).
closing_time_weekend(foyles, after_21).

% Study Spot: kensington_central_library
study_spot(kensington_central_library).
description(kensington_central_library, "State owned library popular with students and working professionals alike. ").
address(kensington_central_library, "12 Phillimore Walk, London W8 7RX, United Kingdom").
website(kensington_central_library, "http://www.rbkc.gov.uk/libraries").
type(kensington_central_library, library).
study_spot_preference(kensington_central_library, free).
coffee_available(kensington_central_library, n).
food_available(kensington_central_library, n).
meal_type(kensington_central_library, no_full_meal).
meal_type(kensington_central_library, no_snack_pastry).
wifi_needed(kensington_central_library, y).
plug_needed(kensington_central_library, y).
wheelchair_accessible(kensington_central_library, y).
stars_rating(kensington_central_library, 4.5).
walking_distance(kensington_central_library, no).
travel_distance(kensington_central_library, 8.0).
closing_time_weekday(kensington_central_library, 18:00 - 21:00).
closing_time_weekend(kensington_central_library, after_21).

% Study Spot: hilton_london_tower_bridge
study_spot(hilton_london_tower_bridge).
description(hilton_london_tower_bridge, "Renowned hotel near London's central tourist destinations, featuring ample seating and coffee. ").
address(hilton_london_tower_bridge, "5 More London Pl, Tooley St, London SE1 2BY, United Kingdom").
website(hilton_london_tower_bridge, "https://www.hilton.com/en/hotels/lontbhi-hilton-london-tower-bridge/?SEO_id=GMB-EMEA-HI-LONTBHI").
type(hilton_london_tower_bridge, cafe).
study_spot_preference(hilton_london_tower_bridge, paid).
coffee_available(hilton_london_tower_bridge, y).
food_available(hilton_london_tower_bridge, y).
meal_type(hilton_london_tower_bridge, full_meal).
meal_type(hilton_london_tower_bridge, snack_pastry).
wifi_needed(hilton_london_tower_bridge, n).
plug_needed(hilton_london_tower_bridge, y).
wheelchair_accessible(hilton_london_tower_bridge, y).
stars_rating(hilton_london_tower_bridge, 4.4).
walking_distance(hilton_london_tower_bridge, no).
travel_distance(hilton_london_tower_bridge, 3.7).
closing_time_weekday(hilton_london_tower_bridge, 18:00 - 21:00).
closing_time_weekend(hilton_london_tower_bridge, after_21).

% Study Spot: redemption_roasters
study_spot(redemption_roasters).
description(redemption_roasters, "Trendy cafe popular for studying and remote working on weekdays, located in Islington. ").
address(redemption_roasters, "96-98 Islington High St, London N1 8EG, United Kingdom").
website(redemption_roasters, "https://www.redemptionroasters.com/locations/islington-high-street/#menu?utm_source=GMB&utm_medium=organic").
type(redemption_roasters, cafe).
study_spot_preference(redemption_roasters, paid).
coffee_available(redemption_roasters, y).
food_available(redemption_roasters, y).
meal_type(redemption_roasters, full_meal).
meal_type(redemption_roasters, snack_pastry).
wifi_needed(redemption_roasters, y).
plug_needed(redemption_roasters, n).
wheelchair_accessible(redemption_roasters, y).
stars_rating(redemption_roasters, 4.1).
walking_distance(redemption_roasters, yes).
travel_distance(redemption_roasters, 0.9).
closing_time_weekday(redemption_roasters, 18:00 - 21:00).
closing_time_weekend(redemption_roasters, after_21).
