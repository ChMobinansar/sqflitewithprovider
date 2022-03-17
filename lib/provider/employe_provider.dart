import 'package:flutter/cupertino.dart';
import 'package:sqflitewithprovider/database/db_helper.dart';
import 'package:sqflitewithprovider/model/employe_model.dart';

class EmployeeProvider with ChangeNotifier {
  late DatabaseHelper dbHelper;
  List<EmployeeModel> _employeeList = [];

  List<EmployeeModel> get employeeList => _employeeList;

  set employeeList(List<EmployeeModel> value) {
    _employeeList = value;
    notifyListeners();
  }

  EmployeeProvider() {
    dbHelper = DatabaseHelper();
  }

  Future<void> insertEmployee(String name, int age, String city) async {
    await dbHelper.insertEmployeeToDb(name, age, city);
    notifyListeners();
  }

  Future<List<EmployeeModel>> showEmpolyee() async {
    employeeList.clear();
    employeeList = await dbHelper.getAllSignaturesFromDb();
    notifyListeners();
    return employeeList;
  }

  Future<void> deleteindex(int id) async {
    await dbHelper.deleteSignatureFromDb(id);
    showEmpolyee();
    notifyListeners();
  }
}
