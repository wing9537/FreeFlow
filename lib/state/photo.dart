import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:free_flow/common/tool.dart';
import 'package:free_flow/model/photo.dart';
import 'package:free_flow/service/photo.dart';


class PhotoState extends ChangeNotifier {
  int offset = 0;
  LinkedHashMap<String, List<Uint8List>> photoMap = LinkedHashMap();

  final PhotoService _photoService = PhotoService();

  Future getPhoto() async {

    List<Photo> photoList = await _photoService.get50Photos();

    for (Photo photo in photoList) {
        String month = Tool.dateToString(photo.createDate, format: "MM/yyyy");
        photoMap.putIfAbsent(month, () => []);
        photoMap[month]?.add(photo.content);
    }
    notifyListeners();
  }

  Future<void> loadPhotosForMonth(String month) async {
    // 加載該月份的圖片，並將其存儲在 photoMap 中
    List<Uint8List> photos = await _photoService.get50Photos();
    photoMap[month] = photos;

    notifyListeners();
  }
}

