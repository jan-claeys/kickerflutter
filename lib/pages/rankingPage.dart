import 'package:flutter/material.dart';

import '../widgets/rankingList.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(text: "Overal"),
                Tab(text: "Attack"),
                Tab(text: "Defend"),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              OveralRankingList(),
              AttackRankingList(),
              DefendRankingList(),
            ],
          ),
        ));
  }
}






