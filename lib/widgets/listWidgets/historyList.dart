import 'package:flutter/material.dart';
import 'package:kickerflutter/widgets/matchTile.dart';

import '../../models/position.dart';
import '../../models/match.dart';
import '../../network.dart';
import 'listWidget.dart';

class HistoryList extends StatelessWidget{
  final Position playerPosition;

  const HistoryList({
    super.key,
    required this.playerPosition
  });

  @override
  Widget build(BuildContext context) {
    return ListWidget<Match>(
      itemBuilder: (Match match, int index) => 
        MatchTile(match: match, playerPosition: playerPosition),
      loadMoreItems: (int pageNumber) => fetchHistory(playerPosition, pageNumber: pageNumber)
    );
  }
}