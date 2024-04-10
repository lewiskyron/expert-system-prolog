from pyswip import Prolog, Functor, call, registerForeign
from pyswip.easy import *

prompts = {
 #   "day_preference": "Is it the weekday or the weekend?",
#    "closing_time": "How late do you need the study spot to be available until?",
    "study_spot_preference": "Do you want a free or paid study spot?",
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
 #   "day_preference": ["Weekday", "Weekend"],
 #   "closing_time": ["Before 18:00", "18:00 - 21:00", "After 21:00"],
    "study_spot_preference": ["Free", "Paid", "No preference"],
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


def load_knowledge_base(filename="KB.pl"):
    try:
        prolog.consult(filename)
        print("Knowledge base loaded successfully.")
        return prolog
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
        print(f"  {idx}. {choice}")
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

        # Dynamically decide the next question or filter recommendations based on the response
        filter_prompts = ['study_spot_preference','food_available']
        if attribute in filter_prompts:
            next_question = get_next_question_based_on_rule(attribute, response)
            print("Next question: ", next_question)
            if next_question:
                idx = key_list.index(next_question)
        else:
            idx += 1
    return user_responses


def assert_response(attribute, response, prolog):
    # Convert the attribute to a valid Prolog atom if necessary (e.g., replacing spaces with underscores)
    prolog_attribute = attribute.replace(" ", "_").lower()
    
    # Ensure response is correctly formatted as a Prolog term
    # If response is a string, enclose it in single quotes for Prolog
    if isinstance(response, str):
        prolog_response = response.lower()
        # Escape single quotes in the response
        prolog_response = prolog_response.replace("'", "\\'")
        # Enclose in single quotes
        prolog_response = f"'{prolog_response}'"
    else:
        prolog_response = response

    # Prepare the Prolog assertion
    fact = f"assertz({prolog_attribute}({prolog_response}))"
    
    # Check if an answer with prolog_response exists before retracting
    try:
        if list(prolog.query(f"answer({prolog_attribute}, _)")):
            prolog.retract(f"answer({prolog_attribute}, _)")
    except StopIteration:
        pass  # Ignore the StopIteration error if no answer is found

    # Assert the new response
    prolog.assertz(f"answer({prolog_attribute}, '{prolog_response}')")


    # Check if an answer with prolog_response exists before retracting
    try:
        if list(prolog.query(f"answer({prolog_attribute}, _)")):
            prolog.retract(f"answer({prolog_attribute}, _)")
    except StopIteration:
        pass  # Ignore the StopIteration error if no answer is found

    # Assert the new response
    prolog.assertz(f"answer({prolog_attribute}, '{prolog_response}')")


    # Assert the fact in Prolog
    fact = f"{prolog_attribute}('{prolog_response}')"
    prolog.assertz(fact)


def query_kb_for_recommendations(query_predicate, result_var="Recommendation"):
    # Construct the query string
    query_str = f"{query_predicate}({result_var})"
    # Execute the query
    query_result = list(prolog.query(query_str))
    # Process and return the results
    recommendations = [result[result_var] for result in query_result]
    return recommendations


def read_py(attribute, *args):
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
                    return choice_list[
                        response - 1
                    ].lower()  # Return the choice in lowercase
                else:
                    print("Invalid choice, please try again.")
            except ValueError:
                print("Please enter a number.")
    else:
        # Handle open-ended questions
        response = input(f"{prompt}: ").strip().lower()
        return response


def handle_expert_system_logic(user_responses, prolog):
    # Assert responses as facts
    for attribute, response in user_responses.items():
        assert_response(attribute, response, prolog)

    # Query for recommendations
    recommendations = query_kb_for_recommendations("find_study_spot", prolog)

    # Display recommendations
    if recommendations:
        for rec in recommendations:
            print(f"Recommended Study Spot: {rec}")
    else:
        print("Sorry, no recommendations based on your preferences.")

    # # Reset KB facts for a clean state
    # reset_kb_facts(list(user_responses.keys()), prolog)


# Simplified main function
def main():
    load_knowledge_base()
    user_responses = collect_user_responses(prompts, choices)
    handle_expert_system_logic(user_responses, prolog)

    print("Thank you for using our service!")


if __name__ == "__main__":
    main()
