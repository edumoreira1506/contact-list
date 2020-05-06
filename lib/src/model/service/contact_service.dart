import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class ContactService {
  final String table = 'contact';

  static final ContactService _instance = ContactService.internal();

  factory ContactService() => _instance;

  ContactService.internal();

  Database _database;

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _createDatabase();

      return _database;
    }
  }

  Future<Database> _createDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'contacts.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int newerVersion) async {
        await db.execute(
          "CREATE DATABASE $table(id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, img TEXT)"
        );
      }
    );
  }
}
