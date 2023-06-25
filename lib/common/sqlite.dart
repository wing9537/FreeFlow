import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqlite {
  static final Sqlite provider = Sqlite();

  late Database _database;

  Future<Database> get database async {
    try {
      return _database.isOpen ? _database : await createDatabase();
    } catch (e) {
      return await createDatabase();
    }
  }

  Future<Database> createDatabase() async {
    // avoid errors caused by flutter upgrade
    // importing 'package:flutter/widgets.dart' is required
    WidgetsFlutterBinding.ensureInitialized();
    // open the database and store the reference
    _database = await openDatabase(
      // set the path to the database
      join(await getDatabasesPath(), "free_flow.db"),
      // when the database is first created
      onCreate: (db, version) {
        // run the CREATE TABLE statement on the database
        db.execute(
          "CREATE TABLE diary(id TEXT PRIMARY KEY, title TEXT, content TEXT, recordDate TEXT, createDate TEXT, modifyDate TEXT)",
        );
        db.execute(
          "CREATE TABLE photo(id TEXT PRIMARY KEY, refId TEXT, content BLOB, createDate TEXT, modifyDate TEXT)",
        );
        db.execute(
          "CREATE INDEX idx_photo_refId ON photo(refId)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return _database;
  }
}
