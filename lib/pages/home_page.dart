import 'package:flutter/material.dart';

import '../network.dart';
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
  int toReviewMatchesCount = 0;

  @override
  void initState() {
    super.initState();
    fetchToReviewCount().then((count) {
      setState(() {
        toReviewMatchesCount = count;
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) => {
          fetchToReviewCount().then((count) {
            setState(() {
              currentPageIndex = index;
              toReviewMatchesCount = count;
            });
          })
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          const NavigationDestination(
              icon: Icon(Icons.star_border),
              selectedIcon: Icon(Icons.star),
              label: "Ranking"),
          const NavigationDestination(
              icon: Icon(Icons.access_time),
              selectedIcon: Icon(Icons.access_time_filled_outlined),
              label: "History"),
          NavigationDestination(
              icon: Badge(
                isLabelVisible: toReviewMatchesCount > 0,
                label: Text(toReviewMatchesCount.toString()),
                child: const Icon(Icons.reviews_outlined),
              ),
              selectedIcon: Badge(
                isLabelVisible: toReviewMatchesCount > 0,
                label: Text(toReviewMatchesCount.toString()),
                child: const Icon(Icons.reviews),
              ),
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
