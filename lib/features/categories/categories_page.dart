import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/seed/waste_seed.dart';
import '../../models/waste_category.dart';
import '../../widgets/sortify_widgets.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 600;
          return ListView(
            padding: EdgeInsets.fromLTRB(wide ? 28 : 18, 16, wide ? 28 : 18, 24),
            children: [
              const AppHeader(title: 'Kategori Sampah', subtitle: 'Setiap bahan punya cara kelola yang berbeda.'),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: AppColors.greenLight, borderRadius: BorderRadius.circular(18)),
                child: const Row(
                  children: [
                    Icon(Icons.tips_and_updates_outlined, color: AppColors.green, size: 28),
                    SizedBox(width: 11),
                    Expanded(child: Text('Pilah dari sumbernya untuk menjaga bahan tetap mudah didaur ulang.', style: TextStyle(height: 1.4, color: AppColors.text))),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: wasteCategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: wide ? 3 : 2, crossAxisSpacing: 11, mainAxisSpacing: 11, childAspectRatio: wide ? 1.4 : 1.03),
                itemBuilder: (context, index) => CategoryCard(category: wasteCategories[index], onTap: () => _showCategory(context, wasteCategories[index])),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showCategory(BuildContext context, WasteCategory category) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 26),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 56, height: 56, decoration: BoxDecoration(color: category.color, borderRadius: BorderRadius.circular(16)), child: Icon(category.icon, color: AppColors.green, size: 30)),
                const SizedBox(height: 14),
                Text(category.name, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 6),
                Text(category.description),
                const SizedBox(height: 18),
                Text('Contoh sampah', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Wrap(spacing: 7, runSpacing: 7, children: category.examples.map((e) => Chip(label: Text(e))).toList()),
                const SizedBox(height: 18),
                Text('Cara penanganan', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 6),
                Text(category.howTo),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
