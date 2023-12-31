import 'package:flutter/material.dart';
import 'package:free_flow/common/constant.dart';
import 'package:free_flow/common/tool.dart';
import 'package:free_flow/model/diary.dart';
import 'package:free_flow/state/calendar.dart';
import 'package:free_flow/state/diary_form.dart';
import 'package:free_flow/views/search/diary_list.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<StatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String get selectedDay => _selectedDay != null
      ? Tool.dateToString(_selectedDay!, format: Format.date)
      : "NA";

  bool _selectedDayPredicate(DateTime day) {
    return isSameDay(_selectedDay, day);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() => _focusedDay = focusedDay);
      setState(() => _selectedDay = selectedDay);
    }
  }

  void _onFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      setState(() => _calendarFormat = format);
    }
  }

  void _onPageChanged(DateTime focusedDay) async {
    _focusedDay = focusedDay;
    await context.read<CalendarState>().findByDate(_focusedDay);
  }

  void _newDiary() {
    context.read<DiaryFormState>().newDiary(_selectedDay!);
    Navigator.popAndPushNamed(context, Nav.createDiary);
  }

  @override
  void initState() {
    super.initState();
    context.read<CalendarState>().findByDate(_focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    CalendarState state = context.watch();
    List<Diary> diaries = state.getEventsByDate(_selectedDay);
    return Scaffold(
      appBar: AppBar(title: const Text("Calendar")),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.now(),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: _selectedDayPredicate,
            eventLoader: state.getEventsByDate,
            onDaySelected: _onDaySelected,
            onFormatChanged: _onFormatChanged,
            onPageChanged: _onPageChanged,
          ),
          ListTile(
            title: Text("Selected Date: $selectedDay"),
            trailing: _selectedDay != null
                ? TextButton.icon(
                    onPressed: _newDiary,
                    label: const Text("Add"),
                    icon: const Icon(Icons.add_circle_outline),
                  )
                : null,
          ),
          DiaryList(diaries),
        ],
      ),
    );
  }
}
