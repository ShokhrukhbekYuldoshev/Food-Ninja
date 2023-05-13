import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ninja/services/firebase_auth.dart';
import 'package:hive/hive.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text("Dark Mode"),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
              ),
            ),
            // log out
            ListTile(
              title: const Text("Log Out"),
              trailing: const Icon(Icons.logout),
              onTap: () {
                FirebaseAuthService(FirebaseAuth.instance).signOut();
                Hive.box('myBox').deleteFromDisk();
              },
            ),
          ],
        ),
      ),
    );
  }
}
