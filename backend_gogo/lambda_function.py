import uuid     
import json
import openai
from datetime import datetime
import requests


# import extra
import generated_trip
import google_function

# KEY
google_api = "AIzaSyDQAaDi2Dtvm_qTHVetcZY4LX1UMIeE2yw"


def lambda_handler(event, context):
    
    json_string = event['body']


    try:
        # Parse the JSON string into a dictionary
        data = json.loads(json_string)

        # Extract data from the dictionary
        location = data['location']
        num_of_people = data['num_of_people']
        start_date = data['start_date']
        end_date = data['end_date']
        budget = data['budget']
        mode_of_transportation = data['mode_of_transportation']
        start_time = data['start_time']
        end_time = data['end_time']
        preferences = data["preferences"]
        userId = data["uid"]
        
        if location == "":
            location = "California"
        
        start_date_change = datetime.strptime(start_date, "%Y-%m-%d")
        end_date_change = datetime.strptime(end_date, "%Y-%m-%d")
        
        day_length = (end_date_change - start_date_change).days

        planned_trip = generated_trip.trip_generator(
                location,
                num_of_people,
                start_date,
                end_date,
                budget,
                mode_of_transportation,
                start_time,
                end_time,
                day_length,
                preferences
            )
            
        print(planned_trip)
        
        # when we has the planned trip, let move on
        if (planned_trip):
            stops = planned_trip["results"]
            print(stops)
            
            origins = []
            destinations = []

            for i in range(len(stops) - 1):
                print('this is a stop', stops[i])
                origins.append(stops[i]['location'])
                destinations.append(stops[i + 1]['location'])
                
            # this is the distance and duration 
            calculations = (google_function.calculate_distances_durations(origins, destinations, mode_of_transportation))
            print('calculation result', calculations)
            
            tripDurationinMinute = google_function.calculate_time_difference_minutes(start_date, end_date)
            
            print("length of calculation", len(calculations))
            print("length of stops", len(stops))
            
            # okay now count up
            totalTripDuration = 0
            filterStopList = []
            for i in range(len(stops) - 1):
                print('single calculation', calculations[i])
                stop = stops[i]
                transitTime = (int(calculations[i]['duration'].split(' ')[0]) ) if i < len(stops) - 1 else 0
                print('left', totalTripDuration + int(stop['estimatedDuration'][0])*60 + int(transitTime) )
                print('right', int(tripDurationinMinute))
                if (totalTripDuration + int(stop['estimatedDuration'][0])*60 + int(transitTime) ) > (int(tripDurationinMinute)):
                    break
                else:
                    stop['transitTime'] = transitTime
                    totalTripDuration = totalTripDuration + int(stop['estimatedDuration'][0])*60 + int(transitTime)
                    filterStopList.append(stop)
                    
            # add lat and long to the list
            for stop in filterStopList:
                print(google_function.add_more(stop))

        
        # Finally, create a result
        
        uniqueTripId = str(uuid.uuid4()) 
        resultInJson = {
            "location": location,
            "start-date": start_date,
            "end-date": end_date,
            "big-image": google_function.get_place_photo(location),
            "unique-trip-id": uniqueTripId,
            "data": filterStopList
        }
        
        # write to database
        try:
            database_handle_url = 'https://3fb4v3owk4ut5pe5mj4lbi6upm0ywbbh.lambda-url.us-east-1.on.aws/'
            
            headers = {
                'Content-Type': 'application/json'
            }
            
            write_body = {
                "action": "write-trip",
                "user-id": userId,
                "trip-id": uniqueTripId,
                "trip-data": resultInJson,
                "start-date": start_date,
                "end-date": end_date,
                "big-image": google_function.get_place_photo(location),
                "location": location
            }
            
            response = requests.post(database_handle_url, headers=headers, data=json.dumps(write_body))
            if response.status_code == 200:
                print('Request was successful.')
            else:
                print('Request failed with status code:', response.status_code)
                print('Response content:', response.text)  # Print the response content for debugging
        except Exception as e:
            print(e)
            return {
                'statusCode': 500,
                'body': json.dumps({'error': str(e)})
            }



        
        # Return the JSON response
        return {
            'statusCode': 200,
            'body': json.dumps(resultInJson)
        }
    except Exception as e:
        print(e)
        
        # Handle any exceptions that may occur during the process
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
