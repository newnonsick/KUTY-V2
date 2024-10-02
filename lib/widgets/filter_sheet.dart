import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterSheet extends StatefulWidget {
  final ScrollController controller;
  final Map<String, dynamic> filters;
  final ValueChanged<Map<String, dynamic>> onApply;

  const FilterSheet(
      {super.key,
      required this.controller,
      required this.filters,
      required this.onApply});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  List<String> newSelectedCategories = [];
  String newSelectedPrice = '';

  @override
  void initState() {
    super.initState();
    newSelectedCategories = widget.filters['filterasEventCategory'];
    newSelectedPrice = widget.filters['price'];
  }

  void _onApply() {
    widget.onApply({
      'filterasEventCategory': newSelectedCategories,
      'price': newSelectedPrice
    });
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Column(
        children: [
          Container(
            height: 7,
            width: 45,
            decoration: BoxDecoration(
              color: const Color(0xFF02BC77),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 15),
          const Text('Filter',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 15),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView(controller: widget.controller, children: [
              const Text('Price',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF02BC77),
                  )),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    filterPriceItem(price: 'Free'),
                    const SizedBox(
                      width: 5,
                    ),
                    filterPriceItem(price: '1-200'),
                    const SizedBox(
                      width: 5,
                    ),
                    filterPriceItem(price: '201-500'),
                    const SizedBox(
                      width: 5,
                    ),
                    filterPriceItem(price: '501-1000'),
                    const SizedBox(
                      width: 5,
                    ),
                    filterPriceItem(price: '1000+'),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Text('Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF02BC77),
                  )),
              const SizedBox(height: 10),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  filterCategoryItem(category: 'All', emoji: '🌍'),
                  filterCategoryItem(category: 'Concert', emoji: '🎤'),
                  filterCategoryItem(category: 'Festival', emoji: '🎉'),
                  filterCategoryItem(category: 'Party', emoji: '🎈'),
                  filterCategoryItem(category: 'Sport', emoji: '⚽'),
                  filterCategoryItem(category: 'Seminar', emoji: '📚'),
                  filterCategoryItem(category: 'Exhibition', emoji: '🖼️'),
                  filterCategoryItem(category: 'Market', emoji: '🛍️'),
                  filterCategoryItem(category: 'Workshop', emoji: '🔧'),
                ],
              )
            ]),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      newSelectedCategories = ['All'];
                      newSelectedPrice = '';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Reset"),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _onApply(),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Apply"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget filterPriceItem({required String price}) {
    bool isSelected = newSelectedPrice == price;
    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            newSelectedPrice = '';
          } else {
            newSelectedPrice = price;
          }
        });
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color:
              isSelected ? const Color.fromARGB(49, 0, 212, 135) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF02BC77) : Colors.grey[500]!,
          ),
        ),
        child: Text(
          price,
          style: TextStyle(
              color: isSelected
                  ? const Color.fromARGB(255, 0, 160, 101)
                  : Colors.grey,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget filterCategoryItem({
    required String category,
    required String emoji,
  }) {
    bool isSelected = newSelectedCategories.contains(category);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            if (category != 'All') {
              newSelectedCategories.remove(category);
            }
            if (newSelectedCategories.isEmpty) {
              newSelectedCategories.add('All');
            }
          } else {
            if (newSelectedCategories.contains('All')) {
              newSelectedCategories.remove('All');
            }
            if (category == 'All') {
              newSelectedCategories.clear();
            }
            newSelectedCategories.add(category);
          }
        });
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color:
              isSelected ? const Color.fromARGB(49, 0, 212, 135) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF02BC77) : Colors.grey[500]!,
          ),
        ),
        child: Text(
          "$emoji $category",
          style: TextStyle(
              color: isSelected
                  ? const Color.fromARGB(255, 0, 160, 101)
                  : Colors.grey,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
