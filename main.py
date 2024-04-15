# find instruction in the readme.md on how to run this file.
from pyswip import Prolog, Variable, Functor, registerForeign
from pyswip.easy import *

prolog = Prolog()  # create a Prolog instance

# define answer options for each question
choices = {
    "payment_preference": ["Free", "Paid"],
    "coffee_available": ["Yes", "No"],
    "food_available": ["Yes", "No"],
    "meal_type": ["full_meal", "no_full_meal"],
    "walking_distance": ["Yes", "No"],
    "travel_distance": ["less_than_5km", "more_than_5km"],
    "plug_needed": ["Yes", "No"],
    "wifi_needed": ["Yes", "No"],
    "closing_time": ["17", "18", "19", "20", "21"],
    "wheelchair_accessible": ["Yes", "No"],
}

# define prompts for each question
prompts = {
    "payment_preference": "Do you want a free or paid study spot?",
    "coffee_available": "Do you want a study spot that has coffee available?",
    "food_available": "Do you want a study spot that has food available?",
    "meal_type": "Do you want a full meal or a snack/pastry?",
    "walking_distance": "Do you want the cafe to be within walking distance?",
    "travel_distance": "How far are you willing to travel for your study spot?",
    "plug_needed": "Do you need a plug/outlet?",
    "wifi_needed": "Do you need a study space with free Wifi?",
    "closing_time": "How late would you like to stay at the study spot?",
    "wheelchair_accessible": "Do you need your study spot to be wheelchair accessible?",
}

choices_natural_language = {  # for printing purposes
    "full_meal": "Full meal",
    "no_full_meal": "snack",
    "less_than_5km": "less than 5 km",
    "more_than_5km": "more than 5 km",
    "17": "5:00pm",
    "18": "6:00pm",
    "19": "7:00pm",
    "20": "8:00pm",
    "21": "9:00pm",
}

# dictionary of cafe names and links
recommendations_reference = {
    "saint_espresso": {
        "name": "Saint Espresso",
        "link": "http://www.saintespresso.com/",
    },
    "goswell_road_coffee": {
        "name": "Goswell Road Coffee",
        "link": "https://www.instagram.com/goswellroadcoffee/",
    },
    "gecko_coffeehouse": {
        "name": "Gecko",
        "link": "https://geckocoffee.house/pages/menu",
    },
    "the_british_library": {"name": "British Library", "link": "https://www.bl.uk/"},
    "cafebotanical": {
        "name": "Cafe Botanical",
        "link": "https://www.cafebotanical.com/",
    },
    "barbican_centre": {"name": "Barbican", "link": "https://www.barbican.org.uk/"},
    "attendant_coffee_roasters_shoreditch": {
        "name": "Attendant",
        "link": "https://www.the-attendant.com/pages/shoreditch",
    },
    "national_art_library": {
        "name": "National Art Library",
        "link": "http://www.vam.ac.uk/nal/",
    },
    "wellcome_collection": {
        "name": "Welcome Collection",
        "link": "https://wellcomecollection.org/",
    },
    "senate_house_library": {
        "name": "Senate House Library",
        "link": "https://www.london.ac.uk/senate-house-library",
    },
    "chestnut_bakery": {
        "name": "Chestnut Bakery",
        "link": "http://www.chestnutbakery.com/",
    },
    "bench": {"name": "Bench", "link": "http://www.benchlondon.com/"},
    "briki": {"name": "Briki", "link": "https://www.instagram.com/brikilondon/?hl=en"},
    "katsute_100": {"name": "Katsute 100", "link": "http://www.katsute100.com/"},
    "burr_co_london": {
        "name": "Burr",
        "link": "https://www.kimptonfitzroylondon.com/us/en/london-restaurant/burr-and-co",
    },
    "commons_at_old_street_works": {
        "name": "Commons",
        "link": "http://www.commonsat.co.uk/",
    },
    "the_hoxton": {
        "name": "The Hoxton",
        "link": "https://thehoxton.com/london/shoreditch/hoxton-grill-restaurant/",
    },
    "waterstones": {
        "name": "Waterstones",
        "link": "https://www.waterstones.com/bookshops/islington",
    },
    "dishoom_kings_cross": {
        "name": "Dishroom",
        "link": "https://www.dishoom.com/kings-cross?utm_source=google&utm_medium=organic&utm_campaign=Yext&utm_content=D3-KingsCross&y_source=1_MjMwNDkyMDItNzE1LWxvY2F0aW9uLndlYnNpdGU%3D",
    },
    "kensington_central_library": {
        "name": "Kensington",
        "link": "http://www.rbkc.gov.uk/libraries",
    },
    "hilton_london_tower_bridge": {
        "name": "Hilton",
        "link": "https://www.hilton.com/en/hotels/lontbhi-hilton-london-tower-bridge/?SEO_id=GMB-EMEA-HI-LONTBHI",
    },
    "redemption_roasters": {
        "name": "Redemption",
        "link": "https://www.redemptionroasters.com/locations/islington-high-street/#menu?utm_source=GMB&utm_medium=organic",
    },
    "pretamanger": {
        "name": "Pret A Manger",
        "link": "https://www.pret.co.uk/en-GB/our-menu",
    },
}


