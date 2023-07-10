import 'package:flutter/foundation.dart';
import 'package:free_flow/model/diary.dart';
import 'package:free_flow/service/diary.dart';

class SearchFormState extends ChangeNotifier {
  String text = "";
  List<Diary> diaries = [];
  bool hasRecord = false;

  final DiaryService _diaryService = DiaryService();

  SearchFormState();

  void refresh() => notifyListeners();

  Future findDiary(String text) async {
    if (text.isNotEmpty) {
      diaries = await _diaryService.find(text, limit: 100);
      hasRecord = diaries.isNotEmpty;
    }
    this.text = text;
    hasRecord = text.isNotEmpty && diaries.isNotEmpty;
    refresh();
  }
}
