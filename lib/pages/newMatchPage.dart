import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kickerflutter/models/player.dart';

import '../network.dart';

class NewMatchPage extends StatefulWidget {
  const NewMatchPage({super.key});

  @override
  State<NewMatchPage> createState() => _NewMatchPageState();
}

enum Position { attacker, defender }

class _NewMatchPageState extends State<NewMatchPage> {
  final _formKey = GlobalKey<FormState>();
  Position playerPosition = Position.attacker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New match'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Your position:"),
                SegmentedButton<Position>(
                  segments: const [
                    ButtonSegment<Position>(
                        label: Text("Attacker"), value: Position.attacker),
                    ButtonSegment<Position>(
                        label: Text("Defender"), value: Position.defender),
                  ],
                  selected: <Position>{playerPosition},
                  onSelectionChanged: (Set<Position> newSelection) {
                    setState(() {
                      playerPosition = newSelection.first;
                    });
                  },
                ),
                const SizedBox(height: 32),
                DropdownSearch<Player>(
                  mode: Mode.BOTTOM_SHEET,
                  showSearchBox: true,
                  label: "Ally",
                  isFilteredOnline: true,
                  onFind: (String? filter) => fetchPlayers(filter ?? ''),
                ),
                const SizedBox(height: 32),
                DropdownSearch<Player>(
                  mode: Mode.BOTTOM_SHEET,
                  showSearchBox: true,
                  label: "Opponent attacker",
                  isFilteredOnline: true,
                  onFind: (String? filter) => fetchPlayers(filter ?? ''),
                ),
                const SizedBox(height: 32),
                DropdownSearch<Player>(
                  mode: Mode.BOTTOM_SHEET,
                  showSearchBox: true,
                  label: "Opponent deffender",
                  isFilteredOnline: true,
                  onFind: (String? filter) => fetchPlayers(filter ?? ''),
                ),
                const SizedBox(height: 32),
                const Text("Score:"),
               
                   Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      const Text(" : ",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      )
                    ],
                  ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
