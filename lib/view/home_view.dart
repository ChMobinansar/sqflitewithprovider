import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflitewithprovider/provider/employe_provider.dart';

import 'main_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EmployeeProvider>(
            create: (_) => EmployeeProvider()),
      ],
      child: MaterialApp(
        home: MainScreen(),
      ),
    );
  }
}
