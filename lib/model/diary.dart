import 'package:free_flow/common/tool.dart';

class Diary {
  final String id;
  final String title;
  final String content;

  DateTime recordDate = DateTime.now();
  DateTime createDate = DateTime.now();
  DateTime modifyDate = DateTime.now();

  Diary(this.id, this.title, this.content);

  Diary.build(this.id, this.title, this.content, this.recordDate);

  factory Diary.fromJson(Map<String, dynamic> data) {
    Diary diary = Diary(data["id"], data["title"], data["content"]);
    diary.recordDate = Tool.stringToDate(data["recordDate"]);
    diary.createDate = Tool.stringToDate(data["createDate"]);
    diary.modifyDate = Tool.stringToDate(data["modifyDate"]);
    return diary;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "recordDate": Tool.dateToString(recordDate),
        "createDate": Tool.dateToString(createDate),
        "modifyDate": Tool.dateToString(modifyDate),
      };
}
