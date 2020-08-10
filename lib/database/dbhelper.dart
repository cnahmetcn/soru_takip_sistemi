import 'package:project_mars/models/questions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String dbName = "question.db";
  final String tableQuestion = "studentTable";
  final String columnId = "id";
  final String columnDersadi = "dersadi";
  final String columnKonuadi = "konuadi";
  final String columnSorusayisi = "sorusayisi";
  final String columnDogrusayisi = "dogrusayisi";
  final String columnYanlissayisi = "yanlissayisi";
  final String columnBossayisi = "bossayisi";
  final String columnNetsayisi = "netsayisi";
  final String columnTarih = "tarih";

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, newVersion) async {
    await db.execute("CREATE TABLE " + tableQuestion + "(  $columnId INTEGER PRIMARY KEY AUTOINCREMENT , dersadi TEXT, konuadi TEXT, sorusayisi INTEGER, dogrusayisi INTEGER, yanlissayisi INTEGER, bossayisi INTEGER, netsayisi REAL, $columnTarih REAL)");
  }

  Future<int> create(Question question) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableQuestion, question.toJSon());
    return result;
  }

  Future<List> findAll() async {
    var dbClient = await db;
    var result = await dbClient.query(tableQuestion, columns: [
      columnSorusayisi,
      columnDogrusayisi,
      columnYanlissayisi,
      columnId,
      columnDersadi,
      columnKonuadi,
      columnTarih,
      columnBossayisi,
      columnNetsayisi
      
    ]);
    return result.toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableQuestion, where: '$columnId = ?', whereArgs: [id]);
  }

    Future<int> update(Question question) async {
    var dbClient = await db;
    var result = await dbClient.update(tableQuestion, question.toJSon(), where: "$columnId=?",whereArgs: [question.id]);
    return result;
  }
}
