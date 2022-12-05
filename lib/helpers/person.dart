import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:easy_scrum/models/person.dart';

class PersonHelper {
  static final PersonHelper _instance = PersonHelper.internal();

  factory PersonHelper() => _instance;

  PersonHelper.internal();

  Database? _db;

  Future<Database?> get db async {
    _db ??= await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String? databasesPath = await getDatabasesPath();

    String path = join(databasesPath, 'app.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          'CREATE TABLE person(id INTEGER PRIMARY KEY AUTOINCREMENT, personId INTEGER NOT NULL)');
    });
  }

  Future<void> savePerson(Person person) async {
    Database? personDb = await db;
    if (personDb != null) {
      Map<String, Object> map = {'personId': '${person.getId()}'};
      await personDb.insert('person', map);
    }
  }

  Future<int> getPerson() async {
    Database? personDb = await db;
    if (personDb != null) {
      List<Map> maps = await personDb.query('person', columns: ['personId']);
      if (maps.isNotEmpty) {
        return maps.first['personId'];
      }
    }
    return -1;
  }

  Future<void> deletePerson(int id) async {
    Database? personDb = await db;
    if (personDb != null) {
      await personDb.delete('person', where: 'personId = ?', whereArgs: [id]);
    }
  }
}
