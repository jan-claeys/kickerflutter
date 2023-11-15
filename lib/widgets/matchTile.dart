import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kickerflutter/widgets/leadingCircle.dart';

import '../models/position.dart';
import '../models/match.dart';

class MatchTile extends StatelessWidget {
  const MatchTile({
    super.key,
    required this.match,
    required this.playerPosition,
  });

  final Match match;
  final Position playerPosition;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: LeadingCircle(
          number: playerPosition == Position.Attacker
              ? match.playerTeam.attackerRatingChange
              : match.playerTeam.defenderRatingChange),
      title: Text(
          "${match.playerTeam.attacker.name} ${match.playerTeam.defender.name} vs ${match.opponentTeam.attacker.name} ${match.opponentTeam.defender.name}"),
      subtitle: Text(DateFormat.yMd().format(match.date)),
      trailing: Text("${match.playerTeam.score} : ${match.opponentTeam.score}"),
    );
  }
}
