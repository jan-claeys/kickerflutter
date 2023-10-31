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
              OveralRatingPage(),
              AttackRatingPage(),
              DefendRatingPage(),
            ],
          ),
        ));
  }
}


class OveralRatingPage extends StatefulWidget {
  const OveralRatingPage({super.key});

  @override
  State<OveralRatingPage> createState() => _OveralRatingPageState();
}

class _OveralRatingPageState extends State<OveralRatingPage> {
  late Future<List<Player>> futurePlayers;

  @override
  void initState(){
    super.initState();
    futurePlayers = fetchOveralRanking();
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
            subtitle: Text(player.rating.toString()),
          );
        },
      );
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    // By default, show a loading spinner.
    return const CircularProgressIndicator();
  },);
  }
}

class AttackRatingPage extends StatelessWidget {
  const AttackRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Attack"),
    );
  }
}

class DefendRatingPage extends StatelessWidget {
  const DefendRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Defend"),
    );
  }
}