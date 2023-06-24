import 'package:flutter/cupertino.dart';
import 'package:free_flow/common/camera.dart';
import 'package:free_flow/common/sqlite.dart';

import 'app.dart';

void main() {
  runApp(const App());
  Sqlite.provider.createDatabase();
  Camera.provider.connectCamera();
}
