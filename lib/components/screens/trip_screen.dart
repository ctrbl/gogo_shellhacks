import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; 
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gogo/components/models/trip_model.dart';
import 'package:gogo/components/models/event_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gogo/components/models/emoji_mapping.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TripScreen extends StatefulWidget {
  final Trip trip;

  TripScreen({required this.trip});

  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {  
  int _selectedDate = 0;
  // late Future<List<Event>> futureEvent; 
  
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  final List<Marker> _markers = <Marker>[]; 
  final List<LatLng> _latlng = <LatLng>[
    LatLng(49.007958198079265, 2.5507714972159468), 
    LatLng(48.84183193730695, 2.3555947241935122),
    LatLng(48.860815765311514, 2.33761717513603),
    LatLng(45.434310970136266, 12.338523418541758),
    LatLng(45.431001570970466, 12.331548125702948),
    LatLng(45.497870211050355, 12.415000913245477),
    LatLng(45.443606930533214, 12.325605885211214),
    LatLng(34.0720115, -118.3603699),
    LatLng(34.07803579999999, -118.4740954),
    LatLng(34.1125932, -118.3511659),
    LatLng(34.050872, -118.2490552)
  ];
  final List<String> _categories = [
    'flight', 'restaurant', 'museum'
  ];

  void addCustomIcon(String cat) {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(), 'assets/images/${cat}.png')
      .then(
        (icon) {
          setState(() {
            // markerIcons.add(icon); 
          });
        }
      );
  }
  
  @override
  void initState() {
    super.initState(); 
    // futureEvent = fetchEvents(); 
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)), 'assets/images/${_categories[1]}.png')
    .then((onValue) {
      markerIcon = onValue;
    });
    loadData(); 
  }
  
  loadData() {
    for (int i = 0; i < _latlng.length; i++) {
      _markers.add(
        Marker(markerId: MarkerId(i.toString()),
          icon: markerIcon,
          position: _latlng[i]
        ),
      );
      setState(() {

      });
    }
  }

  Widget getMarker(String cat) {
    return Container(
      width: 40,
      height: 40, 
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            spreadRadius: 4, 
            blurRadius: 6)
        ]
      ),
      child: Image.asset("assets/images/${cat}.png")
    );
  }

  // Load events from database here
  // Future<List<Event>> fetchEvents() async {
  //   final response = await http.get(Uri.parse('https://3fb4v3owk4ut5pe5mj4lbi6upm0ywbbh.lambda-url.us-east-1.on.aws/'),       
  //   headers: <String, String>{
  //       'action': 'get-all-trip-one-user',
  //       'user-id': '${FirebaseAuth.instance.currentUser!.uid}',
  //     },);

  //   if (response.statusCode == 200) {
  //     events = (json.decode(response.body) as Map<String, Map<String, dynamic>>).values.map<Event>((value) => Event.fromJson(value)).toList();  
  //     return events; 
  //   } else {
  //     throw Exception('Failed to load events'); 
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String dateFormat = 'MM/dd/yyyy';
    String dateFormatPicker = 'EEE, MMM d';

    late GoogleMapController mapController;

    final LatLng _center = const LatLng(34.050872, -118.2490552);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
      List<DateTime> days = [];
      for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
        days.add(startDate.add(Duration(days: i)));
      }
      return days;
    }

    List<DateTime> days = getDaysInBetween(widget.trip.fromDate, widget.trip.toDate);

    void _showDialog(Widget child) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      );
    }

    List<Event> getTripEvents(int id, DateTime date) {
      List<Event> tripEvents = [];
      for (int i = 0; i < events.length; i++) {
        if (events[i].parentID == id && DateFormat(dateFormat).format(date) == DateFormat(dateFormat).format(events[i].estStartTime)) {
          tripEvents.add(events[i]);
        }
      }
      return tripEvents;
    }

    List<Event> tripEvents = getTripEvents(widget.trip.id, widget.trip.fromDate);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: width, 
                height: height / 2, 
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                    markers: Set<Marker>.of(_markers),
                    // onTap: (position) {
                    //   customInfoWindowController.hideInfoWindow!(); 
                    // },
                    // onCameraMove: (position) {
                    //   customInfoWindowController.googleMapController = controller; 
                    // },
                  ),
                  // CustomInfoWindow(
                  //   controller: _customInfoWindowController,
                  //   height: 200,
                  //   width: 300, 
                  //   offset: 35, 
                  // )
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.search),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.sortAmountDown),
                          iconSize: 25.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), 
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${widget.trip.location}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ), 
                    Text(
                      'From ${DateFormat('Md').format(widget.trip.fromDate)} to ${DateFormat('Md').format(widget.trip.toDate)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey, 
                        fontWeight: FontWeight.w500
                      )
                    )
                  ]
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  // Display a CupertinoPicker with list of fruits.
                  onPressed: () => _showDialog(
                    CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: 32.0,
                      // This sets the initial item.
                      scrollController: FixedExtentScrollController(
                        initialItem: _selectedDate,
                      ),
                      // This is called when selected item is changed.
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          _selectedDate = selectedItem;
                          tripEvents = getTripEvents(widget.trip.id, days[_selectedDate]);
                        });
                      },
                      children:
                          List<Widget>.generate(days.length, (int index) {
                        return Center(child: Text(DateFormat(dateFormat).format(days[index])));
                      }),
                    ),
                  ),
                  // This displays the selected fruit name.
                  child: Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                    ),
                    child: Row(
                      children: [
                        Text(
                          DateFormat(dateFormatPicker).format(days[_selectedDate]),
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down_outlined, color: Colors.white)
                      ]
                    ),
                  )
                ),
            ],)),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              itemCount: tripEvents.length,
              itemBuilder: (BuildContext context, int index) {
                Event event = tripEvents[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 25.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('HH:mm').format(event.estStartTime), 
                            style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold)
                          ),
                          Text(
                            EmojiMapping.getEmojiForCategory(event.category),
                            style: TextStyle(fontSize: 28.0)
                          )
                        ],),
                        SizedBox(width: 25.0),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                width: width - 150,
                                // padding: EdgeInsets.only(right: 25.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],  
                                  borderRadius: BorderRadius.circular(20.0),
                                ), 
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: Image.network(
                                          event.imageURL,
                                          width: 110.0,
                                          height: 110.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              event.name, 
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              )
                                            ),
                                            SmoothStarRating(
                                              color: Colors.yellow[400],
                                              borderColor: Colors.yellow[400], 
                                              rating: event.rating ?? 0.0,
                                              size: 24.0,
                                              starCount: event.rating != null ? 5 : 0, 
                                              isReadOnly: true
                                            ),
                                            Text(event.description)
                                          ]
                                        ),
                                      ),
                                    )
                                  ]
                                )
                              ),
                            ]
                          )
                        )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}