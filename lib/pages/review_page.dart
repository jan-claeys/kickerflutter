import 'package:flutter/material.dart';

import '../network.dart';
import '../widgets/listWidgets/list_widget.dart';
import '../models/match.dart';
import '../widgets/review_tile.dart';
import '../widgets/review_match_dialog.dart';

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
                tileBuilder: (Match match, int index) => ReviewTile(
                  match: match,
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => ReviewMatchDialog(match: match),
                  ),
                ),
                loadMoreItems: (int pageNumber) =>
                    fetchToReview(pageNumber: pageNumber),
              ),
              ListWidget<Match>(
                tileBuilder: (Match match, int index) => ReviewTile(
                  match: match,
                  onTap: null,
                ),
                loadMoreItems: (int pageNumber) =>
                    fetchUnderReview(pageNumber: pageNumber),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
