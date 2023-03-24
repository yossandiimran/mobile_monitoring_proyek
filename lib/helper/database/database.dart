// ignore_for_file: depend_on_referenced_packages, file_names, unnecessary_null_comparison, avoid_print

import 'package:grproyek/model/database/TempTransaksiDBModel.dart';
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
            plant TEXT NOT NULL,
            no_mobil TEXT NOT NULL,
            no_po TEXT NOT NULL,
            detail TEXT NOT NULL,
            foto TEXT NOT NULL,
            keterangan TEXT NOT NULL,
            lat TEXT NOT NULL,
            lng TEXT NOT NULL,
            status_kirim TEXT NOT NULL,
            is_done TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
          ''');
  }

  //Insert
  Future<int> insertTransaksi(TempTransaksiDBModel transaksi) async {
    Database? db = await instance.database;
    return await db!.insert("temp_transaksi", {
      'plant': transaksi.plant,
      'no_mobil': transaksi.noMobil,
      'no_po': transaksi.noPo,
      'detail': transaksi.detail,
      'foto': transaksi.foto,
      'keterangan': transaksi.keterangan,
      'lat': transaksi.lat,
      'lng': transaksi.lng,
      'status_kirim': transaksi.statusKirim,
      'is_done': transaksi.isDone,
      'created_at': transaksi.createdAt,
    });
  }

  //Read All Transaski
  Future<List<Map<String, dynamic>>> readTransaksi({String? plant, String? noPo, String? barang}) async {
    Database? db = await instance.database;
    return await db!.rawQuery(
      "SELECT * FROM temp_transaksi WHERE status_kirim = '0' AND plant = '$plant' AND no_po = '$noPo' AND detail LIKE '%$barang%' ",
    );
  }

  // Read Transaksi By Filter
  Future<List<Map<String, dynamic>>> readTransaksiFilter({String? noPo, String? noMobil}) async {
    Database? db = await instance.database;
    return await db!.rawQuery("SELECT * FROM temp_transaksi WHERE no_mobil = '$noMobil' AND no_po = '$noPo' ");
  }

  // Read Transaksi By Filter and Date
  Future<List<Map<String, dynamic>>> readTransaksiFilterDate({String? noPo, String? noMobil, String? createdAt}) async {
    Database? db = await instance.database;
    return await db!.rawQuery(
      "SELECT * FROM temp_transaksi WHERE no_mobil = '$noMobil' AND no_po = '$noPo' AND created_at = '$createdAt'",
    );
  }

  // Read Transaksi By Filter and Date
  Future<List<Map<String, dynamic>>> updateStatusTransaksi({
    String? noPo,
    String? noMobil,
    String? createdAt,
    String? status,
  }) async {
    Database? db = await instance.database;
    return await db!.rawQuery(
      "UPDATE temp_transaksi SET status_kirim = '$status' WHERE no_mobil = '$noMobil' AND no_po = '$noPo' AND created_at = '$createdAt'",
    );
  }

  Future<int?> countTransaksi({String? plant, String? noPo, String? barang}) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
      await db!.rawQuery(
        "SELECT COUNT(*) FROM temp_transaksi where status_kirim = '0' AND plant = '$plant' AND no_po = '$noPo' AND detail LIKE '%$barang%'",
      ),
    );
  }

  Future<int> deleteTransaksi({String? noPo, String? noMobil, String? createdAt}) async {
    Database? db = await instance.database;
    return await db!.delete(
      "temp_transaksi",
      // where: 'no_mobil = ?',
      // whereArgs: [noMobil],
      where: 'no_mobil = ? AND no_po = ? AND created_at = ?',
      whereArgs: [noMobil, noPo, createdAt],
    );
  }
}
