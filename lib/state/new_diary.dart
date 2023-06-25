import 'package:flutter/foundation.dart';
import 'package:free_flow/model/diary.dart';
import 'package:free_flow/model/photo.dart';
import 'package:free_flow/service/diary.dart';
import 'package:free_flow/service/photo.dart';
import 'package:uuid/uuid.dart';

class NewDiaryState extends ChangeNotifier {
  String title = "";
  String content = "";
  DateTime recordDate = DateTime.now();
  List<Uint8List> photos = [];

  final DiaryService _diaryService = DiaryService();
  final PhotoService _photoService = PhotoService();

  NewDiaryState();

  Future submit() async {
    final String diaryId = const Uuid().v1();
    await _diaryService.create(
      Diary.build(diaryId, title, content, recordDate),
    );
    for (Uint8List photo in photos) {
      await _photoService.create(Photo(const Uuid().v1(), diaryId, photo));
    }
    return clear();
  }

  void addPhoto(Uint8List photo) {
    photos.add(photo);
    notifyListeners();
  }

  void clear() {
    title = "";
    content = "";
    recordDate = DateTime.now();
    photos.clear();
  }
}
