import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text(
          "This is a placeholder for your profile page.",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
