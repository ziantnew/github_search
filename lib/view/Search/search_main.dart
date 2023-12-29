import 'package:flutter/material.dart';
import 'package:search_api/view/Search/custom_search_tabbar.dart';
import 'package:search_api/view/Search/search_list_view.dart';
import 'package:search_api/view/Search/tab_content.dart';

class SearchMain extends StatelessWidget {
  const SearchMain({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Search Github Repository',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff1A1A1A))),
          elevation: 1,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(70.0), // Adjust the height as needed
            child: CustomSearchTabBar(),
          ),
        ),
        body: TabBarView(
          children: [
            TabContent(child: const SearchListView()),
            TabContent(child: const SearchListView()),
          ],
        ),
      ),
    );
  }
}
