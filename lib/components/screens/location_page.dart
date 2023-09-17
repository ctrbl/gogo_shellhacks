import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:gogo/components/models/event_model.dart';
import 'package:gogo/components/models/trip_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gogo/components/common/page_heading.dart';
import 'package:gogo/components/common/custom_input_field.dart';
import 'package:gogo/components/models/autocomplete_prediction.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});
  // Future<EventList>? eventList; 
  // Future<EventList? get _eventList => eventList;

  @override
  State<LocationPage> createState() => _LocationPage();
}

class _LocationPage extends State<LocationPage> {
  // Future<Event>? _futureEvent; 
  final _eventFormKey = GlobalKey<FormState>();

  final locationController = TextEditingController();
  final budgetController = TextEditingController(); 
  final numController = TextEditingController(); 
  List<AutocompletePrediction> placePredictions = [];

  var selectedDates = DateTimeRange(start: DateTime.now(), end: DateTime.now().add(Duration(days: 1)));

  final GlobalKey<OptionChooserState> optionChooserKey = GlobalKey();
  final GlobalKey<TimePickersRowState> timePickersRowKey = GlobalKey();
  final GlobalKey<PreferencesState> preferencesKey = GlobalKey();

  @override
  void dispose() {
    locationController.dispose();
    budgetController.dispose();
    numController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEF1F3),
      body: Form(
          key: _eventFormKey,
          child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                        const PageHeading(title: 'Set up your event',),
                        IconButton(
                          icon: Icon(Icons.add),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () async {
                            // Call post here!!!
                            final url = 'http://127.0.0.1:5000/api/endpoint/events';
                            final response = await http.post(Uri.parse(url), body: jsonEncode(<String, String>{
                                "user_id": "${FirebaseAuth.instance.currentUser!.uid}",
                                "location": "${locationController.text}",
                                "num_of_people":"${numController.text}",
                                "start_date": "${DateFormat('yyyy-MM-dd').format(selectedDates.start)}",
                                "end_date": "${DateFormat('yyyy-MM-dd').format(selectedDates.end)}",
                                "budget": "${budgetController.text}",
                                "mode_of_transportation": "${optionChooserKey.currentState!.getSelectedString()}",
                                "start_time": "${timePickersRowKey.currentState!.getStartTime()}",
                                "end_time": "${timePickersRowKey.currentState!.getEndTime()}",
                                "preferences": "${preferencesKey.currentState!.getSelectedOptionsString()}",
                              }));
                            setState(() {

                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  CustomInputField(
                    onAutoComplete: (predictions) {
                      placePredictions = predictions; 
                    },
                    controller: locationController, 
                    labelText: 'Location',
                    hintText: 'Enter the city or country of your trip',
                    isDense: true,
                    validator: (textValue) {
                      if(textValue == null || textValue.isEmpty) {
                        return 'Location field is required!';
                      }
                      return null;
                    }
                  ),
                  SizedBox(height: 15),
                  MaterialButton(
                    color: Colors.black,
                    onPressed: () async {
                      final DateTimeRange? dateTimeRange = await showDateRangePicker(context: context, firstDate: selectedDates.start, lastDate: DateTime(2100));
                      if (dateTimeRange != null) {
                        setState(() {
                          selectedDates = dateTimeRange; 
                        });
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text('Choose your travel dates', 
                        style: TextStyle(color: Colors.white))
                    )
                  ),
                  Text('Start date: ${DateFormat('MM/dd/yyyy').format(selectedDates.start)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('End date: ${DateFormat('MM/dd/yyyy').format(selectedDates.end)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15),
                  CustomInputField(
                    controller: numController, 
                    labelText: 'Number of people traveling with you',
                    hintText: 'Enter the numer of people on your trip',
                    isDense: true,
                    validator: (textValue) {
                      if(textValue == null || textValue.isEmpty) {
                        return 'Location field is required!';
                      }
                      return null;
                    }
                  ),
                  SizedBox(height: 15),
                  CustomInputField(
                    controller: budgetController, 
                    labelText: 'Your traveling budget',
                    hintText: 'Enter your traveling budget',
                    isDense: true,
                    validator: (textValue) {
                      if(textValue == null || textValue.isEmpty) {
                        return 'Location field is required!';
                      }
                      return null;
                    }
                  ),
                  SizedBox(height: 15),
                  OptionChooser(
                    key: optionChooserKey
                  ),
                  SizedBox(height: 15),
                  TimePickersRow(
                    key: timePickersRowKey,
                  ),
                  SizedBox(height: 15),
                  Text("Select your preferred activities (all that apply):", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 5),
                  Preferences(
                    key: preferencesKey,
                  ),
                ],
              ),
            ))
        );
  }

  // Future<void> _handleCreateTrip() async {
  //   // login user
  //   try {
  //     String startTime = timePickersRowKey.currentState!.getStartTime(); 
  //     String endTime = timePickersRowKey.currentState!.getEndTime();
  //     if (_eventFormKey.currentState!.validate()) {
  //       // POST
  //       createTrip(FirebaseAuth.instance.currentUser!.uid, locationController.text, numController.text, selectedDates.start, selectedDates.end, budgetController.text, optionChooserKey.currentState!.getSelectedString(), timePickersRowKey.currentState!.getStartTime(), endTime, preferencesKey.currentState!.getSelectedOptionsString());
  //       print("SUCCESS");
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please fill out the above information.')),
  //     );
  //   }
  // }

  // Future<void> _savingData() async {
  //   final validation = _eventFormKey.currentState!.validate();

  //   if (!validation) {
  //     return;
  //   }

  //   _eventFormKey.currentState!.save(); 
  // }

//   Future<Event> createTrip(String userID, String location, String numOfPeople, DateTime fromDate, DateTime toDate, String budget, String transportation, String startTime, String endTime, String preferences) async {
//     final response = await http.post(
//       Uri.parse('https://jjoveuu7zlzvtrlawhfqpd33mi0tzbxw.lambda-url.us-east-1.on.aws/'),
//       headers: <String, String>{
//         'Content-Type': 'application/json'
//       },
//       body: jsonEncode(<String, String>{
//         'uid': userID,
//         'location': location,
//         'num_of_people': numOfPeople,
//         'start_date': DateFormat('yyyy-MM-dd').format(fromDate),
//         'end_date': DateFormat('yyyy-MM-dd').format(toDate),
//         'budget': budget,
//         'mode_of_transportation': transportation,
//         'start_time': startTime,
//         'end_time': endTime,
//         'preferences': preferences,
//       }),
//   );
//   print(response.statusCode);
//   if (response.statusCode == 200) {
//     return Event.fromJson(jsonDecode(response.body)); 
//   } else {
//     throw Exception("Failed to create albumn.");
//   }
// }

  // FutureBuilder<Event> buildFutureBuilder() {
  //   return FutureBuilder<Event>(
  //     future: _futureEvent,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return Text(snapshot.data!.parentID);
  //       } else if (snapshot.hasError) {
  //         return Text('${snapshot.error}');
  //       }
  //       return const CircularProgressIndicator();
  //     },
  //   );
  // }
}

class TimePickersRow extends StatefulWidget {
  TimePickersRow({Key? key}) : super(key: key);

