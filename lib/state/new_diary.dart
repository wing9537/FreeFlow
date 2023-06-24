import 'package:flutter/foundation.dart';
import 'package:free_flow/model/diary.dart';
import 'package:free_flow/service/diary.dart';
import 'package:uuid/uuid.dart';

class NewDiaryState extends ChangeNotifier {
  String title = "";
  String content = "";
  List<Uint8List> photos = [];

  final DiaryService _diaryService = DiaryService();

  NewDiaryState();

  Future submit() {
    return _diaryService
        .create(Diary(const Uuid().v1(), title, content))
        .then((value) => clear());
  }

  void addPhoto(Uint8List photo) {
    photos.add(photo);
    notifyListeners();
  }

  void clear() {
    title = "";
    content = "";
    photos.clear();
  }
}
