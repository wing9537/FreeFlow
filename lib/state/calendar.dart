import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:free_flow/common/tool.dart';
import 'package:free_flow/model/diary.dart';
import 'package:free_flow/service/diary.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarState extends ChangeNotifier {
  LinkedHashMap<DateTime, List<Diary>> events = LinkedHashMap(
    equals: (date1, date2) => isSameDay(date1, date2),
    hashCode: (key) => key.day * 1000000 + key.month * 10000 + key.year,
  );

  final DiaryService _diaryService = DiaryService();

  CalendarState();

  void refresh() => notifyListeners();

  List<Diary> getEventsByDate(DateTime? date) {
    return events[date] ?? [];
  }

  Future fetch(DateTime date) async {
    final DateTime startDate = DateTime(date.year, date.month, 1);
    final DateTime endDate = startDate.add(const Duration(days: 31));
    List<Diary> diaries = await _diaryService.find(
      Tool.dateToString(startDate, format: "yyyy-MM-01"),
      Tool.dateToString(endDate, format: "yyyy-MM-01"),
    );
    for (Diary diary in diaries) {
      events.putIfAbsent(diary.recordDate, () => []);
      if (events[diary.recordDate]!.every((item) => item.id != diary.id)) {
        events[diary.recordDate]?.add(diary); // prevent duplicate records
      }
    }
    refresh();
  }
}
