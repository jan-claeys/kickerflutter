import 'package:flutter/material.dart';
import 'package:kickerflutter/pages/new_match_page.dart';

class CreateMatchFloatingActionButton extends StatelessWidget {
  const CreateMatchFloatingActionButton({
    super.key,
    required this.extended,
  });

  final bool extended;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NewMatchPage()));
      },
      label: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            axis: Axis.horizontal,
            child: child,
          ),
        ),
        child: extended
            ? const Row(children: [Icon(Icons.add), Text("New match")])
            : const Icon(Icons.add),
      ),
    );
  }
}
