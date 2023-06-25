import 'package:flutter/cupertino.dart';
import 'package:free_flow/common/camera.dart';
import 'package:free_flow/common/sqlite.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';

void main() {
  Camera.provider.connectCamera();
  initializeDateFormatting().then((_) => runApp(const App()));
  Sqlite.provider.createDatabase();
}
