import 'package:flutter/material.dart';
import 'package:ku_ty/models/event.dart';
import 'package:ku_ty/utils/utils.dart';

class EventItem extends StatelessWidget {
  final Event event;
  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(event.id);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[200]!,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                event.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            FittedBox(
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 17,
                    color: Colors.red[500],
                  ),
                  const SizedBox(width: 5),
                  Text(
                    event.locationName,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          event.description,
                          style: const TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 10),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 17),
                            const SizedBox(width: 5),
                            Text(
                              getFormattedDateTime(event.startDateTime),
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      FittedBox(
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(
                                  "assets/images/Evil_Morty_Profile_Icon.png"),
                            ),
                            const SizedBox(width: 5),
                            const CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(
                                  "assets/images/Evil_Morty_Profile_Icon.png"),
                            ),
                            const SizedBox(width: 5),
                            const CircleAvatar(
                              radius: 15,
                              backgroundImage: AssetImage(
                                  "assets/images/Evil_Morty_Profile_Icon.png"),
                            ),
                            const SizedBox(width: 5),
                            if (event.getAttendeeCount() - 3 > 0)
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "${event.getAttendeeCount() - 3}+",
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      FittedBox(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${event.willGoAttendees}/${event.attendeeLimit} Will go . ${event.interestedAttendees} interested",
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200.0,
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        "assets/images/Evil_Morty_Profile_Icon.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            _buildCategorySection(categories: event.categories),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection({required List<String> categories}) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "${getCategoryEmoji(categories[index])} ${categories[index]}",
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 11),
              ),
            ),
          );
        },
      ),
    );
  }
}
