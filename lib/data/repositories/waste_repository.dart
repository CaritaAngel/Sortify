import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/waste_record.dart';
import '../database/app_database.dart';

class WasteRepository extends ChangeNotifier {
  WasteRepository._();
  static final WasteRepository instance = WasteRepository._();

  Future<List<WasteRecord>> getRecords() async {
    final Database db = await AppDatabase.instance.database;
    final rows = await db.query('waste_records', orderBy: 'record_date DESC, id DESC');
    return rows.map(WasteRecord.fromMap).toList();
  }

  Future<WasteRecord> addRecord(WasteRecord record) async {
    if (record.wasteName.trim().isEmpty) throw ArgumentError('Nama sampah wajib diisi.');
    if (record.amount <= 0 || !record.amount.isFinite) throw ArgumentError('Jumlah harus lebih besar dari nol.');
    if (record.categoryId.trim().isEmpty || record.unit.trim().isEmpty || record.method.trim().isEmpty) {
      throw ArgumentError('Kategori, satuan, dan metode wajib dipilih.');
    }
    final Database db = await AppDatabase.instance.database;
    final id = await db.insert('waste_records', record.toMap()..remove('id'), conflictAlgorithm: ConflictAlgorithm.abort);
    notifyListeners();
    return WasteRecord(id: id, wasteName: record.wasteName.trim(), categoryId: record.categoryId, amount: record.amount, unit: record.unit, recordDate: record.recordDate, method: record.method, createdAt: record.createdAt);
  }

  Future<void> deleteRecord(int id) async {
    final Database db = await AppDatabase.instance.database;
    await db.delete('waste_records', where: 'id = ?', whereArgs: [id]);
    notifyListeners();
  }

  Future<WasteRecord?> getRecord(int id) async {
    final Database db = await AppDatabase.instance.database;
    final rows = await db.query('waste_records', where: 'id = ?', whereArgs: [id], limit: 1);
    return rows.isEmpty ? null : WasteRecord.fromMap(rows.first);
  }
}
