import 'package:flutter/foundation.dart';
import 'package:free_flow/model/diary.dart';
import 'package:free_flow/service/diary.dart';

class CalendarState extends ChangeNotifier {
  List<Diary> list = [];

  DateTime? startDate;
  DateTime? endDate;

  final DiaryService _diaryService = DiaryService();

  CalendarState();

  Future fetch() async {
    list = await _diaryService.find();
    notifyListeners();
  }
}
