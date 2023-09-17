from flask import Flask, jsonify, request
from gpt import trip_generator
from sqlite3 import connect
import logging

app = Flask(__name__)

@app.route('/api/endpoint', methods=['GET'])
def handle_request():
    return 'Hello from the Python server!'

@app.route('/api/endpoint/events', methods=['POST'])
def get_suggested_events():
    print(request.data)
    user_id = request.data["user_id"]
    location = request.data["location"]
    num_of_people = request.data["num_of_people"]
    start_date = request.data["start_date"]
    end_date = request.data["end_date"]
    budget = request.data["budget"]
    mode_of_transportation = request.data["mode_of_transportation"]
    start_time = request.data["start_time"]
    end_time = request.data["end_time"]
    day_length = request.data["day_length"]
    preferences = request.data["preferences"]
    events = trip_generator(location, num_of_people, start_date, end_date, budget, mode_of_transportation, start_time, end_time, day_length, preferences)
    json_obj = json.dumps(events, indent=2)
    file = open("test.json", "w")
    file.write(json_obj)
    return json_obj     

if __name__ == '__main__':
    app.run()