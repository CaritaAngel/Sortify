import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/repositories/waste_repository.dart';
import '../../data/repositories/waste_statistics.dart';
import '../../data/seed/waste_seed.dart';
import '../../models/waste_record.dart';
import '../../widgets/sortify_widgets.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: WasteRepository.instance,
      builder: (context, _) => FutureBuilder<List<WasteRecord>>(
        future: WasteRepository.instance.getRecords(),
        builder: (context, snapshot) {
          final records = snapshot.data ?? const <WasteRecord>[];
          final statistics = WasteStatistics.fromRecords(records);
          final groups = <String, List<WasteRecord>>{};
          for (final record in records) {
            final key = _dateLabel(record.recordDate);
            groups.putIfAbsent(key, () => []).add(record);
          }
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
              children: [
                const AppHeader(title: 'Riwayat Aktivitas', subtitle: 'Lihat progres pengelolaan sampahmu.'),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Ringkasan keseluruhan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(child: _whiteStat('${statistics.recordCount}', 'Aktivitas')),
                          Container(width: 1, height: 42, color: Colors.white24),
                          Expanded(child: _whiteStat('${statistics.totalWeightKg.toStringAsFixed(2)} kg', 'Berat tercatat')),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                SectionHeader(title: 'Semua aktivitas', actionLabel: '${records.length} catatan'),
                const SizedBox(height: 10),
                if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData)
                  const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()))
                else if (snapshot.hasError)
                  const EmptyState(title: 'Riwayat belum dapat dimuat', message: 'Terjadi kendala saat membaca penyimpanan perangkat.', icon: Icons.error_outline_rounded)
                else if (records.isEmpty)
                  const EmptyState(title: 'Riwayat masih kosong', message: 'Aktivitas yang kamu simpan akan muncul di sini.', icon: Icons.history_rounded)
                else
                  ...groups.entries.map((entry) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.fromLTRB(2, 8, 2, 8), child: Text(entry.key, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.green))),
                      ...entry.value.map((record) => Padding(padding: const EdgeInsets.only(bottom: 8), child: ActivityCard(record: record, onTap: () => _showDetail(context, record)))),
                    ],
                  )),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _whiteStat(String value, String label) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
      const SizedBox(height: 3),
      Text(label, style: const TextStyle(color: Color(0xFFE4F3E8), fontSize: 12)),
    ],
  );

  String _dateLabel(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) return 'Hari ini';
    final yesterday = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));
    if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) return 'Kemarin';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  void _showDetail(BuildContext context, WasteRecord record) {
    final category = wasteCategories.firstWhere((c) => c.id == record.categoryId, orElse: () => wasteCategories.last);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Detail aktivitas', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 14),
              _detailRow('Nama sampah', record.wasteName),
              _detailRow('Kategori', category.name),
              _detailRow('Jumlah', '${record.amount} ${record.unit}'),
              _detailRow('Tanggal', _dateLabel(record.recordDate)),
              _detailRow('Metode', record.method),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: sheetContext,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Hapus catatan?'),
                        content: const Text('Catatan ini akan dihapus dari riwayat perangkat.'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Batal')),
                          FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Hapus')),
                        ],
                      ),
                    );
                    if (confirm == true && record.id != null) {
                      await WasteRepository.instance.deleteRecord(record.id!);
                      if (sheetContext.mounted) Navigator.pop(sheetContext);
                    }
                  },
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: const Text('Hapus catatan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 105, child: Text(label, style: const TextStyle(color: AppColors.muted))),
        Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.text))),
      ],
    ),
  );
}
