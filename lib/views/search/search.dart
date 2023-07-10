import 'dart:async';

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
  Timer? _timer;

  void onTextChanged(SearchFormState state, String text) {
    if (_timer != null) _timer!.cancel();
    _timer = Timer(const Duration(seconds: 1), () => state.findDiary(text));
  }

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
              onChanged: (value) => onTextChanged(state, value),
              decoration: const InputDecoration(
                hintText: "Please input here",
                prefixIcon: Icon(Icons.search),
                helperText: "",
              ),
            ),
            state.hasRecord ? DiaryList(state.diaries) : const NoContent(),
          ],
        ),
      ),
    );
  }
}
