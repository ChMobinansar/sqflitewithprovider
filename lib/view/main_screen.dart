import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflitewithprovider/model/employe_model.dart';
import 'package:sqflitewithprovider/provider/employe_provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var nameController = TextEditingController(text: '');

  var ageController = TextEditingController(text: '0');

  var cityController = TextEditingController(text: '');

  //TODO This without provider create Object of Database class
  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeProvider>(builder: (context, vm, _) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter name",
                  hintStyle: TextStyle(fontSize: 10),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter age",
                  hintStyle: TextStyle(fontSize: 10),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter city",
                  hintStyle: TextStyle(fontSize: 10),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      insert(context);
                    },
                    child: customButton(
                      "insert data",
                    )),
                SizedBox(
                  width: 4,
                ),
                customButton(
                  "update data",
                ),
                SizedBox(
                  width: 4,
                ),
                InkWell(
                  child: customButton(
                    "delete data",
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  width: 4,
                ),
                InkWell(
                  child: customButton(
                    "view data",
                  ),
                  onTap: () async {
                    setState(() {
                      showEmployeeData(context);
                    });
                    //TODO this is simple to call of functions with out provider
                    // await db.getAllSignaturesFromDb();
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: vm.employeeList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onLongPress: () {
                      vm.deleteindex(vm.employeeList[index].employeeID);
                    },
                    title: Text(vm.employeeList[index].employeeName),
                    subtitle: Text(vm.employeeList[index].employeeCity),
                    trailing:
                        Text(vm.employeeList[index].employeeAge.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<dynamic> insert(BuildContext context) async {
    await Provider.of<EmployeeProvider>(context, listen: false).insertEmployee(
        nameController.text,
        int.parse(ageController.text),
        cityController.text);
  }

  Future<dynamic> showEmployeeData(BuildContext context) async {
    await Provider.of<EmployeeProvider>(context, listen: false).showEmpolyee();
  }
}

Widget customTextField(String hint) {
  return Padding(
    padding: EdgeInsets.all(15.0),
    child: TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 10),
      ),
      keyboardType: TextInputType.number,
    ),
  );
}

Widget customButton(
  String title,
) {
  return Container(
      width: 85,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
          child: Text(
        title,
        style: TextStyle(
            fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
      )));
}
