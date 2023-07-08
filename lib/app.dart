import 'package:flutter/material.dart';
import 'package:free_flow/common/constant.dart';
import 'package:free_flow/state/calendar.dart';
import 'package:free_flow/state/gallery.dart';
import 'package:free_flow/state/new_diary.dart';
import 'package:free_flow/views/calendar/calendar.dart';
import 'package:free_flow/views/diary/create_diary.dart';
import 'package:free_flow/views/diary/take_photo.dart';
import 'package:free_flow/views/gallery/gallery.dart';
import 'package:free_flow/views/gallery/photo_viewer.dart';
import 'package:free_flow/views/profile/profile.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewDiaryState()),
        ChangeNotifierProvider(create: (_) => CalendarState()),
        ChangeNotifierProvider(create: (_) => GalleryState()),
      ],
      child: MaterialApp(
        title: "Free Flow",
        theme: ThemeData(
          useMaterial3: true,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        initialRoute: Nav.calendar,
        routes: <String, WidgetBuilder>{
          Nav.calendar: (_) => const Calendar(),
          Nav.createDiary: (_) => const CreateDiary(),
          Nav.profile: (_) => const Profile(),
          Nav.takePhoto: (_) => const TakePhoto(),
          Nav.gallery: (_) => const Gallery(),
          Nav.viewPhoto: (_) => const PhotoViewer(),
        },
      ),
    );
  }
}
