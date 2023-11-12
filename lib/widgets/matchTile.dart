import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kickerflutter/widgets/leadingCircle.dart';

import '../models/Postition.dart';
import '../models/match.dart';

class MatchTile extends StatelessWidget {
  const MatchTile({
    super.key,
    required this.match,
    required this.opponentTeam,
    required this.playerTeam,
    required this.playerPosition,
  });

  final Match match;
  final Team opponentTeam;
  final Team playerTeam;
  final Position playerPosition;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: LeadingCircle(
          number: playerPosition == Position.Attacker
              ? match.playerTeam.attackerRatingChange
              : match.playerTeam.defenderRatingChange),
      title: Text(
          "${playerTeam.attacker.name} ${playerTeam.defender.name} vs ${opponentTeam.attacker.name} ${opponentTeam.defender.name}"),
      subtitle: Text(DateFormat.yMd().format(match.date)),
      trailing: Text("${playerTeam.score} : ${opponentTeam.score}"),
    );
  }
}
