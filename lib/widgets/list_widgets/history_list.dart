import 'package:flutter/material.dart';
import 'package:kickerflutter/widgets/tiles/history_tile.dart';

import '../../models/position.dart';
import '../../models/match.dart';
import '../../network.dart';
import 'list_widget.dart';

class HistoryList extends StatelessWidget{
  final Position playerPosition;

  const HistoryList({
    super.key,
    required this.playerPosition
  });

  @override
  Widget build(BuildContext context) {
    return ListWidget<Match>(
      tileBuilder: (Match match, int index) => 
        HistoryTile(match: match, playerPosition: playerPosition),
      loadMoreItems: (int pageNumber) => fetchHistory(playerPosition, pageNumber: pageNumber)
    );
  }
}