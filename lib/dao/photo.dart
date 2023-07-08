import 'package:free_flow/common/constant.dart';
import 'package:free_flow/common/sqlite.dart';
import 'package:free_flow/common/tool.dart';
import 'package:free_flow/model/photo.dart';

class PhotoDao {
  Future<List<Photo>> findByMonth(String month) async {
    final db = await Sqlite.provider.database;
    List<Map<String, dynamic>> result = await db.query(Tbl.photo,
        where: "refId in (select id from ${Tbl.diary} where recordDate like ?)",
        whereArgs: ["$month%"]);
    return result.map((item) => Photo.fromJson(item)).toList();
  }

  Future<List<Photo>> findById(String refId, {int? limit}) async {
    final db = await Sqlite.provider.database;
    List<Map<String, dynamic>> result = await db.query(Tbl.photo,
        where: "refId = ?", whereArgs: [refId], limit: limit);
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

  Future<List<DateTime>> getAvailableMonth() async {
    final db = await Sqlite.provider.database;
    List<Map<String, dynamic>> result = await db.query("${Tbl.diary} d",
        where: "(select count(*) from ${Tbl.photo} where refId = d.id) > 0",
        orderBy: "recordDate desc");
    Iterable<DateTime> dataset = result.map((item) {
      return Tool.stringToDate(item["recordDate"], format: Format.dbMonth);
    });
    return dataset.toSet().toList();
  }
}
