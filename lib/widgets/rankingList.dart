import 'package:flutter/material.dart';

import '../models/player.dart';
import '../network.dart';
import 'playerTile.dart';

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
        return PlayerTile(player: player, rankingType: widget.rankingType, index: index,);
      },
    );
  }
}

//#region RankingList implementations
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
//#endregion