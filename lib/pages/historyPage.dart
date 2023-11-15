import 'package:flutter/material.dart';

import '../models/position.dart';
import '../widgets/listWidgets/historyList.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          SafeArea(
            child: TabBar(tabs:<Tab> [
              Tab(text: "Attacker"),
              Tab(text: "Defender"),
            ],)
          ),
          Expanded(
            child: TabBarView(
              children:[
                HistoryList(playerPosition: Position.Attacker),
                HistoryList(playerPosition: Position.Defender),
              ],
            ),
          ),
      ]),
    );
  }
}
