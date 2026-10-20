import 'package:flutter_test/flutter_test.dart';
import 'package:sortify/data/seed/waste_seed.dart';
import 'package:sortify/data/repositories/waste_statistics.dart';
import 'package:sortify/models/waste_record.dart';

void main() {
  group('WasteRecord', () {
    test('serializes and restores a record', () {
      final original = WasteRecord(
        id: 7,
        wasteName: 'Botol plastik',
        categoryId: 'plastik',
        amount: 0.5,
        unit: 'kg',
        recordDate: DateTime(2026, 10, 19),
        method: 'Didaur ulang',
        createdAt: DateTime(2026, 10, 19, 10, 30),
      );

      final restored = WasteRecord.fromMap(original.toMap());
      expect(restored.id, original.id);
      expect(restored.wasteName, original.wasteName);
      expect(restored.categoryId, original.categoryId);
      expect(restored.amount, original.amount);
      expect(restored.unit, original.unit);
      expect(restored.recordDate, original.recordDate);
      expect(restored.method, original.method);
      expect(restored.createdAt, original.createdAt);
    });
  });

  group('WasteStatistics', () {
    test('converts grams to kilograms and excludes item counts from weight', () {
      final records = [
        WasteRecord(wasteName: 'Botol', categoryId: 'plastik', amount: 1.5, unit: 'kg', recordDate: DateTime(2026, 10, 19), method: 'Didaur ulang', createdAt: DateTime(2026, 10, 19)),
        WasteRecord(wasteName: 'Kaleng', categoryId: 'logam', amount: 500, unit: 'g', recordDate: DateTime(2026, 10, 19), method: 'Didaur ulang', createdAt: DateTime(2026, 10, 19)),
        WasteRecord(wasteName: 'Botol', categoryId: 'plastik', amount: 3, unit: 'buah', recordDate: DateTime(2026, 10, 19), method: 'Digunakan kembali', createdAt: DateTime(2026, 10, 19)),
      ];
      final statistics = WasteStatistics.fromRecords(records);
      expect(statistics.recordCount, 3);
      expect(statistics.totalWeightKg, 2.0);
    });
  });

  group('Seed data', () {
    test('every waste item refers to an existing category', () {
      final categoryIds = wasteCategories.map((category) => category.id).toSet();
      expect(wasteItems, isNotEmpty);
      for (final item in wasteItems) {
        expect(categoryIds.contains(item.categoryId), isTrue, reason: '${item.name} must have a valid category');
      }
    });

    test('category ids are unique', () {
      final ids = wasteCategories.map((category) => category.id).toList();
      expect(ids.toSet().length, ids.length);
    });
  });
}
