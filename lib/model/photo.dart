import 'package:flutter/foundation.dart';
import 'package:free_flow/common/tool.dart';

class Photo {
  final String id;
  final String refId;
  final Uint8List content;

  DateTime createDate = DateTime.now();
  DateTime modifyDate = DateTime.now();

  Photo(this.id, this.refId, this.content);

  factory Photo.fromJson(Map<String, dynamic> data) {
    Photo photo = Photo(data["id"], data["refId"], data["content"]);
    photo.createDate = Tool.stringToDate(data["createDate"]);
    photo.modifyDate = Tool.stringToDate(data["modifyDate"]);
    return photo;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "refId": refId,
        "content": content,
        "createDate": Tool.dateToString(createDate),
        "modifyDate": Tool.dateToString(modifyDate),
      };
}
