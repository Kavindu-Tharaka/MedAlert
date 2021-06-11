import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:MedAlert/model/sugar_report_database.dart';

class ReportDatabase {
  static final ReportDatabase instance = ReportDatabase._init();

  static Database _database;

  ReportDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('reports.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableSugar ( 
  ${SugarFields.id} $idType, 
  ${SugarFields.sugarLevelF} $textType,
  ${SugarFields.sugarLevelPP} $textType,
  ${SugarFields.reportDate} $textType)
''');
  }

  //create operation
  Future<Sugar> create(Sugar sugar) async {
    final db = await instance.database;

    final id = await db.insert(tableSugar, sugar.toJson());
    return sugar.copy(id: id);
  }

//read single sugar report record
  Future<Sugar> readSugar(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableSugar,
      columns: SugarFields.values,
      where: '${SugarFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Sugar.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  //read multiple records
  Future<List<Sugar>> readAllSugar() async {
    final db = await instance.database;

    final orderBy = '${SugarFields.reportDate} ASC';

    final result = await db.query(tableSugar, orderBy: orderBy);

    return result.map((json) => Sugar.fromJson(json)).toList();
  }

  //update sugar report records
  Future<int> update(Sugar sugar) async {
    final db = await instance.database;

    return db.update(
      tableSugar,
      sugar.toJson(),
      where: '${SugarFields.id} = ?',
      whereArgs: [sugar.id],
    );
  }

//delete sugar report
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableSugar,
      where: '${SugarFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
