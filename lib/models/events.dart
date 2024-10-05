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
        id: index,
        name: "ร้องเพลงในสวนรถไฟ \"มาทำลิสต์เพลง ของพวกเรากันเถอะ\" ${index + 1}",
        location:
            'Wachirabenchathat Park (Rot Fai Park) ${random.nextInt(100)}',
        description:
            description,
        startDateTime: DateTime.now().add(Duration(days: random.nextInt(30))),
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
        cost: random.nextInt(5) == 0 ? random.nextInt(1000).toDouble() : null,
        distance: random.nextDouble() * 100 + 1,
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

  List<Event> getEventsByFilterNSort(Map<String, dynamic> filter, Map<String, String> sortBy) {
    // Map<String, dynamic> filters = {
    //   'price': '', // 0, 1-200, 201-500, 501-1000, 1000+
    //   'filterasEventCategory': ["All"],
    // };

    // Map<String, String> sortBy = {
    //   'sortBy': '',
    //   'mode': 'Ascending', // Ascending, Descending
    // };

    List<Event> filteredEvents = [...events];

    if (filter['price'] != '') {
      filteredEvents = filteredEvents.where((event) {
        if (filter['price'] == '0') {
          return !event.hasCost();
        } else if (filter['price'] == '1-200') {
          return event.hasCost() && event.cost! <= 200;
        } else if (filter['price'] == '201-500') {
          return event.hasCost() && event.cost! > 200 && event.cost! <= 500;
        } else if (filter['price'] == '501-1000') {
          return event.hasCost() && event.cost! > 500 && event.cost! <= 1000;
        } else if (filter['price'] == '1000+') {
          return event.hasCost() && event.cost! > 1000;
        }

        return true;
      }).toList();
    }

    if (!filter['filterasEventCategory'].contains('All')) {
      filteredEvents =  filteredEvents.where((event) {
        return event.categories
            .any((element) => filter['filterasEventCategory'].contains(element));
      }).toList();

    }

    if (sortBy['sortBy'] == 'DateTime') {
      filteredEvents.sort((a, b) {
        return a.startDateTime.compareTo(b.startDateTime);
      });


    } else if (sortBy['sortBy']  == 'Attendees') {
      filteredEvents.sort((a, b) => a.getAttendeeCount().compareTo(b.getAttendeeCount()));
    } else if (sortBy['sortBy']  == 'Price') {
      filteredEvents.sort((a, b) {
        if (a.hasCost() && b.hasCost()) {
          return a.cost!.compareTo(b.cost!);
        } else if (a.hasCost()) {
          return -1;
        } else if (b.hasCost()) {
          return 1;
        }

        return 0;
      });
    } else if (sortBy['sortBy']  == 'Distance') {
      filteredEvents.sort((a, b) => a.distance.compareTo(b.distance));
    }  else if (sortBy['sortBy'] == '')
    {
      filteredEvents = filteredEvents;
    }

    if (sortBy['mode'] == 'Descending') {
      filteredEvents = filteredEvents.reversed.toList();
    }

    return filteredEvents;

  }
}
