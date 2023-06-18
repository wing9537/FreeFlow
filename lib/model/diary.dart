import 'package:uuid/uuid.dart';

class Diary {
  final Uuid id;
  final String title;
  final String content;

  DateTime createDate = DateTime.now();
  DateTime modifyDate = DateTime.now();

  Diary(this.id, this.title, this.content);

  factory Diary.fromJson(Map<String, dynamic> data) {
    Diary diary = Diary(data["id"], data["title"], data["content"]);
    diary.createDate = data["createDate"];
    diary.modifyDate = data["modifyDate"];
    return diary;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "createDate": createDate,
        "modifyDate": modifyDate,
      };
}
