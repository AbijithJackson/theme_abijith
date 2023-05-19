
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class Helper {


  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE product(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        productname TEXT,
        price TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'trainer.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String productname, String? price, String description) async {
    final db = await Helper.db();

    final data = {'productname': productname,'price':price, 'description': description};
    final id = await db.insert('product', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await Helper.db();
    return db.query('product', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await Helper.db();
    return db.query('product', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String productname, String? price, String description) async {
    final db = await Helper.db();

    final data = {
      'productname': productname,
      'price':price,
      'description': description,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('product', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await Helper.db();
    try {
      await db.delete("product", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}