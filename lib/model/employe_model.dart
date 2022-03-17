class EmployeeModel {
  int employeeID;
  String employeeName;
  int employeeAge;
  String employeeCity;

  EmployeeModel(
      {required this.employeeName,
      required this.employeeAge,
      required this.employeeCity,
      required this.employeeID});
  factory EmployeeModel.fromJson(Map<dynamic, dynamic> map) {
    return EmployeeModel(
      employeeID: map['employeeID'],
      employeeName: map['employeeName'],
      employeeAge: map['employeeAge'],
      employeeCity: map['employeeCity'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'employeeName': employeeName,
      'employeeAge': employeeAge,
      'employeeCity': employeeCity,
    };
  }
}
