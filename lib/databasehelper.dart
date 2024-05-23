import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'tintas.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)',
    );
  }

  Future<bool> registerUser(String name, String email, String password) async {
    final db = await database;
    try {
      await db!.insert(
        'User',
        {'name': name, 'email': email, 'password': password},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true; // Registro bem-sucedido
    } catch (e) {
      print("Erro ao registrar usuário: $e");
      return false; // Registro falhou
    }
  }

  Future<bool> authenticateUser(String email, String password) async {
    final db = await database;
    var result = await db!.query(
      'User',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty;
  }
}
