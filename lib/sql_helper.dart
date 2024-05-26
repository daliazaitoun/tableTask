import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SqlHelper {
  Database? db;

  Future<void> createTables() async {
    try {
      await db?.execute("""
    Create table if not exists customers(
    id Integer primary key,
    name String,
    phone String,
    address String
  )
    """);
    } catch (e) {
      print('Error in creating table: $e');
    }
  }

  Future<void> init() async {
    try {
      if (kIsWeb) {
        var factory = databaseFactoryFfiWeb;
        db = await factory.openDatabase('pos.db');
      } else {
        db = await openDatabase(
          'pos.db',
          version: 1,
          onCreate: (db, version) {
            print('database created successfully');
          },
        );
      }
    } catch (e) {
      print('Error in creating database: $e');
    }
  }
}
