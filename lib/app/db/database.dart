import 'package:crud_operations/app/core/db_config.dart';
import 'package:crud_operations/app/data/user/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Import your model classes


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), DBConfig.DBName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DBConfig.UserTableName} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        gender INTEGER NOT NULL,
        status INTEGER NOT NULL
      )
    ''');
  }

  // Insert a User
  Future<int> insertUser(User user) async {
    Database db = await instance.database;
    return await db.insert('users', user.toJson());
  }

  // Fetch all Users
  Future<List<User>> fetchAllUsers() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) => User.fromJson(maps[i]));
  }

  // Fetch a User by ID
  Future<User?> fetchUserById(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return User.fromJson(maps[0]);
    } else {
      return null;
    }
  }

  // Update a User
  Future<int> updateUser(User user) async {
    Database db = await instance.database;
    return await db.update('users', user.toJson(), where: 'id = ?', whereArgs: [user.id]);
  }

  // Delete a User
  Future<int> deleteUser(User user) async {
    Database db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [user.id]);
  }

  // Close the database
  Future closeDatabase() async {
    final db = await instance.database;
    return db.close();
  }
}
