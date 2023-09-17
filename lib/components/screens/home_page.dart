import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gogo/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gogo/components/models/trip_model.dart';
import 'package:gogo/components/models/event_model.dart';
import 'package:gogo/components/common/page_heading.dart';
import 'package:gogo/components/widgets/trip_carousel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = FirebaseAuth.instance.currentUser; 

  // Future<List<Trip>> getRequest() async {
  //   final response = await http.get(Uri.parse('https://3fb4v3owk4ut5pe5mj4lbi6upm0ywbbh.lambda-url.us-east-1.on.aws/'));     
  //   headers: <String, String>{
  //       'action': 'get-all-trip-one-user',
  //       'user-id': '${FirebaseAuth.instance.currentUser!.uid}',
  //     },);

    // var responseData = json.decode(response.body);

  //   List<Trip> trips = []; 
  //   for (var trip in responseData) {
  //     Trip t = Trip(
  //       id: trip['unique-trip-id'],
  //       location: trip['location'],
  //       imageURL: trip['big-image'],
  //       fromDate: trip['start-date'],
  //       toDate: trip['end-date']);
  //     trips.add(t);
  //   }
  //   return trips;
  // }
  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const PageHeading(title: "My Trips"),
                GestureDetector(
                  onTap: () {
                    AuthService().signOut(); 
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 25),
                    child: CircleAvatar(
                      radius: 28,
                      // backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/avatar.png"),
                    ),
                  ),
                ),
              ]
            ),
            TripCarousel()
          ]
        )
      // )
    );
  }
}