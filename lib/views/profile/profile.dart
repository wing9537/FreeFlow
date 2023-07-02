import 'package:flutter/material.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      body: const Text("Profile Page"),
    );
  }
}
