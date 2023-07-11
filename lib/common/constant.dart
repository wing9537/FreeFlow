class Nav {
  static const String calendar = "/calendar";
  static const String createDiary = "/diary/create";
  static const String takePhoto = "/diary/takePhoto";
  static const String diaryDetail = "/diary/detail";
  static const String searchDiary = "/diary/search";
  static const String gallery = "/gallery";
  static const String viewPhoto = "/gallery/view";
  static const String setting = "/setting";
  static const path = [calendar, createDiary, gallery, searchDiary, setting];
}

class Tbl {
  static const String diary = "diary";
  static const String photo = "photo";
}

class Format {
  static const String dateTime = "yyyy-MM-dd HH:mm:ss";
  static const String date = "dd/MM/yyyy";
  static const String month = "MM/yyyy";
  static const String dbMonth = "yyyy-MM";
}
