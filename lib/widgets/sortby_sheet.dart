import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SortBySheet extends StatefulWidget {
  final ScrollController controller;
  final Map<String, String> sortBy;
  // Map<String, String> sortBy = {
  //   'sortBy': '',
  //   'mode': 'Ascending', // Ascending, Descending
  // };
  final ValueChanged<Map<String, String>> onApply;
  const SortBySheet(
      {super.key,
      required this.controller,
      required this.sortBy,
      required this.onApply});

  @override
  State<SortBySheet> createState() => _SortBySheetState();
}

class _SortBySheetState extends State<SortBySheet> {
  String newSelectedSortBy = '';
  String newSelectedMode = '';

  void _onApply() {
    widget.onApply(Map<String, String>.from({
      'sortBy': newSelectedSortBy,
      'mode': newSelectedMode,
    }));

    Get.back();
  }

  @override
  void initState() {
    super.initState();
    newSelectedSortBy = widget.sortBy['sortBy']!;
    newSelectedMode = widget.sortBy['mode']!;
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
        child: Column(children: [
          Container(
            height: 7,
            width: 45,
            decoration: BoxDecoration(
              color: const Color(0xFF02BC77),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 15),
          const Text('Sort By',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      newSelectedMode = newSelectedMode == 'Ascending'
                          ? 'Descending'
                          : 'Ascending';
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        newSelectedMode == 'Ascending'
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        newSelectedMode == 'Ascending'
                            ? 'น้อยไปมาก'
                            : 'มากไปน้อย',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _buildSortByItem(sortBy: 'Attendees'),
            const SizedBox(height: 10),
            _buildSortByItem(sortBy: 'DateTime'),
            const SizedBox(height: 10),
            _buildSortByItem(sortBy: 'Price'),
            const SizedBox(height: 10),
            _buildSortByItem(sortBy: 'Distance'),
          ])),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      newSelectedSortBy = '';
                      newSelectedMode = 'Ascending';
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
        ]));
  }

  Widget _buildSortByItem({required String sortBy}) {
    bool isSelected = newSelectedSortBy == sortBy;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            newSelectedSortBy = sortBy;
          });
        },
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        color:
                            isSelected ? const Color(0xFF02BC77) : Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                  )),
                ),
                const SizedBox(width: 10),
                Text(
                  sortBy,
                  style: TextStyle(
                      color:
                          isSelected ? const Color(0xFF02BC77) : Colors.black,
                      fontSize: 17),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
