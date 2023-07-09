import 'package:flutter/material.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<StatefulWidget> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setting")),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
      body: const Text("Setting Page"),
    );
  }
}
