import 'package:flutter/material.dart';

import 'historyPage.dart';
import 'rankingPage.dart';

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
              label: "Geschiedenis"),
        ],
      ),
      body: <Widget>[
        const RankingPage(),
        const HistoryPage(),
      ][currentPageIndex],
      floatingActionButton: FloatingActionButton( child: const Icon(Icons.add), onPressed: () {  },),
    );
  }
}
