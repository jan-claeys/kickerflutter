import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kickerflutter/models/player.dart';
import 'package:kickerflutter/widgets/dialogs/error_dialog.dart';

import '../models/position.dart';
import '../models/newMatch.dart';
import '../network.dart';
import '../widgets/dropdown_search/dropdown_search.dart';

class NewMatchPage extends StatefulWidget {
  const NewMatchPage({super.key});

  @override
  State<NewMatchPage> createState() => _NewMatchPageState();
}

class _NewMatchPageState extends State<NewMatchPage> {
  final _formKey = GlobalKey<FormState>();
  Position playerPosition = Position.Attacker;
  Player? ally;
  Player? opponentAttacker;
  Player? opponentDefender;
  TextEditingController playerScoreController = TextEditingController();
  TextEditingController opponentScoreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New match'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                          label: Text("Attacker"), value: Position.Attacker),
                      ButtonSegment<Position>(
                          label: Text("Defender"), value: Position.Defender),
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
                    onChanged: (Player? value) => ally = value!,
                    validator: (value) {
                      if (value == null) {
                        throw Exception('Please enter an ally');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  DropdownSearch<Player>(
                    mode: Mode.BOTTOM_SHEET,
                    showSearchBox: true,
                    label: "Opponent attacker",
                    isFilteredOnline: true,
                    onFind: (String? filter) => fetchPlayers(filter ?? ''),
                    onChanged: (Player? value) => opponentAttacker = value!,
                    validator: (value) {
                      if (value == null) {
                        throw Exception('Please enter opponent attacker');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  DropdownSearch<Player>(
                    mode: Mode.BOTTOM_SHEET,
                    showSearchBox: true,
                    label: "Opponent deffender",
                    isFilteredOnline: true,
                    onFind: (String? filter) => fetchPlayers(filter ?? ''),
                    onChanged: (Player? value) => opponentDefender = value!,
                    validator: (value) {
                      if (value == null) {
                        throw Exception('Please enter opponent defender');
                      }
                      return null;
                    },
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
                          controller: playerScoreController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              throw Exception('Please enter a score');
                            }
                            return null;
                          },
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
                          controller: opponentScoreController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              throw Exception('Please enter a score');
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            if (_formKey.currentState!.validate()) {
                              final NewMatch newMatch = NewMatch(
                                playerPosition: playerPosition,
                                ally: ally,
                                opponentAttacker: opponentAttacker,
                                opponentDefender: opponentDefender,
                                playerScore:
                                    int.tryParse(playerScoreController.text),
                                opponentScore:
                                    int.tryParse(opponentScoreController.text),
                              );

                              await createMatch(newMatch);
                              if (!context.mounted) return;
                              Navigator.pop(context);
                            }
                          } on Exception catch (e) {
                            if (!context.mounted) return;
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    ErrorDialog(exeption: e));
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
