import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ku_ty/models/event.dart';
import 'package:ku_ty/models/events.dart';
import 'package:ku_ty/widgets/event_item.dart';
import 'package:ku_ty/widgets/filter_category.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePageMobileLayout extends StatefulWidget {
  const HomePageMobileLayout({super.key});

  @override
  State<HomePageMobileLayout> createState() => _HomePageMobileLayoutState();
}

class _HomePageMobileLayoutState extends State<HomePageMobileLayout> {
  final TextEditingController controller = TextEditingController();
  String searchResult = '';
  List<String> filterasEventCategory = [];
  final PageController _pageViewController = PageController();
  final PageController _pageViewController2 = PageController();
  Events events = Events();

  void onSearchComplete(String text) {
    setState(() {
      searchResult = text;
      FocusScope.of(context).unfocus();
      controller.clear();
    });
  }

  void onSelectCategory(List<String> value) {
    setState(() {
      filterasEventCategory = value;
    });
  }

  Widget _buildNotSelectedCategory() {
    return Column(
      children: [
        _buildEventGroup(
            title: 'กิจกรรมใกล้ฉัน',
            controller: _pageViewController,
            onPressed: () {}),
        const SizedBox(height: 20),
        _buildEventGroup(
            title: 'กิจกรรมที่คุณอาจสนใจ',
            controller: _pageViewController2,
            onPressed: () {}),
        const SizedBox(height: 20)
      ],
    );
  }

  Widget _buildSelectedCategory({required List<String> selectedCategories}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          for (Event event in events.getEventsByCategory(selectedCategories))
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: EventItem(event: event)),
        ],
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSeachBox(),
              const SizedBox(height: 15),
              _buildSelectLocation(),
              const SizedBox(height: 15),
              _buildFilterCatagory(),
              const SizedBox(height: 20),
              if (filterasEventCategory.isEmpty) _buildNotSelectedCategory(),
              if (filterasEventCategory.isNotEmpty)
                _buildSelectedCategory(
                    selectedCategories: filterasEventCategory),
            ],
          ),
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
            Text(
              'Search',
              style: TextStyle(color: Colors.grey, fontSize: 14),
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

  Widget _buildEventGroup(
      {required String title,
      required PageController controller,
      required VoidCallback? onPressed}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  onPressed: onPressed)
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                height: 330,
                child: PageView.builder(
                    itemBuilder: (context, index) {
                      Event event = events.events[index];
                      return EventItem(event: event);
                    },
                    controller: controller,
                    itemCount: 10),
              ),
              Positioned(
                  bottom: 10,
                  left: (MediaQuery.of(context).size.width - 230) / 2,
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 10,
                    effect: ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      activeDotColor: const Color(0xFF02BC77),
                      dotColor: Colors.grey[300]!,
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
