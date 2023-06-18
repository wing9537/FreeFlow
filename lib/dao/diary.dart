import 'package:free_flow/common/constant.dart';
import 'package:free_flow/common/sqlite.dart';
import 'package:free_flow/model/diary.dart';

class DiaryDao {
  Future<List<Diary>> find() async {
    final db = await Sqlite.provider.database;
    List<Map<String, dynamic>> result = await db.query(Tbl.diary);
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
