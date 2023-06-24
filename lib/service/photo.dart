import 'package:free_flow/dao/photo.dart';
import 'package:free_flow/model/photo.dart';

class PhotoService {
  static final _photoDao = PhotoDao();

  Future findById(String refId) => _photoDao.findById(refId);

  Future create(Photo model) => _photoDao.create(model);

  Future update(Photo model) => _photoDao.update(model);

  Future delete(String id) => _photoDao.delete(id);
}
