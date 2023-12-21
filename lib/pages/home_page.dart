import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../network.dart';
import '../widgets/create_match_floating_action_button.dart';
import 'history_page.dart';
import 'review_page.dart';
import 'ranking_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  int toReviewMatchesCount = 0;

  bool showFullLayout = true;

  final int thresshold = 75;
  double? startOffset;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      startOffset ??= _getOffset();

      //check if the user is at the top of the list
      if (!showFullLayout && _getOffset() == 0) {
        setState(() {
          showFullLayout = true;
        });
      }

      //check if the user is scrolling up or down by comparing the current offset with the previous offset
      if (startOffset != null &&
          (_getOffset() - startOffset!).abs() > thresshold) {
        if (showFullLayout &&
            _getScrollDirection() ==
                ScrollDirection.reverse) {
          setState(() {
            showFullLayout = false;
          });
        }
        if (!showFullLayout &&
            _getScrollDirection() ==
                ScrollDirection.forward) {
          setState(() {
            showFullLayout = true;
          });
        }

        startOffset = null;
      }
    });

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

  //get the current offset of the scroll controller
  double _getOffset() {
    return scrollController.positions.last.pixels;
  }

  //get the current scroll direction of the scroll controller
  ScrollDirection _getScrollDirection(){
    return scrollController.positions.last.userScrollDirection;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: SafeArea(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: showFullLayout ? 50 : 0,
            child: AppBar(actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.account_circle_outlined),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
              ),
            ]),
          ),
        ),
      ),
      body: <Widget>[
        RankingPage(
          scrollController: scrollController,
        ),
        HistoryPage(
          scrollController: scrollController,
        ),
        ReviewPage(
          scrollController: scrollController,
        ),
      ][currentPageIndex],
      floatingActionButton: CreateMatchFloatingActionButton(
        extended: showFullLayout,
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: showFullLayout ? 75 : 0,
        child: NavigationBar(
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
                  isLabelVisible: showFullLayout && toReviewMatchesCount > 0,
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
      ),
    );
  }
}
