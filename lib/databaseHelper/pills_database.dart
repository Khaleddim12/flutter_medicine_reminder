import 'package:medicine_reminder/models/pill.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _db;
  DatabaseHelper._init();

  Future<Database> get database async{
    if(_db != null) return _db!;
    _db = await initializeDB();
    return _db!;
  }
  String query='''CREATE TABLE pills (id INTEGER PRIMARY KEY, name TEXT, amount TEXT,howManyWeeks INTEGER, medicineForm TEXT, time INTEGER, notifyId INTEGER)''';
  Future<Database> initializeDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'pills_db');
    return await openDatabase(
      path,
      onCreate: (Database db, int version) async {
        await db.execute(query);
      },
      version: 1,
    );
  }

  //insert something to database
  Future insertData(Pill pill) async {
    final db = await instance.database;

    pill.id = await db.insert(
      'pills',
      pill.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if(pill.id != null){
      print("correct");
    }
    return pill;
  }

  //get all data from database
  Future getAllData() async{
    final db = await instance.database;
    return await db.query('pills');
  }

  Future<int> deletePill(int id) async {
    final db = await instance.database;

    return await db.delete('pills', where: 'id = ?', whereArgs: [id]);
  }

  Future empty() async {
    final db = await instance.database;
    await db.delete('pills');
  }

  Future close() async {
    final db = await instance.database;
    await db.close();
  }
}
