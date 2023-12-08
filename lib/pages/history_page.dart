import 'package:flutter/material.dart';

import '../models/position.dart';
import '../widgets/list_widgets/history_list.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const SafeArea(
            child: TabBar(tabs:<Tab> [
              Tab(text: "Attacker"),
              Tab(text: "Defender"),
            ],)
          ),
          Expanded(
            child: TabBarView(
              children:[
                HistoryList(playerPosition: Position.Attacker, scrollController: scrollController),
                HistoryList(playerPosition: Position.Defender, scrollController: scrollController),
              ],
            ),
          ),
      ]),
    );
  }
}
