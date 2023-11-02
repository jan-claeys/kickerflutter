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

// Base class for the ranking pages.
abstract class RankingList extends StatefulWidget {
  const RankingList({super.key});

  String get rankingType;

  @override
  State<RankingList> createState() => _RankingListState();
}

class _RankingListState extends State<RankingList> {

  final List<Player> _players = [];
  bool _isLoading = true;
  bool _hasMore = true;
  int pageNumber = 1;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _loadMorePlayers();
  }

  void _loadMorePlayers() {
    _isLoading = true;

    fetchRanking(widget.rankingType, pageNumber: pageNumber).then((players) {
      if (players.isEmpty) {
        setState(() {
          _hasMore = false;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          pageNumber++;
          _players.addAll(players);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _hasMore ? _players.length + 1 : _players.length,
      itemBuilder: (context, index) {

        if (index >= _players.length) {
          // Don't trigger if one async loading is already under way
          if (!_isLoading) {
            _loadMorePlayers();
          }

          return const Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(),
            ),
          );
        }

        final Player player = _players[index];
        return Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Text((index + 1).toString()),
              ),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(player.name, style: const TextStyle(fontSize: 20)),
                    Text(player.getRanking(widget.rankingType),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))
                  ]),
            ));
      },
    );
  }
}


