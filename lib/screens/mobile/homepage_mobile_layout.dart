import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ku_ty/models/event.dart';
import 'package:ku_ty/models/events.dart';
import 'package:ku_ty/widgets/event_item.dart';
import 'package:ku_ty/widgets/filter_category.dart';
// import 'package:ku_ty/services/apiservice.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePageMobileLayout extends StatefulWidget {
  const HomePageMobileLayout({super.key});

  @override
  State<HomePageMobileLayout> createState() => _HomePageMobileLayoutState();
}

class _HomePageMobileLayoutState extends State<HomePageMobileLayout> {
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String searchResult = '';
  List<String> filterasEventCategory = ["All"];
  Events events = Events();
  // final PageController _pageViewController = PageController();
  // final PageController _pageViewController2 = PageController();

  void onSearchComplete(String text) {
    setState(() {
      searchResult = text;
      FocusScope.of(context).unfocus();
      controller.clear();
    });
  }

  void onSelectCategory(List<String> value) {
    setState(() {
      _scrollController.jumpTo(0);
      filterasEventCategory = value;
    });
  }

  // Widget _buildNotSelectedCategory() {
  //   return Column(
  //     children: [
  //       _buildEventGroup(
  //           title: 'กิจกรรมใกล้ฉัน',
  //           controller: _pageViewController,
  //           onPressed: () {}),
  //       const SizedBox(height: 20),
  //       _buildEventGroup(
  //           title: 'กิจกรรมที่คุณอาจสนใจ',
  //           controller: _pageViewController2,
  //           onPressed: () {}),
  //       const SizedBox(height: 20)
  //     ],
  //   );
  // }

  Widget _buildSelectedCategory({required List<String> selectedCategories}) {
    List<Event> filteredEvents = events.getEventsByCategory(selectedCategories);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: filteredEvents.length,
          itemBuilder: (context, index) {
            Event event = filteredEvents[index];
            return Container(
                margin: const EdgeInsets.only(bottom: 20),
              child: EventItem(event: event));
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('KU-TY',
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
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            _buildSeachBox(),
            const SizedBox(height: 15),
            // _buildSelectLocation(),
            // const SizedBox(height: 15),
            _buildFilterCatagory(),
            const SizedBox(height: 15),
            _buildFilterNSort(),
            const SizedBox(height: 20),
            _buildSelectedCategory(selectedCategories: filterasEventCategory),
            // Expanded(
            //   child: SingleChildScrollView(
            //     controller: _scrollController,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         filterasEventCategory.isEmpty
            //             ? _buildNotSelectedCategory()
            //             : _buildSelectedCategory(
            //                 selectedCategories: filterasEventCategory),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF02BC77),
        child: const Icon(Icons.add, color: Color.fromRGBO(203, 241, 227, 1)),
      ),
    );
  }

  Widget _buildSeachBox() {
    return InkWell(
      onTap: () {
        Get.toNamed('/search')!.then((value) {
          if (mounted) {
            setState(() {});
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        height: 35,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[50],
          border: Border.all(
            color: Colors.grey[300]!,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 17,
              color: Color(0xFF02BC77),
            ),
            SizedBox(width: 10),
            Flexible(
              child: FittedBox(
                child: Text(
                  'Search e.g. Events, People, Locations',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectLocation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          const Text('Bangkok'),
          const SizedBox(width: 10),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 20),
              const SizedBox(width: 5),
              Text(DateFormat('dd/MM/yyyy').format(DateTime.now())),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFilterCatagory() {
    return FilterCategory(
      selectedCategories: filterasEventCategory,
      onSelectCategory: onSelectCategory,
    );
  }

  Widget _buildFilterNSort() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              print('Filter');
            },
            child: const Row(
              children: [
                Icon(Icons.filter_alt_outlined, size: 20),
                SizedBox(width: 5),
                Text('Filter'),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              print('Sort');
            },
            child: const Row(
              children: [
                Icon(Icons.sort, size: 20),
                SizedBox(width: 5),
                Text('Sort'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildEventGroup(
  //     {required String title,
  //     required PageController controller,
  //     required VoidCallback? onPressed}) {
  //   return FutureBuilder(
  //       future: ApiService().getData(title == 'กิจกรรมใกล้ฉัน'
  //           ? '/events/nearby'
  //           : '/events/interested'),
  //       builder: (context, data) {
  //         if (data.connectionState == ConnectionState.waiting) {
  //           //Future: change to ==
  //           return Container(
  //             //Future: do the rest
  //             padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(title),
  //                     IconButton(
  //                         icon: const Icon(
  //                           Icons.arrow_forward_ios,
  //                           size: 20,
  //                         ),
  //                         onPressed: onPressed)
  //                   ],
  //                 ),
  //                 const SizedBox(height: 10),
  //                 Container(
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(15),
  //                     color: Colors.grey[200],
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.grey.withOpacity(0.2),
  //                         spreadRadius: 0,
  //                         blurRadius: 3,
  //                         offset: const Offset(0, 3),
  //                       ),
  //                     ],
  //                   ),
  //                   height: 330,
  //                 ),
  //               ],
  //             ),
  //           );
  //         } else {
  //           return Container(
  //             padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(title),
  //                     IconButton(
  //                         icon: const Icon(
  //                           Icons.arrow_forward_ios,
  //                           size: 20,
  //                         ),
  //                         onPressed: onPressed)
  //                   ],
  //                 ),
  //                 const SizedBox(height: 10),
  //                 Stack(
  //                   children: [
  //                     Container(
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(15),
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.grey.withOpacity(0.2),
  //                             spreadRadius: 0,
  //                             blurRadius: 3,
  //                             offset: const Offset(0, 3),
  //                           ),
  //                         ],
  //                       ),
  //                       height: 330,
  //                       child: PageView.builder(
  //                           itemBuilder: (context, index) {
  //                             Event event = events.events[index];
  //                             return EventItem(event: event);
  //                           },
  //                           controller: controller,
  //                           itemCount: events.events.length),
  //                     ),
  //                     Positioned(
  //                         bottom: 10,
  //                         left: 0,
  //                         right: 0,
  //                         child: Center(
  //                           child: SmoothPageIndicator(
  //                             controller: controller,
  //                             count: events.events.length,
  //                             effect: ExpandingDotsEffect(
  //                               dotWidth: 10,
  //                               dotHeight: 10,
  //                               activeDotColor: const Color(0xFF02BC77),
  //                               dotColor: Colors.grey[300]!,
  //                             ),
  //                           ),
  //                         ))
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           );
  //         }
  //       });
  // }
}
