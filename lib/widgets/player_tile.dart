import 'package:flutter/material.dart';

import 'package:kickerflutter/models/player.dart';

import '../models/position.dart';
import 'leading_circle.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile({
    super.key,
    required this.player,
    required this.rankingType,
    required this.index,
  });

  final Player player;
  final Position? rankingType;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ListTile(
          leading: LeadingCircle(number: index + 1),
          title: Text(player.name),
          trailing: Text(player.getRanking(rankingType), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
        ));
  }
}

