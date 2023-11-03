import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/match.dart';

class MatchTile extends StatelessWidget {
  const MatchTile({
    super.key,
    required this.match,
    required this.isConfirmed,
    required this.opponentTeam,
    required this.playerTeam,
  });

  final Match match;
  final bool isConfirmed;
  final Team opponentTeam;
  final Team playerTeam;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          "${playerTeam.attacker.name} ${playerTeam.defender.name} vs ${opponentTeam.attacker.name} ${opponentTeam.defender.name}"),
      subtitle: Text(DateFormat.yMd().format(match.date)),
      trailing: Text("${playerTeam.score} : ${opponentTeam.score}"),
    );
  }
}
