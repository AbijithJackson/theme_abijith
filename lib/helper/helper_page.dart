import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHepler {
  static final _databasename = "spectrum.db";
  static final _databaseversion = 1;
  static final tablename = "internship_record";
  static final ColumnOne = "Id";
  static final ColumnTwo = "Name";
  static final ColumnThree = "College";

  //check the database already exists or not

  late Database _database; //creating reference variable for Database class

  //creating async method to check db connection
  Future<void> openDatabases() async {
    final directoryPath =
        await getApplicationDocumentsDirectory(); // database path

    final path = join(directoryPath.path,
        _databasename); // join method used to get the path of db and its name

    _database = await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  //create table

  Future _onCreate(Database db, int version) async {
    await db.execute("""  CREATE TABLE $tablename(
      
      $ColumnOne INTEGER PRIMARY KEY,
      $ColumnTwo TEXT NOT NULL,
      $ColumnThree TEXT NOT NULL,

      )
      """);
  }

//insert


  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  Future<int> insert(Map<String, dynamic>row) async {
    return await _database.insert(tablename, row);
  }


  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row

  Future<int> update(Map<String, dynamic>row) async{
    int id = row[ColumnOne];
    return await _database.update(
        tablename,
        row,
        where: '$ColumnOne = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.

  Future<int> delete(int id) async {
    return await _database.delete(
      tablename,
      where: '$ColumnOne = ?',
      whereArgs: [id],
    );
  }




}
