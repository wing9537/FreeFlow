import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_flow/common/constant.dart';
import 'package:free_flow/state/new_diary.dart';
import 'package:provider/provider.dart';

class PhotoList extends StatefulWidget {
  const PhotoList({super.key});

  final double size = 90;

  @override
  State<StatefulWidget> createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  @override
  Widget build(BuildContext context) {
    final NewDiaryState form = context.read();
    return Wrap(
      children: [
        Ink(
          height: widget.size,
          width: widget.size,
          decoration: const ShapeDecoration(
            color: Colors.grey,
            shape: ContinuousRectangleBorder(),
          ),
          child: IconButton(
            iconSize: 72,
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () => Navigator.pushNamed(context, Nav.takePhoto),
          ),
        ),
        for (Uint8List photo in form.photos)
          Image.memory(photo,
              width: widget.size, height: widget.size, fit: BoxFit.cover),
      ],
    );
  }
}
