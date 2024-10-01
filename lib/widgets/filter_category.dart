import 'package:flutter/material.dart';

class FilterCategory extends StatefulWidget {
  const FilterCategory(
      {super.key,
      required this.selectedCategories,
      required this.onSelectCategory});
  final List<String> selectedCategories;
  final ValueChanged<List<String>> onSelectCategory;

  @override
  State<FilterCategory> createState() => _FilterCategoryState();
}

class _FilterCategoryState extends State<FilterCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 20),
            filterCategoryItem(category: 'All', emoji: '🌍'),
            const SizedBox(width: 10),
            filterCategoryItem(category: 'Concert', emoji: '🎤'),
            const SizedBox(width: 10),
            filterCategoryItem(category: 'Festival', emoji: '🎉'),
            const SizedBox(width: 10),
            filterCategoryItem(category: 'Party', emoji: '🎈'),
            const SizedBox(width: 10),
            filterCategoryItem(category: 'Sport', emoji: '⚽'),
            const SizedBox(width: 10),
            filterCategoryItem(category: 'Seminar', emoji: '📚'),
            const SizedBox(width: 10),
            filterCategoryItem(category: 'Exhibition', emoji: '🖼️'),
            const SizedBox(width: 10),
            filterCategoryItem(category: 'Market', emoji: '🛍️'),
            const SizedBox(width: 10),
            filterCategoryItem(category: 'Workshop', emoji: '🔧'),
          ],
        ),
      ),
    );
  }

  Widget filterCategoryItem({required String category, required String emoji}) {
    bool isSelected = widget.selectedCategories.contains(category);

    return GestureDetector(
      onTap: () {
        if (isSelected) {
          widget.selectedCategories.remove(category);
        } else {
          widget.selectedCategories.add(category);
        }
        widget.onSelectCategory(widget.selectedCategories);
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
        child: Center(
          child: Text(
            "$emoji $category",
            style: TextStyle(
                color: isSelected
                    ? const Color.fromARGB(255, 0, 160, 101)
                    : Colors.grey,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
