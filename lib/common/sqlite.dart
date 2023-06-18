import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqlite {
  static final Sqlite provider = Sqlite();

  late Database _database;

  Future<Database> get database async {
    if (_database == null) _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    return openDatabase(
      // Set the path to the database.
      join(await getDatabasesPath(), "free_flow.db"),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE diary(id TEXT PRIMARY KEY, title TEXT, content TEXT, createDate TEXT, modifyDate TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }
}
