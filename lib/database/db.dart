import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DB{
  static Database? db;

  Future<Database> database() async {
    if(db == null){
      return await initDatabase();
    }else{
      return db!;
    }
  }

  Future<Database> initDatabase() async {
    var db = await openDatabase(
      path.join(await getDatabasesPath(), 'calculator_imc.db'),
      onCreate: _onCreated,
      version: 1
    );

    return db;
  }

  _onCreated(db, version){
    db.execute(_imc);
  }

  String get _imc => 'CREATE TABLE imc(id INTEGER PRIMARY KEY AUTOINCREMENT, weight REAL, height REAL, imc REAL, classification TEXT)';
  
}
