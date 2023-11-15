import 'package:flutter/material.dart';

import '../models/position.dart';
import '../widgets/listWidgets/rankingList.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 3,
        child: Column(
          children: [
            SafeArea(
              child: TabBar(
                tabs: <Tab>[
                  Tab(text: "Overall"),
                  Tab(text: "Attacker"),
                  Tab(text: "Defender"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  RankingList(
                    playerPosition: null,
                  ),
                  RankingList(
                    playerPosition: Position.Attacker,
                  ),
                  RankingList(playerPosition: Position.Defender),
                ],
              ),
            ),
          ],
        ));
  }
}
