import 'package:flutter/material.dart';

import 'history_page.dart';
import 'new_match_page.dart';
import 'review_page.dart';
import 'ranking_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) => {
          setState(() {
            currentPageIndex = index;
          })
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.star_border),
              selectedIcon: Icon(Icons.star),
              label: "Ranking"),
          NavigationDestination(
              icon: Icon(Icons.access_time),
              selectedIcon: Icon(Icons.access_time_filled_outlined),
              label: "History"),
          NavigationDestination(
              icon: Icon(Icons.reviews_outlined),
              selectedIcon: Icon(Icons.reviews),
              label: "Review"),
        ],
      ),
      body: <Widget>[
        const RankingPage(),
        const HistoryPage(),
        const ReviewPage(),
      ][currentPageIndex],
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewMatchPage()));
        },
        label: const Text("New match"),
      ),
    );
  }
}
