import 'package:MedAlert/model/medicine.dart';
import 'package:MedAlert/model/reminder.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MedicineDatabase {
  static final MedicineDatabase instance = MedicineDatabase._init();

  static Database _database;

  MedicineDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('medicine.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $tableMedicine ( 
          ${MedicineFields.colId} INTEGER PRIMARY KEY AUTOINCREMENT, 
          ${MedicineFields.colName} TEXT NOT NULL,
          ${MedicineFields.colTotalAmount} INTEGER NOT NULL,
          ${MedicineFields.colCurrentAmount} INTEGER NOT NULL,
          ${MedicineFields.colDosageAmount} INTEGER NOT NULL,
          ${MedicineFields.colAmountUnit} TEXT NOT NULL,
          ${MedicineFields.colIsBefore} BOOLEAN NOT NULL,
          ${MedicineFields.colTimesPerDay} INTEGER NOT NULL,
          ${MedicineFields.colColor} TEXT NOT NULL
        )
    ''');

    await db.execute('''
        CREATE TABLE $tableReminder ( 
          ${ReminderFields.colId} INTEGER PRIMARY KEY AUTOINCREMENT, 
          ${ReminderFields.colMedicineId} INTEGER NOT NULL, 
          ${ReminderFields.colHour} INTEGER NOT NULL,
          ${ReminderFields.colMinute} INTEGER NOT NULL,
          ${ReminderFields.colMonday} BOOLEAN NOT NULL,
          ${ReminderFields.colTuesday} BOOLEAN NOT NULL,
          ${ReminderFields.colWednesday} BOOLEAN NOT NULL,
          ${ReminderFields.colThursday} BOOLEAN NOT NULL,
          ${ReminderFields.colFriday} BOOLEAN NOT NULL,
          ${ReminderFields.colSaturday} BOOLEAN NOT NULL,
          ${ReminderFields.colSunday} BOOLEAN NOT NULL,
          ${ReminderFields.colMedicineName} TEXT NOT NULL,
          ${ReminderFields.colIsBefore} BOOLEAN NOT NULL
        )
    ''');
  }

  //Medicine CRUDS - Start
  Future<Medicine> createMedicine(Medicine medicine) async {
    final db = await instance.database;
    final id = await db.insert(tableMedicine, medicine.toJson());
    return medicine.copy(id: id);
  }

  Future<Medicine> readMedicine(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMedicine,
      columns: MedicineFields.values,
      where: '${MedicineFields.colId} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Medicine.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Medicine>> readAllMedicines() async {
    final db = await instance.database;

    final result = await db.rawQuery('SELECT * FROM $tableMedicine');

    return result.map((json) => Medicine.fromJson(json)).toList();
  }

  Future<int> updateMedicine(Medicine medicine) async {
    final db = await instance.database;

    return db.update(
      tableMedicine,
      medicine.toJson(),
      where: '${MedicineFields.colId} = ?',
      whereArgs: [medicine.id],
    );
  }

  Future<int> reduceMedicineCount(Medicine medicine) async {
    final db = await instance.database;

    int numOfAffectedRows = await db.rawUpdate(
        'UPDATE $tableMedicine SET ${MedicineFields.colCurrentAmount} = ${MedicineFields.colCurrentAmount} - ${medicine.dosageAmount} WHERE ${MedicineFields.colId} = ${medicine.id}');

    return numOfAffectedRows;
  }

  Future<int> deleteMedicine(int id) async {
    final db = await instance.database;

    await db.delete(
      tableMedicine,
      where: '${MedicineFields.colId} = ?',
      whereArgs: [id],
    );

    return id;
  }
  //Medicine CRUDS - End

  //Reminder CRUDS - Start
  Future<Reminder> createReminder(Reminder reminder) async {
    final db = await instance.database;
    final id = await db.insert(tableReminder, reminder.toJson());
    return reminder.copy(id: id);
  }

  Future<Reminder> readReminder(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableReminder,
      columns: ReminderFields.values,
      where: '${ReminderFields.colId} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Reminder.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Reminder>> readAllReminders() async {
    final db = await instance.database;

    final result = await db.rawQuery('SELECT * FROM $tableReminder');

    return result.map((json) => Reminder.fromJson(json)).toList();
  }

  Future<int> updateReminder(Reminder reminder) async {
    final db = await instance.database;

    return db.update(
      tableReminder,
      reminder.toJson(),
      where: '${ReminderFields.colId} = ?',
      whereArgs: [reminder.id],
    );
  }

  Future<void> deleteReminder(int id) async {
    final db = await instance.database;

    await db.rawDelete(
        'DELETE FROM $tableReminder WHERE ${ReminderFields.colMedicineId} = $id');
  }
  //Reminder CRUDS - End

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
