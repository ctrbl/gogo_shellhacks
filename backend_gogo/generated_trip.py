import json
import openai
from datetime import datetime

model_id = 'gpt-4'
openai.api_key = "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"

def trip_generator(
    location=None,
    num_of_people=None,
    start_date=None,
    end_date=None,
    budget=None,
    mode_of_transportation=None,
    start_time=None,
    end_time=None,
    day_length=None,
    preferences=None
    ):
    # Check for null values and provide example values
    if location == '':
        location = 'California'

    if num_of_people == '':
        num_of_people = 4

    if start_date == '':
        start_date = '2023-01-01'

    if end_date == '':
        end_date = '2023-01-05'

    if budget == '':
        budget = 1000

    if mode_of_transportation == '':
        mode_of_transportation = 'Car'

    if start_time == '':
        start_time = '8:10 AM'

    if end_time == '':
        end_time = '10:00 PM'

    if day_length == '':
        day_length = 4

    if preferences ==    '':
        preferences = 'Food & Drinks, Adventure, Cultural & Arts'

    
    # extract preference
    list_preference = preferences.split(', ')
    
    new_list_preference = []
    
    # preference dict 
    category_descriptions = {
    'Food & Drinks': 'Places to eat local cuisine and enjoy beverages.',
    'Adventure': 'Opportunities for thrilling outdoor experiences and activities.',
    'Attractions': 'Notable places and landmarks to visit for entertainment and exploration.',
    'Nature': 'Natural environments, parks, and scenic spots for outdoor enthusiasts.',
    'Cultural & Arts': 'Museums, galleries, and cultural sites showcasing art and heritage.',
    'Shopping': 'Retail destinations for purchasing various goods and souvenirs.',
    'Sports': 'Venues and events for sports enthusiasts and active participation.',
    'Religious': 'Sacred and spiritual sites for worship and reflection.'
    }
    
    for preference in list_preference:
        new_list_preference.append('some place to ' + category_descriptions.get(preference))
        
    delimiter = ", "
    preference_string = delimiter.join(new_list_preference)


    def chatgpt_conversation(messageContent):
        

        
        response = openai.ChatCompletion.create(
            model=model_id,
            messages=[
                {
                    "role": "system",
                    "content": "You are an experienced travel agent that speaks only in JSON. Do not speak normal text.",
                },
                {
                    "role": "user",
                    "content": messageContent,
                },
            ],
            temperature=0.7,
        )
        return response['choices'][0]['message']['content']

    # Example user prompt (you can replace this with your own)
    user_prompt = f'''
    'I am planning a trip to {location} last for {day_length} days, from date {start_date} and end at date {end_date}. We are a group of {num_of_people} people and we are a group of friends. 
    We want to start our day at around {start_time} and we end our day around {end_time}. We are looking for places and activities that align
    with a budget of ${budget}. We prefer to get around by {mode_of_transportation}. 
    Could you suggest an itinerary, make sure the number of places each day is between 2 to 5 places to visit and activities to do, organized in a logical sequence based on the types of activities and their general geographic proximity? 
    Those places that you suggest must have the following conditions (try to recommend places that satisfy the conditions) {preference_string}
    Please consider rough transit times between locations using our preferred mode of transportation.
    For each item, provide the name of the place, a brief description of why we should visit or what we could do there, an estimated duration of the visit (the unit has to be hour),
    a suggested start time, categorized each location into one of the following categories: (restaurant, flight, museum, shopping, attraction, beauty, nature, sports, religious, boba, coffee)
    and a rough estimated transit time to the next location, keeping in mind our start and end times. 
    Also, add a date as the date you want the activities you plan to be, start from the start date I provided you earlier and end at the end date. Make sure that each and every day has at least 1 activity.
    Please return the itinerary back as a JSON object with an array of results. This is what the JSON should look like: 
        {{
            "results":
            [
                {{
                    "name": "name of place",
                    "location": "detailed address with street name, city, state (1000 5th Ave, New York, NY)",
                    "estimatedDuration": "1 hour 30 minutes",
                    "estimatedStartTime": "10 AM",
                    "description": "why you should come here or what you should do",
                    "transitTime": "30 minutes",
                    "category": "restaurant",
                    "date": "2023-09-20"
                }},
                {{
                    "name": "name of place",
                    "location": "detailed address with street name, city, state (1000 5th Ave, New York, NY)",
                    "estimatedDuration": "2 hours",
                    "estimatedStartTime": "12 PM",
                    "description": "why you should come here or what you should do",
                    "transitTime": "30 minutes",
                    "category": "museum",
                    "date": "2023-09-21"
                }}
            ]
        }}
    '''

    # Get a response from the ChatGPT model
    gpt_result = chatgpt_conversation(user_prompt)
    
    # print
    print("This is the prompt", user_prompt)

    # Parse the response string to JSON
    gpt_result_json = json.loads(gpt_result)
    
    return gpt_result_json
