class WasteRecord {
  const WasteRecord({this.id, required this.wasteName, required this.categoryId, required this.amount, required this.unit, required this.recordDate, required this.method, required this.createdAt});
  final int? id;
  final String wasteName;
  final String categoryId;
  final double amount;
  final String unit;
  final DateTime recordDate;
  final String method;
  final DateTime createdAt;

  Map<String, Object?> toMap() => {
    'id': id,
    'waste_name': wasteName,
    'category_id': categoryId,
    'amount': amount,
    'unit': unit,
    'record_date': recordDate.toIso8601String(),
    'method': method,
    'created_at': createdAt.toIso8601String(),
  };

  factory WasteRecord.fromMap(Map<String, Object?> map) => WasteRecord(
    id: map['id'] as int?,
    wasteName: map['waste_name'] as String,
    categoryId: map['category_id'] as String,
    amount: (map['amount'] as num).toDouble(),
    unit: map['unit'] as String,
    recordDate: DateTime.parse(map['record_date'] as String),
    method: map['method'] as String,
    createdAt: DateTime.parse(map['created_at'] as String),
  );
}
