import 'package:flutter/material.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      body: const Text("Search Page"),
    );
  }
}
