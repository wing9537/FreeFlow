import 'package:free_flow/dao/photo.dart';
import 'package:free_flow/model/photo.dart';

class PhotoService {
  static final _photoDao = PhotoDao();

  Future findByMonth(String month) {
    return _photoDao.findByMonth(month);
  }

  Future findById(String refId, {int? limit}) {
    return _photoDao.findById(refId, limit: limit);
  }

  Future create(Photo model) => _photoDao.create(model);

  Future update(Photo model) => _photoDao.update(model);

  Future delete(String id) => _photoDao.delete(id);

  Future getAvailableMonth() => _photoDao.getAvailableMonth();
}
