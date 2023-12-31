import 'package:flutter/material.dart';
import 'package:free_flow/state/search_form.dart';
import 'package:free_flow/views/search/diary_list.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';
import 'package:free_flow/widgets/no_content.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final SearchFormState state = context.watch();
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TextFormField(
              initialValue: state.text,
              onChanged: (value) => state.text = value.trim(),
              onEditingComplete: state.findDiary,
              decoration: const InputDecoration(
                hintText: "Please input here",
                prefixIcon: Icon(Icons.search),
                helperText: "",
              ),
            ),
            state.hasRecord
                ? DiaryList(state.diaries, hasDate: true)
                : const NoContent(),
          ],
        ),
      ),
    );
  }
}
