import 'package:flutter/material.dart';
import 'package:free_flow/common/constant.dart';
import 'package:free_flow/common/tool.dart';
import 'package:free_flow/model/diary.dart';
import 'package:free_flow/service/photo.dart';

class DiaryList extends StatelessWidget {
  DiaryList(this.diaries, {super.key, this.hasDate = false});

  final List<Diary> diaries;
  final bool hasDate;
  final PhotoService _photoService = PhotoService();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: diaries.length,
        itemBuilder: (context, i) {
          final diaryCard = Card(
            child: ListTile(
              leading: FutureBuilder(
                  future: _photoService.findById(diaries[i].id, limit: 1),
                  builder: (context, snapshot) {
                    if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                      return Image.memory(snapshot.data[0].content,
                          width: 60, fit: BoxFit.cover);
                    } else {
                      return const Icon(Icons.insert_photo_outlined,
                          size: 60, color: Colors.grey);
                    }
                  }),
              title: Text(diaries[i].title),
              subtitle: const SizedBox(),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () => Navigator.pushNamed(context, Nav.diaryDetail,
                  arguments: diaries[i]),
            ),
          );
          final recordDate = Positioned(
            right: 15,
            bottom: 5,
            child: Text(
              Tool.dateToString(
                diaries[i].recordDate,
                format: Format.date,
              ),
              style: const TextStyle(fontSize: 10),
            ),
          );
          return hasDate ? Stack(children: [diaryCard, recordDate]) : diaryCard;
        },
      ),
    );
  }
}
