import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../network.dart';
import '../widgets/create_match_floating_action_button.dart';
import 'history_page.dart';
import 'new_match_page.dart';
import 'review_page.dart';
import 'ranking_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  int toReviewMatchesCount = 0;

  bool extendedFloatingActionButton = true;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse && extendedFloatingActionButton) {
        setState(() {
          extendedFloatingActionButton = false;
        });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward && !extendedFloatingActionButton) {
        setState(() {
          extendedFloatingActionButton = true;
        });
      }
    });

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
      appBar: AppBar(actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.account_circle_outlined),
          onPressed: () {
            //Navigator.pushNamed(context, "/settings");
          },
        ),
      ]),
      body: <Widget>[
        RankingPage(scrollController: scrollController,),
        HistoryPage(scrollController: scrollController,),
        ReviewPage(
          scrollController: scrollController,
        ),
      ][currentPageIndex],
      floatingActionButton: CreateMatchFloatingActionButton(
        extended: extendedFloatingActionButton,
      ),
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
    );
  }
}
