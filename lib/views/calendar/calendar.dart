import 'package:flutter/material.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<StatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calendar")),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: const Text("Calendar Page"),
    );
  }
}
