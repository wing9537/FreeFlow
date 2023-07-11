import 'package:free_flow/common/constant.dart';
import 'package:free_flow/common/sqlite.dart';
import 'package:free_flow/model/diary.dart';

class DiaryDao {
  Future<List<Diary>> findByDate(String startDate, String endDate) async {
    final db = await Sqlite.provider.database;
    List<Map<String, dynamic>> result = await db.query(Tbl.diary,
        where: "recordDate BETWEEN ? AND ?", whereArgs: [startDate, endDate]);
    return result.map((item) => Diary.fromJson(item)).toList();
  }

  Future<List<Diary>> find(String text, {int? limit}) async {
    final db = await Sqlite.provider.database;
    List<Map<String, dynamic>> result = await db.query(Tbl.diary,
        where: "title like ? OR content like ?",
        whereArgs: ["%$text%", "%$text%"],
        orderBy: "recordDate desc",
        limit: limit);
    return result.map((item) => Diary.fromJson(item)).toList();
  }

  Future<int> create(Diary model) async {
    final db = await Sqlite.provider.database;
    return db.insert(Tbl.diary, model.toJson());
  }

  Future<int> update(Diary model) async {
    final db = await Sqlite.provider.database;
    return db.update(Tbl.diary, model.toJson(),
        where: "id = ?", whereArgs: [model.id]);
  }

  Future<int> delete(String id) async {
    final db = await Sqlite.provider.database;
    return await db.delete(Tbl.diary, where: 'id = ?', whereArgs: [id]);
  }
}
