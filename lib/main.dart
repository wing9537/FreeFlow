import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:free_flow/common/camera.dart';
import 'package:free_flow/common/sqlite.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';

void main() {
  Camera.provider.connectCamera();
  Sqlite.provider.createDatabase();
  initializeDateFormatting().then((_) => runApp(const App()));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
