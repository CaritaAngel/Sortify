import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    final dbPath = await getDatabasesPath();
    _database = await openDatabase(
      p.join(dbPath, 'sortify.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE waste_records (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            waste_name TEXT NOT NULL,
            category_id TEXT NOT NULL,
            amount REAL NOT NULL CHECK(amount > 0),
            unit TEXT NOT NULL,
            record_date TEXT NOT NULL,
            method TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
        await db.execute('CREATE INDEX idx_waste_records_date ON waste_records(record_date)');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Tambahkan migrasi skema di sini ketika versi database bertambah.
      },
    );
    return _database!;
  }
}
