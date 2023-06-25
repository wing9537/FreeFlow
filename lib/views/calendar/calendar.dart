import 'package:flutter/material.dart';
import 'package:free_flow/model/diary.dart';
import 'package:free_flow/service/photo.dart';
import 'package:free_flow/state/diary_list.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<StatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final PhotoService _photoService = PhotoService();

  @override
  void initState() {
    super.initState();
    context.read<CalendarState>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    final CalendarState state = context.watch();
    return Scaffold(
      appBar: AppBar(title: const Text("Calendar")),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          for (Diary diary in state.list)
            Card(
              child: ListTile(
                leading: FutureBuilder(
                    future: _photoService.findById(diary.id, limit: 1),
                    builder: (context, snapshot) {
                      if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                        return Image.memory(snapshot.data[0].content,
                            width: 60, fit: BoxFit.cover);
                      } else {
                        return const Icon(Icons.photo,
                            size: 60, color: Colors.grey);
                      }
                    }),
                title: Text(diary.title),
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
            ),
        ],
      ),
    );
  }
}
