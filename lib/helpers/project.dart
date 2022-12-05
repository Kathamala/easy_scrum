import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:easy_scrum/models/project.dart';

class ProjectHelper {
  static final ProjectHelper _instance = ProjectHelper.internal();

  factory ProjectHelper() => _instance;

  ProjectHelper.internal();

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
          'CREATE TABLE project(id INTEGER PRIMARY KEY AUTOINCREMENT, personId INTEGER NOT NULL)');
    });
  }

  Future<void> saveProject(Project project) async {
    Database? projectDb = await db;
    if (projectDb != null) {
      Map<String, Object> map = {'projectId': '${project.getId()}'};
      await projectDb.insert('project', map);
    }
  }

  Future<int> getProject() async {
    Database? projectDb = await db;
    if (projectDb != null) {
      List<Map> maps = await projectDb.query('project', columns: ['projectId']);
      if (maps.length == 1) {
        return maps.first['projectId'];
      }
    }
    return -1;
  }

  Future<void> deleteProject(int id) async {
    Database? projectDb = await db;
    if (projectDb != null) {
      await projectDb
          .delete('project', where: 'projectId = ?', whereArgs: [id]);
    }
  }
}
