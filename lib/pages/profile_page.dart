import 'package:flutter/material.dart';
import 'package:kickerflutter/network.dart';
import 'package:kickerflutter/pages/login_page.dart';

import '../models/player.dart';
import '../session.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          FutureBuilder<Player?>(
              future: fetchCurrentPlayer(),
              builder:
                  (BuildContext context, AsyncSnapshot<Player?> snapshot) =>
                      snapshot.hasData
                          ? Column(
                              children: [
                                const SizedBox(height: 32),
                                CircleAvatar(
                                  radius: 40,
                                  child: Text(snapshot.data!.name[0],
                                      style: const TextStyle(fontSize: 32)),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  snapshot.data!.name,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Rating: '),
                                    Text(
                                      snapshot.data!.rating.toString(),
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  const Text('Attack : '),
                                  Text(
                                    snapshot.data!.attackRating.toString(),
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ],)
                              ],
                            )
                          : const CircularProgressIndicator()),
          const Expanded(child: SizedBox()),
          ElevatedButton(
            onPressed: () {
              Session().logout();
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text('Logout'),
          ),
          const SizedBox(height: 200),
        ],
      ),
    );
  }
}
