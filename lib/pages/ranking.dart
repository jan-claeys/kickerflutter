import 'package:flutter/material.dart';

import '../players/network.dart';
import '../players/player.dart';

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


// Base class for the ranking pages.
abstract class RankingList extends StatefulWidget {
  const RankingList({super.key});

  String get rankingType;

  @override
  State<RankingList> createState() => _RankingListState();
}

class _RankingListState extends State<RankingList> {
  late Future<List<Player>> futurePlayers;

  @override
  void initState() {
    super.initState();
    futurePlayers = fetchRanking(widget.rankingType);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futurePlayers,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final Player player = snapshot.data![index];
              return ListTile(
                title: Text(player.name),
                subtitle: Text(player.getRanking(widget.rankingType)),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}

// Concrete ranking pages.
class OveralRankingList extends RankingList {
  const OveralRankingList({super.key});

  @override
  String get rankingType => "";
}

class AttackRankingList extends RankingList {
  const AttackRankingList({super.key});

  @override
  String get rankingType => "AttackRating";
}

class DefendRankingList extends RankingList {
  const DefendRankingList({super.key});

  @override
  String get rankingType => "DefendRating";
}