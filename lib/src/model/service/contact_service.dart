import 'package:contact_list/src/model/dto/contact.dart';
import 'package:contact_list/src/model/mapper/contact_mapper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class ContactService {
  final String _table = 'contact';

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
          "CREATE DATABASE $_table(id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, img TEXT)"
        );
      }
    );
  }

  Future<ContactDTO> save(ContactDTO dto) async {
    Database database = await db;

    dto.id = await database.insert(_table, ContactMapper.toMap(dto));

    return dto;
  }

  Future<ContactDTO> search(int id) async {
    Database database = await db;

    List<Map> maps = await database.query(
      _table,
      columns: ['name', 'id', 'phone', 'email', 'img'],
      where: "id = ?",
      whereArgs: [id]
    );

    if (maps.length > 0) {
      return ContactMapper.toDTO(maps.first);
    } else {
      return null;
    }
  }
}