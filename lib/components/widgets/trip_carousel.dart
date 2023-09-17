import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gogo/components/models/trip_model.dart';
import 'package:gogo/components/screens/trip_screen.dart';
import 'package:gogo/components/screens/location_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TripCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int _index = 0; 
    if (trips.isEmpty) {
      return Center(
        child: Text(
          "Your next trip awaits you!", 
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          )
        )
      );
    } 
    return Column(
      children: <Widget>[
        // SizedBox(height: 100),
        Container(
          height: height - 150,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: trips.length,
            controller: PageController(viewportFraction: 0.9),
            onPageChanged: (int index) => _index = index,
            itemBuilder: (BuildContext context, int index) {
              Trip trip = trips[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TripScreen(
                          trip: trip
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white24,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          Hero(
                            tag: trip.id,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                  width: 500,
                                  child: AspectRatio(
                                    aspectRatio: 1/1,
                                    child: Image(image: AssetImage(trip.imageURL), fit: BoxFit.fill)
                                )
                              )
                            ),
                          ),
                          Positioned(
                            left: 10.0,
                            bottom: 10.0,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.locationArrow,
                                        size: 24.0,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 7.0),
                                      Text(
                                        '${trip.location}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(children: <Widget>[
                                    SizedBox(width: 4.0),
                                    Icon(
                                      FontAwesomeIcons.calendar,
                                      size: 16.0,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 12.0),
                                    Text(
                                      '${DateFormat('Md').format(trip.fromDate)}-${DateFormat('Md').format(trip.toDate)}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.2,
                                      )
                                    )
                                  ],)
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                    )
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white10,
                  //     // borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  //   child: Padding(
                  //     padding: EdgeInsets.all(10.0),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: <Widget>[
                  //         Text(
                  //           'hello',
                  //           style: TextStyle(
                  //             fontSize: 22.0,
                  //             fontWeight: FontWeight.w600,
                  //             letterSpacing: 1.2,
                  //           ),
                  //         ),
                  //         Text(
                  //           '${DateFormat('mm/dd/yyyy').format(trip.fromDate)}-${DateFormat('mm/dd/yyyy').format(trip.toDate)}',
                  //           style: TextStyle(
                  //             color: Colors.grey,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Spacer(), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LocationPage()),
                          );
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                        child: Icon(
                          Icons.add,
                          size: 35.0,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15.0)
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}