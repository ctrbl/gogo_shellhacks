class Trip {
  int id; 
  String imageURL; 
  String location; 
  DateTime fromDate;
  DateTime toDate;
  List? preferences;

  Trip({
    required this.id,
    required this.imageURL,
    required this.location,
    required this.fromDate,
    required this.toDate,
    this.preferences, 
  });

  // factory Trip.fromJson(Map<String, dynamic> json) {
  //   return Trip(
  //     id: json['TripId'],
  //     imageURL: json['BigImage'],
  //     location: json['Location'],
  //     fromDate: json['StartDate'],
  //     toDate: json['EndDate'],
  //   );
  // }
}

List<Trip> trips = [
  Trip(
    id: 1,
    imageURL: 'assets/images/paris.png',
    location: 'Paris, France',
    fromDate: DateTime.now(),
    toDate: DateTime.now().add(Duration(days: 3)),
  ),
  Trip(
    id: 2,
    imageURL: 'assets/images/venice.png',
    location: 'Venice, Italy',
    fromDate: DateTime.now().add(Duration(days: 5)),
    toDate: DateTime.now().add(Duration(days: 10)),
  ),
  Trip(
    id: 3,
    imageURL: 'assets/images/la.png',
    location: 'Los Angeles',
    fromDate: DateTime.now().add(Duration(days: 50)),
    toDate: DateTime.now().add(Duration(days: 60)),
  ),
];