  @override
  TimePickersRowState createState() => TimePickersRowState();
}

class TimePickersRowState extends State<TimePickersRow> {
  TimeOfDay selectedTime1 = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context, int pickerNumber) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: pickerNumber == 1 ? selectedTime1 : selectedTime2,
    );

    if (picked != null) {
      setState(() {
        if (pickerNumber == 1) {
          selectedTime1 = picked;
        } else {
          selectedTime2 = picked;
        }
      });
    }
  }

  String getStartTime() {
    return selectedTime1.format(context);
  }

  String getEndTime() {
    return selectedTime2.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _selectTime(context, 1),
              child: Text(
                'Select start time',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Text(
              '${selectedTime1.format(context)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          ElevatedButton(
          onPressed: () => _selectTime(context, 2),
          child: Text(
            'Select end time',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        Text(
          '${selectedTime2.format(context)}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        ],)
      ],
    );
  }
}


class Preferences extends StatefulWidget {
  Preferences({Key? key}) : super(key: key);

  @override
  PreferencesState createState() => PreferencesState();
}

class PreferencesState extends State<Preferences> {
  final List<String> options = [
    'Food & Drinks',
    'Adventure',
    'Attractions',
    'Nature',
    'Cultural & Arts',
    'Shopping',
    'Sports',
    'Religious',
  ];

  List<bool> selectedOptions = List.generate(8, (index) => false);

  void toggleOption(int index) {
    setState(() {
      selectedOptions[index] = !selectedOptions[index];
    });
  }

  String getSelectedOptionsString() {
    List<String> selected = [];
    for (int i = 0; i < options.length; i++) {
      if (selectedOptions[i]) {
        selected.add(options[i]);
      }
    }
    return selected.join(', ');
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OptionCell('Food & Drinks', selectedOptions[0], () => toggleOption(0)),
            OptionCell('Cultural & Arts', selectedOptions[4], () => toggleOption(4)),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OptionCell('Adventure', selectedOptions[1], () => toggleOption(1)),
            OptionCell('Shopping', selectedOptions[5], () => toggleOption(5)),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OptionCell('Attractions', selectedOptions[2], () => toggleOption(2)),
            OptionCell('Sports', selectedOptions[6], () => toggleOption(6)),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OptionCell('Nature', selectedOptions[3], () => toggleOption(3)),
            OptionCell('Religious', selectedOptions[7], () => toggleOption(7)),
          ],
        ),
      ],
    );
  }
}

class OptionCell extends StatelessWidget {
  final String option;
  final bool isSelected;
  final Function() onTap;

  OptionCell(this.option, this.isSelected, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          // border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(5.0),
        width: 200,
        height: 50,
        child: Center(
          child: Text(
            option,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}

class OptionChooser extends StatefulWidget {
  OptionChooser({Key? key}) : super(key: key);

  @override
  OptionChooserState createState() => OptionChooserState();
}

class OptionChooserState extends State<OptionChooser> {
  int selectedOption = -1; // Default value for no selection

  void selectOption(int option) {
    setState(() {
      selectedOption = option;
    });
  }

  List<String> transportations = ["driving", "walking", "bicycling", "transit"];

  String getSelectedString() {
    if (selectedOption != -1) {
      return transportations[selectedOption - 1];
    }
    return '';
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OptionContainer(
          option: 1,
          isSelected: selectedOption == 1,
          onTap: () => selectOption(1),
        ),
        OptionContainer(
          option: 2,
          isSelected: selectedOption == 2,
          onTap: () => selectOption(2),
        ),
        OptionContainer(
          option: 3,
          isSelected: selectedOption == 3,
          onTap: () => selectOption(3),
        ),
        OptionContainer(
          option: 4,
          isSelected: selectedOption == 4,
          onTap: () => selectOption(4),
        ),
      ],
    );
  }
}

class OptionContainer extends StatelessWidget {
  final int option;
  final bool isSelected;
  final Function() onTap;

  OptionContainer({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  List transportations = ["driving", "walking", "bicycling", "transit"];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.only(left: 10, right: 10),
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          // border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            '${transportations[option-1]}',
            style: TextStyle(fontSize: 14, color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}

