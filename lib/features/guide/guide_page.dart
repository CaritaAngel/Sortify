import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/seed/waste_seed.dart';
import '../../widgets/sortify_widgets.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key, required this.onRecord});
  final VoidCallback onRecord;

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final Set<int> _completed = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
        children: [
          const AppHeader(title: 'Panduan Pemilahan', subtitle: 'Lima langkah sederhana untuk memulai.'),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                const Icon(Icons.eco_rounded, color: Color(0xFFB7E0C6), size: 42),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Mulai dari kebiasaan kecil', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text('${_completed.length} dari ${guideSteps.length} langkah selesai', style: const TextStyle(color: Color(0xFFE4F3E8))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(value: _completed.length / guideSteps.length, minHeight: 7, backgroundColor: AppColors.greenLight, color: AppColors.green),
          ),
          const SizedBox(height: 18),
          const SectionHeader(title: 'Langkah pemilahan'),
          const SizedBox(height: 10),
          ...guideSteps.asMap().entries.map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: GuideStepCard(
              number: entry.key + 1,
              title: entry.value.title,
              description: entry.value.description,
              icon: entry.value.icon,
              checked: _completed.contains(entry.key),
              onChanged: (value) => setState(() {
                if (value == true) {
                  _completed.add(entry.key);
                } else {
                  _completed.remove(entry.key);
                }
              }),
            ),
          )),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: const Color(0xFFFFF0D2), borderRadius: BorderRadius.circular(18)),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber_rounded, color: Color(0xFF8A5B00)),
                SizedBox(width: 10),
                Expanded(child: Text('Baterai, lampu, dan limbah berbahaya tidak boleh dicampur dengan sampah rumah tangga biasa.', style: TextStyle(height: 1.4, color: AppColors.text))),
              ],
            ),
          ),
          const SizedBox(height: 18),
          PrimaryButton(label: 'Catat aktivitas sampah', icon: Icons.add_rounded, onPressed: widget.onRecord),
        ],
      ),
    );
  }
}
