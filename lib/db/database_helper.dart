import 'package:MedAlert/model/medicine.dart';
import 'package:MedAlert/model/reminder.dart';
import 'package:MedAlert/model/report.dart';
import '../model/member.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MedicineDatabase {
  static final MedicineDatabase instance = MedicineDatabase._init();

  static Database _database;

  MedicineDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('newmember1.db');
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

    await db.execute('''
        CREATE TABLE $tableMember ( 
          ${MemberFields.colId} INTEGER PRIMARY KEY AUTOINCREMENT, 
          ${MemberFields.colName} TEXT NOT NULL, 
          ${MemberFields.colEmail} TEXT NOT NULL,
          ${MemberFields.colWeight} INTEGER NOT NULL,
          ${MemberFields.colAge} INTEGER NOT NULL
        )
    ''');

    await db.execute('''
CREATE TABLE $tableSugar ( 
  ${SugarFields.id} INTEGER PRIMARY KEY AUTOINCREMENT, 
  ${SugarFields.sugarLevelF} TEXT NOT NULL,
  ${SugarFields.sugarLevelPP} TEXT NOT NULL,
  ${SugarFields.reportDate} TEXT NOT NULL)
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

  Future<Medicine> updateMedicine(Medicine medicine) async {
    final db = await instance.database;

    int boool = medicine.isBefore ? 1 : 0;

    await db.rawUpdate(
        'UPDATE $tableMedicine SET ${MedicineFields.colName} = \'${medicine.name}\', ${MedicineFields.colTotalAmount} = ${medicine.totalAmount}, ${MedicineFields.colDosageAmount} = ${medicine.dosageAmount}, ${MedicineFields.colAmountUnit} = \'${medicine.amountUnit}\', ${MedicineFields.colTimesPerDay} = ${medicine.timesPerDay}, ${MedicineFields.colIsBefore} = $boool WHERE ${MedicineFields.colId} = ${medicine.id}');

    return await MedicineDatabase.instance.readMedicine(medicine.id);
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

  Future<List<Reminder>> readRemindersByMedicineId(medicineId) async {
    final db = await instance.database;

    final result = await db.rawQuery(
        'SELECT * FROM $tableReminder WHERE ${ReminderFields.colMedicineId} = $medicineId');

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

  //Member CRUD start
  Future<Member> createMember(Member member) async {
    print("Came Here **********************************" + member.name);
    final db = await instance.database;
    final id = await db.insert(tableMember, member.toJson());
    return member.copy(id: id);
  }

  Future<Member> readMember(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMember,
      columns: MemberFields.values,
      where: '${MemberFields.colId} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Member.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Member>> readAllMembers() async {
    print('In all read function ');
    final db = await instance.database;

    final result = await db.rawQuery('SELECT * FROM $tableMember');

    return result.map((json) => Member.fromJson(json)).toList();
  }

  Future<int> updateMember(Member member) async {
    final db = await instance.database;

    return db.update(
      tableMember,
      member.toJson(),
      where: '${MemberFields.colId} = ?',
      whereArgs: [member.id],
    );
  }

  Future<void> deleteMember(int id) async {
    final db = await instance.database;

    await db.rawDelete(
        'DELETE FROM $tableMember WHERE ${MemberFields.colId} = $id');
  }

  //Member CRUD Ends

  //report CRUD starts

//insert reports
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

  //report CRUD ends

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
