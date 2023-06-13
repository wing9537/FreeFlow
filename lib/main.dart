import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:free_flow/common/constant.dart';
import 'package:free_flow/views/diary/create_diary.dart';
import 'package:free_flow/views/home/home.dart';
import 'package:free_flow/views/profile/profile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: MaterialApp(
        title: 'Free Flow',
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: "/home",
        routes: <String, WidgetBuilder>{
          Nav.home: (_) => const Home(),
          Nav.createDiary: (_) => const CreateDiary(),
          Nav.profile: (_) => const Profile(),
        },
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}
