import 'package:flutter/material.dart';
import 'package:ku_ty/models/event.dart';
import 'package:ku_ty/models/events.dart';
import 'package:ku_ty/widgets/event_item.dart';

class MyEventsPageMobileLayout extends StatefulWidget {
  const MyEventsPageMobileLayout({super.key});

  @override
  State<MyEventsPageMobileLayout> createState() =>
      _MyEventsPageMobileLayoutState();
}

class _MyEventsPageMobileLayoutState
    extends State<MyEventsPageMobileLayout> {
  final ScrollController _joinedEventScrollController = ScrollController();
  final ScrollController _createEventScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: const Text('KU-TY v.2',
              style: TextStyle(
                  color: Color(0xFF02BC77),
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person_add_alt_1,
                  color: Color(0xFF02BC77)), //Color.fromRGBO(203, 241, 227, 1)
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications, color: Color(0xFF02BC77)),
              color: Colors.black,
            ),
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(
                indicatorColor: Color(0xFF02BC77),
                tabs: [
                  Tab(
                    child: Text(
                      'Joined',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Created',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildJoinedEvents(Events().getEvents().sublist(0, 5)),
                    _buildCreatedEvents([]),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildJoinedEvents(List<Event> events) {
    if (events.isEmpty) {
      return const Center(
        child: Text('No joined events'),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView.builder(
        controller: _joinedEventScrollController,
        itemCount: events.length,
        itemBuilder: (context, index) {
          Event event = events[index];
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: EventItem(event: event));
        },
      ),
    );
  }

  Widget _buildCreatedEvents(List<Event> events) {
    if (events.isEmpty) {
      return const Center(
        child: Text('No created events'),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView.builder(
        controller: _createEventScrollController,
        itemCount: events.length,
        itemBuilder: (context, index) {
          Event event = events[index];
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: EventItem(event: event));
        },
      ),
    );
  }
}
