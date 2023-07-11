import 'package:flutter/material.dart';
import 'package:free_flow/common/constant.dart';
import 'package:free_flow/common/tool.dart';
import 'package:free_flow/model/diary.dart';
import 'package:free_flow/model/photo.dart';
import 'package:free_flow/service/photo.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';
import 'package:free_flow/widgets/photo_slider.dart';

class DiaryDetail extends StatefulWidget {
  const DiaryDetail({super.key});

  @override
  State<StatefulWidget> createState() => _DiaryDetailState();
}

class _DiaryDetailState extends State<DiaryDetail> {
  final PhotoService _photoService = PhotoService();
  late List<Photo> _photos = [];
  late Diary _diary;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _diary = ModalRoute.of(context)!.settings.arguments as Diary;
    _photoService.findById(_diary.id).then((data) {
      setState(() => _photos = data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_diary.title)),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body: Column(
        children: [
          if (_photos.isNotEmpty) PhotoSlider(_photos),
          SizedBox(width: MediaQuery.of(context).size.width, height: 10),
          Text(Tool.dateToString(_diary.recordDate, format: Format.date)),
          Text(_diary.content)
        ],
      ),
    );
  }
}
