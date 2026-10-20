import '../../models/waste_record.dart';

class WasteStatistics {
  const WasteStatistics({required this.recordCount, required this.totalWeightKg});

  final int recordCount;
  final double totalWeightKg;

  factory WasteStatistics.fromRecords(Iterable<WasteRecord> records) {
    var totalWeightKg = 0.0;
    var recordCount = 0;
    for (final record in records) {
      recordCount++;
      if (record.unit == 'kg') totalWeightKg += record.amount;
      if (record.unit == 'g') totalWeightKg += record.amount / 1000;
    }
    return WasteStatistics(recordCount: recordCount, totalWeightKg: totalWeightKg);
  }
}
