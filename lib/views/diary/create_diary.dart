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
      appBar: AppBar(
        title: const Text("Create Diary"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Column(children: [
            TextField(
              maxLength: 50,
              decoration: InputDecoration(hintText: "Title"),
            ),
            TextField(
              minLines: 5,
              maxLines: 20,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Content",
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
