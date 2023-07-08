import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:free_flow/common/constant.dart';
import 'package:free_flow/common/tool.dart';
import 'package:free_flow/model/photo.dart';
import 'package:free_flow/service/photo.dart';

class GalleryState extends ChangeNotifier {
  int offset = 0;
  List<DateTime> availableMonths = [];
  LinkedHashMap<String, List<Uint8List>> photoGroups = LinkedHashMap();

  final PhotoService _photoService = PhotoService();

  void refresh() => notifyListeners();

  String getDisplayMonth(int index) {
    return Tool.dateToString(availableMonths[index], format: Format.month);
  }

  List<Uint8List> getPhotoGroup(String month) {
    return photoGroups[month] ?? [];
  }

  Future fetchLastMonth() async {
    availableMonths = await _photoService.getAvailableMonth();
    if (availableMonths.isNotEmpty) await findByMonth(availableMonths.first);
  }

  Future findByMonth(DateTime date) async {
    String month = Tool.dateToString(date, format: Format.dbMonth);
    final List<Photo> photos = await _photoService.findByMonth(month);
    month = Tool.dateToString(date, format: Format.month);
    photoGroups[month] = photos.map((photo) => photo.content).toList();
    refresh();
  }
}
