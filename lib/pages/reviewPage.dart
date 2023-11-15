import 'package:flutter/material.dart';

import '../models/position.dart';
import '../network.dart';
import '../widgets/listWidgets/listWidget.dart';
import '../models/match.dart';
import '../widgets/matchTile.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(children: [
        const SafeArea(
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
              ListWidget<Match>(
                itemBuilder: (Match match, int index) => MatchTile(
                  match: match,
                  playerPosition: Position.Attacker,
                ),
                loadMoreItems: (int pageNumber) => fetchToReview(pageNumber: pageNumber),
              ),
              const Center(child: Text('Tab 2')),
            ],
          ),
        ),
      ]),
    );
  }
}
