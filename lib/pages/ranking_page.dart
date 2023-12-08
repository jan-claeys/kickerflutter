import 'package:flutter/material.dart';

import '../models/position.dart';
import '../widgets/list_widgets/ranking_list.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const SafeArea(
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
                    scrollController: scrollController,
                  ),
                  RankingList(
                    playerPosition: Position.Attacker,
                    scrollController: scrollController,
                  ),
                  RankingList(playerPosition: Position.Defender, 
                  scrollController: scrollController),
                ],
              ),
            ),
          ],
        ));
  }
}
