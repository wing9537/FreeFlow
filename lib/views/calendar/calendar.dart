import 'package:flutter/material.dart';
import 'package:free_flow/common/constant.dart';
import 'package:free_flow/common/tool.dart';
import 'package:free_flow/model/diary.dart';
import 'package:free_flow/service/photo.dart';
import 'package:free_flow/state/calendar.dart';
import 'package:free_flow/state/new_diary.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<StatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final PhotoService _photoService = PhotoService();

  final ValueNotifier<List<Diary>> _selectedEvents = ValueNotifier([]);
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Diary> _getEventsForDay(DateTime? day) {
    return context.read<CalendarState>().events[day] ?? [];
  }

  bool _selectedDayPredicate(DateTime day) {
    return isSameDay(_selectedDay, day);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() => _focusedDay = focusedDay);
      setState(() => _selectedDay = selectedDay);
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      setState(() => _calendarFormat = format);
    }
  }

  void _onPageChanged(DateTime focusedDay) async {
    _focusedDay = focusedDay;
    await context.read<CalendarState>().fetch(_focusedDay);
    _selectedEvents.value = _getEventsForDay(_selectedDay);
  }

  void _newDiary() {
    context.read<NewDiaryState>().recordDate = _selectedDay!;
    Navigator.popAndPushNamed(context, Nav.createDiary);
  }

  @override
  void initState() {
    super.initState();
    context.read<CalendarState>().fetch(_focusedDay);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            eventLoader: _getEventsForDay,
            onDaySelected: _onDaySelected,
            onFormatChanged: _onFormatChanged,
            onPageChanged: _onPageChanged,
          ),
          ListTile(
            title: Text(
              "Selected Date: ${_selectedDay != null ? Tool.dateToString(_selectedDay!, format: "yyyy-MM-dd") : "NA"}",
            ),
            trailing: _selectedDay != null
                ? TextButton.icon(
                    onPressed: _newDiary,
                    label: const Text("Add"),
                    icon: const Icon(Icons.add_circle_outline),
                  )
                : null,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _selectedEvents,
              builder: (context, diary, child) => ListView.builder(
                itemCount: diary.length,
                itemBuilder: (context, i) => Card(
                  child: ListTile(
                    leading: FutureBuilder(
                        future: _photoService.findById(diary[i].id, limit: 1),
                        builder: (context, snapshot) {
                          if (snapshot.data != null &&
                              snapshot.data!.isNotEmpty) {
                            return Image.memory(snapshot.data[0].content,
                                width: 60, fit: BoxFit.cover);
                          } else {
                            return const Icon(Icons.photo,
                                size: 60, color: Colors.grey);
                          }
                        }),
                    title: Text(diary[i].title),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
