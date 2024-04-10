from pyswip import Prolog, Variable, Functor, Atom, registerForeign
from pyswip.easy import *

prompts = {
    # "day_preference": "Is it the weekday or the weekend?",
    # "closing_time": "How late do you need the study spot to be available until?",
    "payment_preference": "Do you want a free or paid study spot?",
    "coffee_available": "Do you want a study spot that has coffee available?",
    "food_available": "Do you want a study spot that has food available?",
    "meal_type": "Do you want a full meal or a snack/pastry?",
    "walking_distance": "Do you want the cafe to be within walking distance?",
    "travel_distance": "How far are you willing to travel for your study spot?",
    "plug_needed": "Do you need a plug/outlet?",
    "wifi_needed": "Do you need a study space with free Wifi?",
    "minimum_stars": "Minimum stars (like Google reviews)",
    "wheelchair_accessible": "Do you need your study spot to be wheelchair accessible?",
}

choices = {
    # "day_preference": ["Weekday", "Weekend"],
    # "closing_time": ["Before 18:00", "18:00 - 21:00", "After 21:00"],
    "payment_preference": ["Free", "Paid", "No preference"],
    "coffee_available": ["Yes", "No"],
    "food_available": ["Yes", "No"],
    "meal_type": ["Full meal", "Snack/Pastry", "No preference"],
    "walking_distance": ["Yes", "No"],
    "travel_distance": ["less_than_5km", "more_than_5km"],
    "plug_needed": ["Yes", "No"],
    "wifi_needed": ["Yes", "No"],
    "minimum_stars": ["1", "2", "3", "4", "5"],
    "wheelchair_accessible": ["Yes", "No", "No preference"],
}

prolog = Prolog()


def load_knowledge_base(filename,retractall, known):
    try:
        prolog.consult(filename)
        print("Knowledge base loaded successfully.")
        call(retractall(known))
        return 
    except Exception as e:
        print(f"Failed to load the knowledge base: {e}")
        return None


def read_choice(prompt, choice_list):
    print(
        "---------------------------------------"
        + "\n"
        + prompt
        + "\n"
        + "---------------------------------------"
    )
    for idx, choice in enumerate(choice_list, start=1):
        print(f"{idx}, {choice}")
    print("\nPlease enter the number of your choice:", end=" ")

    while True:
        response = input().strip()
        if response.isdigit():
            response = int(response)
            if 1 <= response <= len(choice_list):
                print(
                    f"You selected: {choice_list[response - 1]}"
                )  # Feedback on choice
                return choice_list[response - 1].lower()
            else:
                print("Invalid choice, please try again:", end=" ")
        else:
            print("Please enter a number:", end=" ")


def get_next_question_based_on_rule(current_question, response):
    prolog.assertz(f"answer({current_question}, '{response}')")
    next_question_result = list(
        prolog.query(f"next_question({current_question}, NextQuestion)")
    )
    print("KB response: ", next_question_result)
    if next_question_result:
        return next_question_result[0]["NextQuestion"]
    return None


def collect_user_responses(prompts, choices):
    user_responses = {}
    idx = 0
    key_list = list(prompts.keys())
    while idx < len(prompts):
        attribute = key_list[idx]
        prompt_text = prompts[attribute]
        choice_list = choices.get(attribute)

        response = read_choice(prompt_text, choice_list)
        user_responses[attribute] = response
        print("User responses: ", user_responses)
        assert_response(attribute, response.lower())

        # Dynamically decide the next question or filter recommendations based on the response
        filter_prompts = ["payment_preference", "food_available"]
        if attribute in filter_prompts:
            next_question = get_next_question_based_on_rule(attribute, response)
            print("Next question: ", next_question)
            if next_question:
                idx = key_list.index(next_question)
        else:
            idx += 1

    return user_responses


def assert_response(attribute, response):
    # Convert the attribute to a valid Prolog atom if necessary

    prolog_attribute = attribute.replace(" ", "_").lower()
    print("Prolog attribute: ", prolog_attribute)
    prolog_response = response.lower()

    # Retract previous answers (if any)
    prolog_query = f"answer('{prolog_response}', {prolog_attribute})"
    prolog.assertz(prolog_query)


# def query_kb_for_recommendations(query_predicate, result_var="Recommendation"):
#     # Construct the query string
#     query_str = f"{query_predicate}({result_var})"
#     # Execute the query
#     query_result = list(prolog.query(query_str))
#     # Process and return the results
#     recommendations = [result[result_var] for result in query_result]
#     return recommendations


def read_py(attribute, value, user_responses):
    prompt = prompts[attribute]
    choice_list = choices.get(attribute)  # Get choices for the attribute, if any

    if choice_list:
        print(prompt)
        for idx, choice in enumerate(choice_list, start=1):
            print(f"{idx}. {choice}")
        while True:
            try:
                response = int(input("Enter the number of your choice: ").strip())
                if 1 <= response <= len(choice_list):
                    selected_choice = choice_list[response - 1].lower()
                    user_responses.unify(selected_choice)  # Unification! # Return the choice in lowercase
                else:
                    print("Invalid choice, please try again.")
            except ValueError:
                print("Please enter a number.")
        
    else:
        # Handle open-ended questions
        response = input(f"{prompt}: ").strip().lower()
        return response


def handle_expert_system_logic():

   # Query for recommendations
    recommendations = list(prolog.query("recommendation(StudySpot)"))
    if recommendations:
       names = [rec["StudySpot"] for rec in recommendations]
       print(f"Based on your preferences, you might like: {', '.join(names)}")
    else:
       print("Sorry, no recommendations match your preferences.")


# Simplified main function
def main():
    retractall = Functor("retractall") # remove all items from Knowledge Base
    known = Functor("answer", 2) # predicate for storing user responses
    read_py.arity = 3
    registerForeign(read_py)
    filename = "KB.pl"
    load_knowledge_base(filename,retractall, known)
    user_responses = collect_user_responses(prompts, choices)
    handle_expert_system_logic()

    print("Thank you for using our service!")


if __name__ == "__main__":
    main()
