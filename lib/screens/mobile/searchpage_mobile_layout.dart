import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ku_ty/widgets/custom_searchbox.dart';

class SearchPageMobileLayout extends StatefulWidget {
  const SearchPageMobileLayout({super.key});

  @override
  State<SearchPageMobileLayout> createState() => _SearchPageMobileLayoutState();
}

class _SearchPageMobileLayoutState extends State<SearchPageMobileLayout> {
  TextEditingController controller = TextEditingController();
  String searchResult = '';
  String searchCategory = '';
  int searchState = 0;
  FocusNode searchFocusNode = FocusNode();
  List<List<String>> recentSearch = [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearch();
    searchFocusNode.requestFocus();
  }

  // Load recent searches from SharedPreferences
  Future<void> _loadRecentSearch() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedSearches = prefs.getStringList('recent_searches');
    if (savedSearches != null) {
      setState(() {
        recentSearch = savedSearches
            .map((search) => search.split('|'))
            .where((search) => search.length == 2)
            .toList();
      });
    }
  }

  // Save recent searches to SharedPreferences
  Future<void> _saveRecentSearch() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> formattedSearches =
        recentSearch.map((search) => '${search[0]}|${search[1]}').toList();
    prefs.setStringList('recent_searches', formattedSearches);
  }

  // Update the recent search list and save it
  void _addToRecentSearch(String text, String category) {
    setState(() {
      // Remove the search if it already exists
      recentSearch
          .removeWhere((item) => item[0] == text && item[1] == category);
      // Add the new search at the start
      recentSearch.insert(0, [text, category]);
      // Keep only the last 5 searches
      if (recentSearch.length > 5) {
        recentSearch = recentSearch.sublist(0, 5);
      }
    });
    _saveRecentSearch();
  }

  void _removeFromRecentSearch(String text, String category) {
    setState(() {
      recentSearch
          .removeWhere((item) => item[0] == text && item[1] == category);
    });
    _saveRecentSearch();
  }

  void onEditingComplete(String text) {
    setState(() {
      searchResult = text;
      searchCategory = '';
      searchState = 2;
      FocusScope.of(context).unfocus();
      _addToRecentSearch(text, '');
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
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Searches',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(height: 10),
          recentSearch.isNotEmpty
              ? SizedBox(
                  height: 220,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: recentSearch.length,
                    itemBuilder: (context, index) {
                      return _buildRecentSearchItem(recentSearch[index]);
                    },
                  ),
                )
              : Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'You don\'t have any recent searches',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
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
          searchResult = recentSearch[0];
          searchCategory = recentSearch[1];
          searchState = 2;
          controller.text = recentSearch[0];
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
          _addToRecentSearch(recentSearch[0], recentSearch[1]);
        });
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        color: Colors.white,
        child: Row(
          children: [
            const Icon(Icons.history, size: 20),
            const SizedBox(width: 10),
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
                  if (recentSearch[1].isNotEmpty)
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
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                _removeFromRecentSearch(recentSearch[0], recentSearch[1]);
              },
              child: const Icon(
                Icons.close,
                size: 20,
                color: Colors.grey,
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
          _buildSearchingItem(category: 'Events'),
          _buildSearchingItem(category: 'Locations'),
          _buildSearchingItem(category: 'People'),
        ],
      ),
    );
  }

  Widget _buildSearchingItem({required String category}) {
    return InkWell(
      onTap: () {
        setState(() {
          searchResult = controller.text;
          searchCategory = category;
          searchState = 2;
          _addToRecentSearch(searchResult, category);
        });
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        color: Colors.white,
        child: Row(
          children: [
            const Icon(Icons.search, size: 20),
            const SizedBox(width: 10),
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
                  if (category.isNotEmpty)
                    Text(
                      'in $category',
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
        children: [
          Text('Search Result: $searchResult'),
          Text('Category: ${searchCategory.isEmpty ? 'All' : searchCategory}'),
        ],
      ),
    );
  }
}
