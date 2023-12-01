import 'package:flutter/material.dart';

import '../network.dart';
import '../widgets/list_widgets/list_widget.dart';
import '../models/match.dart';
import '../widgets/tiles/review_tile.dart';
import '../widgets/dialogs/review_match_dialog.dart';

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
                tileBuilder: (Match match, int index, Function removeItem) => ReviewTile(
                  match: match,
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => ReviewMatchDialog(match: match),
                  ).then((value) {
                    if(value == true){
                      removeItem(match);
                    }
                  }),
                ),
                loadMoreItems: (int pageNumber) =>
                    fetchToReview(pageNumber: pageNumber),
              ),
              ListWidget<Match>(
                tileBuilder: (Match match, int index, Function removeItem) => ReviewTile(
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
