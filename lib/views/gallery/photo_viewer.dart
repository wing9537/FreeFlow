import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PhotoViewer extends StatelessWidget {
  const PhotoViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final photo = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(title: const Text("View Photo")),
      body: Center(child: Image.memory(photo as Uint8List)),
    );
  }
}
