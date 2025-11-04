import 'package:flutter/material.dart';
// import 'cardswithbackend/cards.dart';
// import 'increment/increment.dart';
// import 'loginwithpreferences/login.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'loginwithdb/login.dart';
// import 'dart:io' show Platform;
void main() {
  // if(Platform.isLinux || Platform.isMacOS || Platform.isWindows){
  //   sqfliteFfiInit();
  //   databaseFactory = databaseFactoryFfi;
  // }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Login(),
        ),
      ),
    );
  }
}
