import 'package:flutter/material.dart';

import '../network.dart';
import '../widgets/listWidgets/listWidget.dart';
import '../models/match.dart';
import '../widgets/reviewTile.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(children: [
        const SafeArea(
          child: TabBar(
            tabs: [
              Tab(text: 'To review'),
              Tab(text: 'Under review'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              ListWidget<Match>(
                tileBuilder: (Match match, int index) => ReviewTile(
                  match: match,
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
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
                    ),
                  ),
                ),
                loadMoreItems: (int pageNumber) =>
                    fetchToReview(pageNumber: pageNumber),
              ),
              ListWidget<Match>(
                tileBuilder: (Match match, int index) => ReviewTile(
                  match: match,
                  onTap: null,
                ),
                loadMoreItems: (int pageNumber) =>
                    fetchUnderReview(pageNumber: pageNumber),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
