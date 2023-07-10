import 'package:free_flow/dao/diary.dart';
import 'package:free_flow/model/diary.dart';

class DiaryService {
  static final _diaryDao = DiaryDao();

  Future findByDate(String startDate, String endDate) {
    return _diaryDao.findByDate(startDate, endDate);
  }

  Future find(String text, {int? limit}) {
    return _diaryDao.find(text, limit: limit);
  }

  Future create(Diary model) => _diaryDao.create(model);

  Future update(Diary model) => _diaryDao.update(model);

  Future delete(String id) => _diaryDao.delete(id);
}
