import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ku_ty/widgets/custom_searchbox.dart';

class SearchPageMobileLayout extends StatefulWidget {
  const SearchPageMobileLayout({super.key});

  @override
  State<SearchPageMobileLayout> createState() => _SearchPageMobileLayoutState();
}

class _SearchPageMobileLayoutState extends State<SearchPageMobileLayout> {
  TextEditingController controller = TextEditingController();
  String searchResult = '';
  int searchState =
      0; // 0: recent search, 1: searching, 2: search result with category, 3: search result without category
  FocusNode searchFocusNode = FocusNode();

  void onEditingComplete(String text) {
    setState(() {
      searchResult = text;
      searchState = 2; //future: change to 3
      FocusScope.of(context).unfocus();
    });
  }

  void onChange(String value) {
    setState(() {
      if (value.isEmpty) {
        searchState = 0;
      } else {
        searchState = 1;
      }
      searchResult = value;
    });
  }

  void onTap() {
    setState(() {
      if (searchResult.isEmpty) {
        searchState = 0;
      } else {
        controller.text = searchResult;
        searchState = 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    searchFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                          )),
                      CustomSearchBox(
                        controller: controller,
                        onEditingComplete: onEditingComplete,
                        onChanged: onChange,
                        onTap: onTap,
                        focusNode: searchFocusNode,
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 0.2,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                searchState == 1
                    ? _buildSearching()
                    : searchState == 2
                        ? _buildSearchResult()
                        : _buildRecentSearch()
              ],
            ),
          ),
        ));
  }

  Widget _buildRecentSearch() {
    List<List<String>> recentSearch = [
      ['Search 1 Search 1 Search 1 Search 1 Search 10', 'Events'],
      ['Search 2', 'Locations'],
      ['Search 3', 'Users'],
      ['Search 4', 'Events'],
      ['Search 5', 'Locations'],
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Search',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 220,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: recentSearch.length,
              itemBuilder: (context, index) {
                return _buildRecentSearchItem(recentSearch[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearchItem(List<String> recentSearch) {
    return InkWell(
      onTap: () {
        setState(() {
          print(recentSearch[0]);
          print(recentSearch[1]);

          searchResult = recentSearch[0];
          searchState = 2;
          controller.text = recentSearch[0];
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        });
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        color: Colors.white,
        child: Row(
          children: [
            const Icon(Icons.history, size: 20),
            const SizedBox(width: 5),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      recentSearch[0],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'in ${recentSearch[1]}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearching() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchingItem(categoty: 'Events'),
          _buildSearchingItem(categoty: 'Locations'),
          _buildSearchingItem(categoty: 'Users'),
        ],
      ),
    );
  }

  Widget _buildSearchingItem({required String categoty}) {
    return InkWell(
      onTap: () {
        setState(() {
          print(controller.text);
          print(categoty);

          searchResult = controller.text;
          searchState = 2;
        });
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        color: Colors.white,
        child: Row(
          children: [
            const Icon(Icons.search, size: 20),
            const SizedBox(width: 5),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      searchResult,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'in $categoty',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Transform.flip(
              flipX: true,
              child: const Icon(
                Icons.arrow_outward_rounded,
                size: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResult() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [Text('Search Result: $searchResult')],
      ),
    );
  }
}
