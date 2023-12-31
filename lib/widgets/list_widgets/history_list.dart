import 'package:flutter/material.dart';
import 'package:kickerflutter/widgets/tiles/history_tile.dart';

import '../../models/position.dart';
import '../../models/match.dart';
import '../../network.dart';
import 'list_widget.dart';

class HistoryList extends StatelessWidget{
  final Position playerPosition;
  final ScrollController scrollController;

  const HistoryList({
    super.key,
    required this.playerPosition,
    required this.scrollController
  });

  @override
  Widget build(BuildContext context) {
    return ListWidget<Match>(
      tileBuilder: (Match match, int index, Function removeItem) => 
        HistoryTile(match: match, playerPosition: playerPosition),
      loadMoreItems: (int pageNumber) => fetchHistory(playerPosition, pageNumber: pageNumber),
      scrollController: scrollController,
    );
  }
}