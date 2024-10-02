import 'package:intl/intl.dart';

class Event {
  String name;
  String description;
  String location;
  DateTime startDate;
  DateTime? endDate;
  DateTime startTime;
  DateTime? endTime;
  List<Map> attendees;
  List<String> images;
  int attendeeLimit;
  double? cost;
  List<String> categories;
  int willGoAttendees;
  int interestedAttendees;

  Event({
    required this.name,
    required this.description,
    required this.location,
    required this.startDate,
    this.endDate,
    required this.startTime,
    this.endTime,
    required this.attendees,
    required this.images,
    required this.attendeeLimit,
    this.cost,
    required this.categories,
    required this.willGoAttendees,
    required this.interestedAttendees,
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

  String getFormattedDate(DateTime date) {
    DateFormat formatter = DateFormat('EEE, dd MMM yyyy');
    return formatter.format(date);
  }

  String getFormattedTime(DateTime time) {
    DateFormat timeFormatter = DateFormat('hh:mm a');
    return timeFormatter.format(time);
  }
}
