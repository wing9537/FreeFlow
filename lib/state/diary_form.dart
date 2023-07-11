import 'package:flutter/foundation.dart';
import 'package:free_flow/common/constant.dart';
import 'package:free_flow/common/tool.dart';
import 'package:free_flow/model/diary.dart';
import 'package:free_flow/model/photo.dart';
import 'package:free_flow/service/diary.dart';
import 'package:free_flow/service/photo.dart';
import 'package:uuid/uuid.dart';

class DiaryFormState extends ChangeNotifier {
  String title = "";
  String content = "";
  DateTime recordDate = DateTime.now();
  List<Uint8List> photos = [];

  final DiaryService _diaryService = DiaryService();
  final PhotoService _photoService = PhotoService();

  String get diaryDay => Tool.dateToString(recordDate, format: Format.date);

  DiaryFormState();

  void refresh() => notifyListeners();

  Future submit() async {
    final String diaryId = const Uuid().v1();
    final Diary diary = Diary.build(diaryId, title, content, recordDate);
    await _diaryService.create(diary);
    for (Uint8List photo in photos) {
      await _photoService.create(Photo(const Uuid().v1(), diaryId, photo));
    }
    clear();
    return diary;
  }

  void addPhoto(Uint8List photo) {
    photos.add(photo);
    refresh();
  }

  void removePhoto(Uint8List photo) {
    photos.remove(photo);
    refresh();
  }

  void newDiary(DateTime date) {
    clear(); // clear form first
    recordDate = date;
  }

  void clear() {
    title = "";
    content = "";
    recordDate = DateTime.now();
    photos.clear();
  }
}
