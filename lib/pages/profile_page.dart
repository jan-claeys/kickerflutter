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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<Player?>(
                future: fetchCurrentPlayer(),
                builder:
                    (BuildContext context, AsyncSnapshot<Player?> snapshot) =>
                        snapshot.hasData
                            ? Text(
                                snapshot.data!.name,
                                style: const TextStyle(fontSize: 24),
                              )
                            : const CircularProgressIndicator()),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Session().logout();
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}