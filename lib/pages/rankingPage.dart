import 'package:flutter/material.dart';

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
                tabs: <Widget>[
                  Tab(text: "Overal"),
                  Tab(text: "Attack"),
                  Tab(text: "Defend"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  OveralRankingList(),
                  AttackRankingList(),
                  DefendRankingList(),
                ],
              ),
            ),
          ],
        ));
  }
}
