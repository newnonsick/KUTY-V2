class Event {
  int id;
  String name;
  String description;
  String location;
  DateTime startDateTime;
  DateTime? endDate;
  DateTime? endTime;
  List<Map> attendees;
  List<String> images;
  int attendeeLimit;
  double? cost;
  List<String> categories;
  int willGoAttendees;
  int interestedAttendees;
  double distance;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.startDateTime,
    this.endDate,
    this.endTime,
    required this.attendees,
    required this.images,
    required this.attendeeLimit,
    this.cost,
    required this.categories,
    required this.willGoAttendees,
    required this.interestedAttendees,
    required this.distance,
  });

  void addAttendee(Map attendee) {
    if (attendees.length < attendeeLimit) {
      attendees.add(attendee);
    } else {
      print('ผู้เข้าร่วมเต็มแล้ว');
    }
  }

  void addImage(String imageUrl) {
    images.add(imageUrl);
  }

  int getAttendeeCount() {
    return willGoAttendees + interestedAttendees;
  }

  bool hasCost() {
    return cost != null && cost! > 0;
  }


}
