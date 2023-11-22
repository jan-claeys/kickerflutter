import 'package:flutter/material.dart';
import 'package:kickerflutter/models/match.dart';
import 'package:kickerflutter/network.dart';

class ReviewMatchDialog extends StatelessWidget {
  const ReviewMatchDialog({
    super.key,
    required this.match,
  });

  final Match match;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Review match"),
      content: Text(
          "${match.playerTeam.attacker.name} ${match.playerTeam.defender.name} vs ${match.opponentTeam.attacker.name} ${match.opponentTeam.defender.name}\n"
          "${match.playerTeam.score} : ${match.opponentTeam.score}"),
      actions: [
        TextButton(
          child: const Text("Deny"),
          onPressed: () {
            denyTeam(match.playerTeam.id);
            Navigator.of(context).pop();
          }
        ),
        TextButton(
          child: const Text("Confirm"),
          onPressed: () {
            confirmTeam(match.playerTeam.id);
            Navigator.of(context).pop();
          }
        ),
      ],
    );
  }
}
