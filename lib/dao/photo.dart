import 'package:free_flow/common/constant.dart';
import 'package:free_flow/common/sqlite.dart';
import 'package:free_flow/model/photo.dart';

class PhotoDao {
  Future<List<Photo>> findById(String refId) async {
    final db = await Sqlite.provider.database;
    List<Map<String, dynamic>> result =
        await db.query(Tbl.photo, where: "refId = ?", whereArgs: [refId]);
    return result.map((item) => Photo.fromJson(item)).toList();
  }

  Future<int> create(Photo model) async {
    final db = await Sqlite.provider.database;
    return db.insert(Tbl.photo, model.toJson());
  }

  Future<int> update(Photo model) async {
    final db = await Sqlite.provider.database;
    return db.update(Tbl.photo, model.toJson(),
        where: "id = ?", whereArgs: [model.id]);
  }

  Future<int> delete(String id) async {
    final db = await Sqlite.provider.database;
    return await db.delete(Tbl.photo, where: 'id = ?', whereArgs: [id]);
  }
}
