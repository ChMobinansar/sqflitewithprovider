import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:sqflitewithprovider/model/employe_model.dart';

class DatabaseHelper {
  static final _dbName = 'employeedata.db';
  static final _employeeTable = 'signatureTable';
  static final columnEmployeeId = 'employeeID';
  static final columnEmployeeName = 'employeeName';
  static final columnEmployeeAge = 'employeeAge';
  static final columnEmployeeCity = 'employeeCity';
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      print(
          'Databae Exists $_dbName so i am ignoring rest of create functions');
      return _db;
    }
    print('I am creating Database $_dbName Now ');
    _db = await initDatabase();
    print('db value is $_db');
    return _db;
  }

  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, _dbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_employeeTable($columnEmployeeId INTEGER PRIMARY KEY AUTOINCREMENT,$columnEmployeeName TEXT,$columnEmployeeAge INTEGER,$columnEmployeeCity TEXT)');
    print("Table $_employeeTable  Created!!");
  }

  Future<void> insertEmployeeToDb(String name, int age, String city) async {
    var dbClient = await db;
    await dbClient!.rawInsert(
        'INSERT INTO $_employeeTable($columnEmployeeName, $columnEmployeeAge,$columnEmployeeCity) VALUES("$name", $age,"$city")');
  }

  Future<List<EmployeeModel>> getAllSignaturesFromDb() async {
    var dbClient = await db;
    List<Map> maps = await dbClient!.rawQuery('SELECT * FROM $_employeeTable');
    List<EmployeeModel> signatureList = [];
    for (int i = 0; i < maps.length; i++) {
      signatureList.add(EmployeeModel.fromJson(maps[i]));
    }
    print("$_employeeTable");
    return signatureList;
  }

  Future<void> deleteSignatureFromDb(int employeeId) async {
    var dbClient = await db;
    print('This ID will delete $employeeId');
    await dbClient!.rawDelete(
        'DELETE FROM $_employeeTable WHERE $columnEmployeeId = ?',
        ['$employeeId']);
  }
}
