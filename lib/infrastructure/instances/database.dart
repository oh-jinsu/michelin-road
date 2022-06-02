import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

late final Database database;

Future<void> initializeDatabase() async {
  database = await openDatabase(
    join(await getDatabasesPath(), dotenv.get("SQFLITE_DATABASE_NAME")),
    onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE review(id TEXT PRIMARY KEY, restaurant_name TEXT NOT NULL, latitude REAL NOT NULL, longitude REAL NOT NULL, rating INTEGER NOT NULL, description TEXT NOT NULL, updated_at TEXT NOT NULL, created_at TEXT NOT NULL)",
      );
      await db.execute(
        "CREATE TABLE location(id TEXT PRIMARY KEY, latitude REAL NOT NULL, longitude REAL NOT NULL, created_at TEXT NOT NULL)",
      );
    },
    version: int.parse(dotenv.get("SQFLITE_DATABASE_VERSION")),
  );
}
