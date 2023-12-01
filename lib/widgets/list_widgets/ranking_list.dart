import 'package:flutter/material.dart';

import '../../models/player.dart';
import '../../models/position.dart';
import '../../network.dart';
import 'list_widget.dart';
import '../tiles/player_tile.dart';

class RankingList extends StatelessWidget {
  final Position? playerPosition;

  const RankingList({
    super.key,
    required this.playerPosition,
  });

  @override
  Widget build(BuildContext context) {
    return ListWidget<Player>(
      tileBuilder: (Player player, int index, Function reloadList) =>
          PlayerTile(player: player, index: index, rankingType: playerPosition),
      loadMoreItems: (int pageNumber) => fetchRanking(playerPosition, pageNumber: pageNumber),
    );
  }
}
