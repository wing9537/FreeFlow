import 'package:flutter/material.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';

class CreateDiary extends StatefulWidget {
  const CreateDiary({super.key});

  @override
  State<StatefulWidget> createState() => _CreateDiaryState();
}

class _CreateDiaryState extends State<CreateDiary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body: const Text("Create Diary Page"),
    );
  }
}
