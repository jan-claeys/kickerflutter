import 'package:flutter/material.dart';
import 'package:kickerflutter/widgets/toReviewList.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(children: [
        SafeArea(
          child: TabBar(
            tabs: [
              Tab(text: 'To review'),
              Tab(text: 'Under review'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              ToReviewList(),
              Center(child: Text('Tab 2')),
            ],
          ),
        ),
      ]),
    );
  }
}
