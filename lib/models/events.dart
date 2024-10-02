import 'dart:math';

import 'package:ku_ty/models/event.dart';

class Events {
  List<Event> events = [];

  Events() {
    events = getEvents();
  }

  List<Event> getEvents() {
    List<String> categories = [
      "Concert",
      "Festival",
      "Party",
      "Sport",
      "Seminar",
      "Exhibition",
      "Market",
      "Workshop"
    ];

    Random random = Random();

    List<Event> events = List.generate(50, (index) {
      String description = '';
      for (int i = 0; i < ( random.nextInt(40) + 10); i++) {
        description += 'บลา';
      }

      return Event(
        name: 'ร้องเพลงในสวนรถไฟ "มาทำลิสต์เพลง ของพวกเรากันเถอะ" ${index + 1}',
        location:
            'Wachirabenchathat Park (Rot Fai Park) ${random.nextInt(100)}',
        description:
            description,
        startDate: DateTime.now().add(Duration(days: random.nextInt(30))),
        startTime: DateTime.now().add(Duration(hours: random.nextInt(24))),
        attendeeLimit: random.nextInt(100) +
            10, // Random attendee limit between 10 and 100
        willGoAttendees: random.nextInt(50) + 1,
        interestedAttendees: random.nextInt(100),
        attendees: [
          for (int i = 0; i < random.nextInt(100); i++)
            {
              'name': 'Attendee $i',
              'profilePic': 'assets/images/profile_pic.png'
            }
        ],
        images: [],
        categories: List.generate(
            2, (index) => categories[random.nextInt(categories.length)]),
      );
    });

    return events;
  }

  List<Event> getEventsByCategory(List<String> category) {
    if (category.contains('All')) {
      return events;
    }

    return events.where((event) {
      return event.categories.any((element) => category.contains(element));
    }).toList();
  }
}
