import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/repositories/waste_repository.dart';
import '../../data/repositories/waste_statistics.dart';
import '../../data/seed/waste_seed.dart';
import '../../models/waste_record.dart';
import '../../widgets/sortify_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onNavigate, required this.onOpenRecord});
  final ValueChanged<int> onNavigate;
  final ValueChanged<WasteRecord> onOpenRecord;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: WasteRepository.instance,
      builder: (context, _) => FutureBuilder<List<WasteRecord>>(
        future: WasteRepository.instance.getRecords(),
        builder: (context, snapshot) {
          final records = snapshot.data ?? const <WasteRecord>[];
          final statistics = WasteStatistics.fromRecords(records);
          return SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 600;
                return ListView(
                  padding: EdgeInsets.fromLTRB(wide ? 28 : 18, 16, wide ? 28 : 18, 24),
                  children: [
                    const AppHeader(title: 'Halo, Sobat Hijau!', subtitle: 'Langkah kecilmu berarti untuk bumi.', showAvatar: true),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(22)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mulai dari sampahmu', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 19)),
                                const SizedBox(height: 7),
                                const Text('Kenali, pilah, dan kelola dengan cara yang tepat.', style: TextStyle(color: Color(0xFFE4F3E8), height: 1.4)),
                                const SizedBox(height: 14),
                                FilledButton.tonalIcon(
                                  onPressed: () => onNavigate(1),
                                  icon: const Icon(Icons.search_rounded),
                                  label: const Text('Cari sampah'),
                                  style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.green),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.eco_rounded, size: 70, color: Color(0xFFB7E0C6)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    const SectionHeader(title: 'Ringkasan aktivitas'),
                    const SizedBox(height: 10),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: wide ? 4 : 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: wide ? 1.4 : 1.45,
                      children: [
                        StatCard(value: '${statistics.recordCount}', label: 'Catatan dibuat', icon: Icons.fact_check_rounded),
                        StatCard(value: '${statistics.totalWeightKg.toStringAsFixed(1)} kg', label: 'Berat tercatat', icon: Icons.scale_rounded, tint: const Color(0xFFE4F0F7)),
                      ],
                    ),
                    const SizedBox(height: 22),
                    SectionHeader(title: 'Jelajahi kategori', actionLabel: 'Lihat semua', onAction: () => onNavigate(2)),
                    const SizedBox(height: 10),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: wide ? 3 : 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: wide ? 1.55 : 1.25,
                      children: wasteCategories.take(4).map((c) => CategoryCard(category: c, compact: true, onTap: () => onNavigate(2))).toList(),
                    ),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(color: const Color(0xFFFFF0D2), borderRadius: BorderRadius.circular(18)),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.lightbulb_outline_rounded, color: Color(0xFF8A5B00)),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tips hari ini', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.text)),
                                SizedBox(height: 4),
                                Text('Pastikan kemasan daur ulang kosong dan kering sebelum disetor.', style: TextStyle(color: AppColors.text, height: 1.4)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    SectionHeader(title: 'Aktivitas terbaru', actionLabel: 'Riwayat', onAction: () => onNavigate(5)),
                    const SizedBox(height: 10),
                    if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData)
                      const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()))
                    else if (snapshot.hasError)
                      const EmptyState(title: 'Data belum dapat dimuat', message: 'Terjadi kendala saat membaca catatan dari penyimpanan perangkat.', icon: Icons.error_outline_rounded)
                    else if (records.isEmpty)
                      const EmptyState(title: 'Belum ada aktivitas', message: 'Catat pengelolaan sampah pertamamu untuk mulai melihat progres.', icon: Icons.eco_outlined)
                    else
                      ...records.take(3).map((record) => Padding(padding: const EdgeInsets.only(bottom: 8), child: ActivityCard(record: record, onTap: () => onOpenRecord(record)))),
                    const SizedBox(height: 8),
                    PrimaryButton(label: 'Catat sampah', icon: Icons.add_rounded, onPressed: () => onNavigate(4)),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
