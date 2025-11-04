import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
 static const _database_name = "ENSIA_MY_DB.db";
 static const _database_version = 4;
 static var database;

 static Future getDatabase() async {
   if (database != null) {
     return database;
   }
   database = openDatabase(
     join(await getDatabasesPath(), _database_name),
     onCreate: (database, version) {
       database.execute('''
         CREATE TABLE  loginHistory (
             id INTEGER PRIMARY KEY AUTOINCREMENT,
             username TEXT,
             date TEXT
         )
       ''');
     },
     version: _database_version,
     onUpgrade: (db, oldVersion, newVersion) {     },
   );
   return database;
 }
}
