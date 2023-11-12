import 'package:flutter/material.dart';

import '../models/Postition.dart';
import '../widgets/rankingList.dart';

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
                children: <RankingList>[
                  RankingList(orderBy: null),
                  RankingList(orderBy: Position.Attacker),
                  RankingList(orderBy: Position.Defender),
                ],
              ),
            ),
          ],
        ));
  }
}
