class Nav {
  static const String home = "/home";
  static const String createDiary = "/diary/create";
  static const String profile = "/profile";

  static get(int index) {
    switch (index) {
      case 0:
        return home;
      case 1:
        return createDiary;
      case 2:
        return profile;
    }
  }
}
