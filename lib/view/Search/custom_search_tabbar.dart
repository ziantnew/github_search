import 'package:flutter/material.dart';

class CustomSearchTabBar extends StatelessWidget {
  const CustomSearchTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(4), // Add horizontal padding
      decoration: BoxDecoration(
        color: const Color(0xffF1F1F1), // Background color for the tab bar
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      child: Row(
        // Wrap TabBar with a Row
        children: [
          Expanded(
              child: Center(
                child: TabBar(
                  tabs: const [
                    Tab(text: '검색결과'),
                    Tab(text: '저장내역'),
                  ],
                  labelStyle: const TextStyle(
                    fontFamily: "Pretender",
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: "Pretender",
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  indicator: BoxDecoration(
                    color: Colors.white, // Selected tab background color
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  indicatorPadding: EdgeInsets.zero,
                  // Remove the bottom indicator
                  labelColor: const Color(0xff1A1A1A),
                  // Selected tab text color
                  unselectedLabelColor:
                  const Color(0xff9B9996), // Unselected tab text color
                ),
              )),
        ],
      ),
    );
  }
}
