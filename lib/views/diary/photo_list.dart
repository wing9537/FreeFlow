import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_flow/common/constant.dart';
import 'package:free_flow/state/new_diary.dart';
import 'package:provider/provider.dart';

class PhotoList extends StatelessWidget {
  const PhotoList({super.key});

  final double size = 90;

  @override
  Widget build(BuildContext context) {
    final NewDiaryState state = context.watch();
    return Wrap(
      children: [
        Ink(
          height: size,
          width: size,
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
        for (Uint8List photo in state.photos)
          Stack(
            children: [
              Image.memory(photo, width: size, height: size, fit: BoxFit.cover),
              Positioned(
                right: -15,
                bottom: -15,
                child: IconButton(
                  icon: const Icon(Icons.delete, size: 15),
                  color: Colors.red,
                  onPressed: () => state.removePhoto(photo),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
