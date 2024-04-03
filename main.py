from pyswip import Prolog, Functor, call, registerForeign
from pyswip.easy import *

# Simulate a simple foreign function
# (normally used to interact with Python functions)
def read_py(query, answer, *args):
    pass  # Placeholder function to be replaced as needed.


# Simplified main function
def main():
    prolog = Prolog()  # Create a Prolog instance

    # Load the knowledge base from the KB.pl file
    try:
        prolog.consult("KB.pl")
    except Exception as e:
        print(e)
        print(
            "Failed to load the knowledge base. Please make sure KB.pl is in the correct directory." 
        )
        return

    # Ask the user for the current weather
    weather = input("What's the weather like (sunny/rainy)? ").strip().lower()

    # Create a proper Prolog atom
    weather_atom = Functor(weather)
    query = f"activity({weather_atom}, Activity)"

    # Get recommendations
    recommendations = list(prolog.query(query))

    # Provide a recommendation
    if recommendations:
        for recommendation in recommendations:
            print(
                f"Based on the current weather, you should {recommendation['Activity']}."
            )
    else:
        print("Sorry, no recommendations for this weather.")

    print("Thank you for using our service!")


if __name__ == "__main__":
    main()
