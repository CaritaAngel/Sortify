import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/seed/waste_seed.dart';
import '../../models/waste_item.dart';
import '../../widgets/sortify_widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.onRecord});
  final VoidCallback onRecord;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  String _category = 'Semua';
  String _query = '';
  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final categories = ['Semua', ...wasteCategories.map((c) => c.name)];
    final filtered = wasteItems.where((item) {
      final cat = wasteCategories.firstWhere((c) => c.id == item.categoryId);
      return item.name.toLowerCase().contains(_query.toLowerCase()) && (_category == 'Semua' || cat.name == _category);
    }).toList();
    return SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(18, 16, 18, 24), children: [
      const AppHeader(title: 'Cari Sampah', subtitle: 'Temukan cara memilah yang tepat.'),
      const SizedBox(height: 18),
      SearchField(controller: _controller, onChanged: (v) => setState(() => _query = v)),
      const SizedBox(height: 15),
      Text('Kategori', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 9),
      SizedBox(height: 38, child: ListView.separated(scrollDirection: Axis.horizontal, itemCount: categories.length, separatorBuilder: (_, __) => const SizedBox(width: 7), itemBuilder: (context, index) => ChoiceChip(label: Text(categories[index]), selected: _category == categories[index], onSelected: (_) => setState(() => _category = categories[index])))),
      const SizedBox(height: 18),
      SectionHeader(title: 'Hasil pencarian', actionLabel: '${filtered.length} item'),
      const SizedBox(height: 10),
      if (filtered.isEmpty) EmptyState(title: 'Sampah tidak ditemukan', message: 'Coba kata kunci lain atau hapus filter kategori.', icon: Icons.search_off_rounded, actionLabel: 'Reset pencarian', onAction: () => setState(() { _query = ''; _category = 'Semua'; _controller.clear(); }))
      else ...filtered.map((item) => Padding(padding: const EdgeInsets.only(bottom: 9), child: WasteItemCard(item: item, onTap: () => _showDetail(item)))),
    ]));
  }

  void _showDetail(WasteItem item) {
    final category = wasteCategories.firstWhere((c) => c.id == item.categoryId);
    showModalBottomSheet<void>(context: context, isScrollControlled: true, showDragHandle: true, builder: (context) => SafeArea(child: Padding(padding: const EdgeInsets.fromLTRB(22, 8, 22, 24), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 54, height: 54, decoration: BoxDecoration(color: category.color, borderRadius: BorderRadius.circular(16)), child: Icon(item.icon, color: AppColors.green, size: 28)), const SizedBox(height: 14), Text(item.name, style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height: 5), Chip(label: Text(category.name)), const SizedBox(height: 8), Text(item.description), const SizedBox(height: 16), Text('Cara penanganan', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 6), Text(item.handling), const SizedBox(height: 18), PrimaryButton(label: 'Catat sampah', icon: Icons.add_rounded, onPressed: () { Navigator.pop(context); widget.onRecord(); })]))));
  }
}
