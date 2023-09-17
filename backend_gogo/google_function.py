import requests
from datetime import datetime
import uuid     

google_api = "AIzaSyDQAaDi2Dtvm_qTHVetcZY4LX1UMIeE2yw"

def geocode_address(address):
    url = f"https://maps.googleapis.com/maps/api/geocode/json?address={address}&key={google_api}"

    try:
        response = requests.get(url)
        data = response.json()

        if data['status'] == 'OK' and data['results']:
            location = data['results'][0]['geometry']['location']
            return {
                "latitude": location['lat'],
                "longitude": location['lng']
            }
        else:
            print(f"Geocoding failed for address: {address}")
            return None
    except Exception as e:
        print(f"Error: {str(e)}")
        return None

def calculate_distance_and_duration(origin, destination, mode="driving"):
    origin_lat_lng = geocode_address(origin)
    destination_lat_lng = geocode_address(destination)

    if not origin_lat_lng or not destination_lat_lng:
        return None

    url = f"https://maps.googleapis.com/maps/api/distancematrix/json?origins={origin_lat_lng['latitude']},{origin_lat_lng['longitude']}&destinations={destination_lat_lng['latitude']},{destination_lat_lng['longitude']}&mode={mode}&key={google_api}"

    try:
        response = requests.get(url)
        data = response.json()

        if data['status'] == 'OK' and data['rows']:
            distance = data['rows'][0]['elements'][0]['distance']['text']
            duration = data['rows'][0]['elements'][0]['duration']['text']
            return {
                "distance": distance,
                "duration": duration
            }
        else:
            print("Error fetching distance and duration.")
            return None
    except Exception as e:
        print(f"Error: {str(e)}")
        return None

def get_place_photo(location):
    fields = ",".join(['geometry', 'photos'])
    url = f"https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields={fields}&input={location}&inputtype=textquery&key={google_api}"

    try:
        response = requests.get(url)
        data = response.json()

        if data['status'] == 'OK':
            photo_ref = data['candidates'][0]['photos'][0]['photo_reference']
            photo_url = f"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference={photo_ref}&key={google_api}"
            photo_response = requests.get(photo_url)
            return photo_response.url
        else:
            print("Could not find place.")
            return None
    except Exception as e:
        print(f"Error: {str(e)}")
        return None

# calculate distance and duration for all of them
def calculate_distances_durations(origins, destinations, mode):
    results = []

    for i in range(len(origins)):
        origin = origins[i]
        destination = destinations[i]

        result = calculate_distance_and_duration(origin, destination, mode)
        if result:
            print(f"Distance from {origin} to {destination}: {result['distance']}")
            print(f"Duration from {origin} to {destination}: {result['duration']}")

            results.append({
                'origin': origin,
                'destination': destination,
                'distance': result['distance'],
                'duration': result['duration'],
            })

    return results

# calculate time difference in minutes
def calculate_time_difference_minutes(start_date, end_date):
    date_format = "%Y-%m-%d"  # Assuming a format like "YYYY-MM-DD"

    date1 = datetime.strptime(start_date, date_format)
    date2 = datetime.strptime(end_date, date_format)

    time_difference_minutes = abs((date2 - date1).total_seconds() / (60))
    return time_difference_minutes
    
def add_more(stop):
    stop_location = stop['location']
    keyword = stop['name']
    
    base_url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?'
    
    request_url = base_url + f'input={stop_location}+{keyword}&inputtype=textquery&fields=photos,formatted_address,name,rating,opening_hours,price_level,geometry&key={google_api}'
    
    # get method of requests module
    search_response = requests.get(request_url)
    
    print('search response', search_response)
    
    try:
        search_data = search_response.json()
        status = search_data.get('status')
        if search_response.status_code == 200 and status == 'OK':
            if 'candidates' in search_data and search_data['candidates']:
                search_data = search_data['candidates'][0]
                print(search_data)
                # get the latitude and longitude
                stop['latitude'] = search_data['geometry']['location']['lat']
                stop['longitude'] = search_data['geometry']['location']['lng']
                
                # Handle 'rating' field gracefully
                stop['rating'] = search_data.get('rating', 'N/A')
                stop['price_level'] = search_data.get('price_level', 'N/A')
                
                # stop id
                stop['stop_id'] = str(uuid.uuid4()) 
                
                if search_data.get("photos",0) != 0:
                
                    photourl = f'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference={search_data["photos"][0]["photo_reference"]}&key={google_api}'
                
                    # send request
                    photo_response = requests.get(photourl)
                
                    if photo_response.status_code == 200:
                        print(photourl)
                        stop['photo_url'] = photourl
                        
                else:
                    stop['photo_url'] = "https://placehold.co/400"
    except Exception as e:
        print("Error:", e)