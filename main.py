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
    "meal_type": ["Full meal", "Snack", "No preference"],
    "walking_distance": ["Yes", "No"],
    "travel_distance": ["less_than_5km", "more_than_5km"],
    "plug_needed": ["Yes", "No"],
    "wifi_needed": ["Yes", "No"],
    "minimum_stars": ["1", "2", "3", "4", "5"],
    "wheelchair_accessible": ["Yes", "No", "No preference"],
}

prolog = Prolog()


def load_knowledge_base(filename,retractall, know):
    try:
        prolog.consult(filename)
        print("Knowledge base loaded successfully.")
        call(retractall(know))
        return 
    except Exception as e:
        print(f"Failed to load the knowledge base: {e}")
        return None


def read_choice(prompt, choice_list):
    print("---------------------------------------")
    print(prompt)
    print("---------------------------------------")
    for idx, choice in enumerate(choice_list, start=1):
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


def get_next_question_based_on_rule(current_question, response):
    prolog.assertz(f"answer({current_question}, '{response}')")
    next_question_result = list(
        prolog.query(f"next_question({current_question}, NextQuestion)")
    )
    if next_question_result:
        return next_question_result[0]["NextQuestion"]
    return None


def collect_user_responses(prompts, choices):
    idx = 0
    key_list = list(prompts.keys())
    while idx < len(prompts):
        attribute = key_list[idx]
        prompt_text = prompts[attribute]
        choice_list = choices.get(attribute)

        response = read_choice(prompt_text, choice_list)
        user_responses[attribute] = response


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


def read_py(Attribute, V, Response):
    print("read_py function entered")  # At the beginning
    if isinstance(Response, Variable):
        if str(Attribute) not in user_responses.keys():
            prompt = prompts[str(Attribute)]  # More explicit
            choice_list = choices.get(str(Attribute))

            if choice_list:
                selected_choice = read_choice(prompt, choice_list)
            else:
                response = input(f"{prompt}: ").strip().lower()
                selected_choice = response

            user_responses[str(Attribute)] = selected_choice

        selected_choice = user_responses[str(Attribute)].lower()

        print("Selected choice: ", selected_choice)
        print("V: ", V)
        if user_responses[str(Attribute)] == str(V):
            response = "yes"
        else:
            response = "no"

        Response.unify(str(response))
        return True
    else:
        return False


def handle_expert_system_logic():
    recommendations = list(prolog.query("recommendation(X)"))
    if recommendations:
        print("Recommendations based on your preferences:")
        for recommendation in recommendations:
            print(recommendation["X"])
    else:
        print("No recommendations found based on your preferences.")


# Simplified main function
def main():
    global user_responses
    user_responses = {}
    retractall = Functor("retractall") # remove all items from Knowledge Base
    know = Functor("answer", 3) # predicate for storing user responses
    read_py.arity = 3
    registerForeign(read_py)
    filename = "KB.pl"
    load_knowledge_base(filename,retractall, know)
    handle_expert_system_logic()

    print("Thank you for using our service!")


if __name__ == "__main__":
    main()
