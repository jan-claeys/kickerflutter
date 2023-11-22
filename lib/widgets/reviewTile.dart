import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/match.dart';

class ReviewTile extends StatelessWidget {
 
  final Match match;
  final Future Function()? onTap;

   const ReviewTile({
    super.key,
    required this.match,
    required this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          "${match.playerTeam.attacker.name} ${match.playerTeam.defender.name} vs ${match.opponentTeam.attacker.name} ${match.opponentTeam.defender.name}"),
      subtitle: Text(DateFormat.yMd().format(match.date)),
      trailing: Text("${match.playerTeam.score} : ${match.opponentTeam.score}"),
      onTap: () => onTap == null ? null : onTap!(),
    );
  }

}
