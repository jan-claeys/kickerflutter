import 'package:flutter/material.dart';

import '../models/position.dart';
import '../network.dart';
import '../models/match.dart';
import 'matchTile.dart';

class ToReviewList extends StatefulWidget {
  const ToReviewList({Key? key}) : super(key: key);

  @override
  State<ToReviewList> createState() => _ToReviewListState();
} 

class _ToReviewListState extends State<ToReviewList>{
  final List<Match> _matches = [];
  bool _isLoading = true;
  bool _hasMore = true;
  int pageNumber = 1;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _hasMore = true;
    _loadMoreMatches();
  }

  void _loadMoreMatches() {
    _isLoading = true;

    fetchToReview(pageNumber: pageNumber).then((matches) {
      if (matches.isEmpty) {
        setState(() {
          _hasMore = false;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          pageNumber++;
          _matches.addAll(matches);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
      return ListView.builder(
      itemCount: _hasMore ? _matches.length + 1 : _matches.length,
      itemBuilder: (context, index) {
        if (index >= _matches.length) {
          // Don't trigger if one async loading is already under way
          if (!_isLoading) {
            _loadMoreMatches();
          }
          return const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(),
            ),
          );
        }

        final Match match = _matches[index];
        return MatchTile(
          match: match,
          playerPosition: Position.Attacker,
        );
      },
    );
  }
}