def load_knowledge_base(
    retractall,
    known,
    filename="none",
):
    # get the path to the KB file
    try:
        prolog.consult(
            filename
        )  # load the KB file (make sure you open the entire folder so it runs)
        call(retractall(known))  # remove all items from Knowledge Base
    except Exception as e:
        print(e)
        print("Check if your KB exists within this folder.")
        return


def sytstem_clock():
    try_again = input("\nDo you want to use the app again (y/n)? ")
    if try_again == "y":
        return True
    elif try_again == "n":
        print("Thank you for using our service!")
        return False


def generate_recommendations():
    study_spots = []
    for result in prolog.query("recommendation(X)."):
        study_spot_name = result["X"]
        study_spots.append(study_spot_name)

    return study_spots


def read_choice(Attribute, prompt, choice_list):
    print("---------------------------------------")
    print(prompt)
    print("---------------------------------------")

    special_print_attributes = ["meal_type", "travel_distance", "closing_time"]

    for idx, choice in enumerate(choice_list, start=1):
        if Attribute in special_print_attributes:
            # handles for special print cases
            print(f"{idx}. {choices_natural_language[choice]}")
        else:
            print(f"{idx}. {choice}")

    while True:
        response = input("Enter the number of your choice: ").strip()
        if response.isdigit():
            response = int(response)
            if 1 <= response <= len(choice_list):
                return choice_list[response - 1].lower()
            else:
                print("Invalid choice, please try again.")
        else:
            print("Please enter a number.")


# Define foreign function to read user input
def read_py(Attribute, V, Y):
    if isinstance(Y, Variable):
        # Check if the user has already answered this question. If not, ask it.
        Attribute = str(Attribute)
        if Attribute not in user_answers.keys():
            prompt = prompts[str(Attribute)]  # More explicit
            choice_list = choices.get(str(Attribute))

            if choice_list:
                selected_choice = read_choice(Attribute, prompt, choice_list)

            user_answers[Attribute] = selected_choice

        if user_answers[Attribute].lower() == str(V):
            response = "yes"
        else:
            response = "no"
        # unify the user's response to the variable Y
        fact = f"fact({Attribute}, '{user_answers[Attribute]}')"
        # print(fact)
        # prolog.assertz(fact)
        Y.unify(str(response))
        return True
    else:  # if Y is not a variable, return False
        return False


def system_engine():
    """Main function to run the program."""

    while True:  # keeps repeating until user enters 'n' to stop the program
        global user_answers
        user_answers = {}  # store user responses to questions
        # Define predicates
        retractall = Functor("retractall")  # remove all items from Knowledge Base
        known = Functor("known", 3)  # predicate for storing user responses

        read_py.arity = 3  # set the arity of the foreign function
        registerForeign(read_py)  # register the foreign function
        load_knowledge_base(retractall, known, filename="study_KB.pl")

        recommendations = generate_recommendations()

        # printing out the recommendation
        if recommendations:
            if len(recommendations) == 1:
                study_spot = recommendations[0]
                print(
                    f"\nGreat news! We found a perfect match. Check out {recommendations_reference[study_spot]['name']}!: {recommendations_reference[study_spot]['link']}"
                )

            elif len(recommendations) > 1:
                print(
                    "Well its you lucky day today! You have multiple spots to pick from. Fell free to pick any of the ones below: "
                )

                for idx in range(len(recommendations)):

                    study_spot = recommendations[idx]
                    print(
                        f"{idx}. {recommendations_reference[study_spot]['name']}: {recommendations_reference[study_spot]['link']}"
                    )

            if sytstem_clock():
                continue
            else:
                break

        else:
            print(
                "\nUnfortunately, we could not find a restaurant that matches your criteria."
            )
            if sytstem_clock():
                continue
            else:
                break


if __name__ == "__main__":
    system_engine()
