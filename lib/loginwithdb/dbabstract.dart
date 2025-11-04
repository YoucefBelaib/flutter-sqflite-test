import 'package:sqflite/sqflite.dart';
import './dbhelper.dart';

abstract class AbstractLoginRepo {
 Future<List<Map>> getData();
 Future<void> insertLogin(Map<String, dynamic> item);
 Future<void> deleteLogin(int index);
 Future<void> deleteAllLogin();

 static AbstractLoginRepo? _loginInstance;

 static AbstractLoginRepo getInstance() {
   _loginInstance ??= DBLogin();
   return _loginInstance!; // For backend data
 }
}


class DBLogin extends AbstractLoginRepo {
   
   @override
   Future<List<Map>> getData() async {
   final database = await DBHelper.getDatabase();
   return database.rawQuery('''SELECT
           loginHistory.id ,
           loginHistory.username,
           loginHistory.date
         from loginHistory
         ''');
 }
 @override
 Future<void> insertLogin(Map<String, dynamic> data) async {
   final database = await DBHelper.getDatabase();
   await database.insert("loginHistory", data, conflictAlgorithm: ConflictAlgorithm.replace);
 }
 @override
 Future<void> deleteLogin(int id) async {
   final database = await DBHelper.getDatabase();
   await database.rawQuery("""delete from  loginHistory where id=?""", [id]);
 }
 @override
  Future<void> deleteAllLogin() async {
    final database = await DBHelper.getDatabase();
    await database.rawQuery("""delete from loginHistory""");
  }
 
}

