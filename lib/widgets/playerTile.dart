import 'package:flutter/material.dart';

import 'package:kickerflutter/models/player.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile({
    super.key,
    required this.player,
    required this.rankingType,
    required this.index,
  });

  final Player player;
  final String rankingType;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Text((index + 1).toString()),
          ),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(player.name, style: const TextStyle(fontSize: 20)),
                Text(player.getRanking(rankingType),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold))
              ]),
        ));
  }
}