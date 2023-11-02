import 'package:flutter/material.dart';

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
              Tab(text: "Confirmed"),
              Tab(text: "Not confirmed"),
            ],)
          )
      ]),
    );
  }
}
