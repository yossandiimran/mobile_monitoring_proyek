// ignore_for_file: depend_on_referenced_packages, file_names, unnecessary_null_comparison, avoid_print

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "penerimaan.db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    print(path.toString());
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE temp_transaksi (
            id TEXT PRIMARY KEY AUTO INCREMENT,
            no_po_sto TEXT NOT NULL,
            foto TEXT NOT NULL,
            keterangan TEXT NOT NULL,
            status_kirim TEXT NOT NULL,
            created_at TEXT NOT NULL,
            send_at TEXT NOT NULL
          )
          ''');
  }

  // Future<int?> countPembelian() async {
  //   Database? db = await instance.database;
  //   return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $tblTempBbm'));
  // }

  // Future<List<Map<String, dynamic>>> readPembelian(String qrKode) async {
  //   Database? db = await instance.database;
  //   return await db!.rawQuery("SELECT * FROM $tblTempBbm WHERE  $columnQrCode = '$qrKode' ");

  // }

  // Future<int> deletePembelian(String id) async {
  //   Database? db = await instance.database;
  //   return await db!.delete(
  //     tblTempBbm,
  //     where: '$columnId = ?',
  //     whereArgs: [id],
  //   );
  // }
}
