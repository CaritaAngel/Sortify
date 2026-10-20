import 'package:flutter/material.dart';
import '../features/home/home_page.dart';
import '../features/search/search_page.dart';
import '../features/categories/categories_page.dart';
import '../features/guide/guide_page.dart';
import '../features/waste_records/waste_record_page.dart';
import '../features/history/history_page.dart';
import '../models/waste_record.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(onNavigate: _navigate, onOpenRecord: _openRecord),
      SearchPage(onRecord: () => _navigate(4)),
      const CategoriesPage(),
      GuidePage(onRecord: () => _navigate(4)),
      WasteRecordPage(onSaved: () => _navigate(5)),
      const HistoryPage(),
    ];
  }

  void _navigate(int index) => setState(() => _selectedIndex = index);

  void _openRecord(WasteRecord record) {
    showModalBottomSheet<void>(context: context, showDragHandle: true, builder: (context) => SafeArea(child: Padding(padding: const EdgeInsets.all(22), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(record.wasteName, style: Theme.of(context).textTheme.headlineSmall), const SizedBox(height: 8), Text('Jumlah: ${record.amount} ${record.unit}'), Text('Metode: ${record.method}'), const SizedBox(height: 12), SizedBox(width: double.infinity, child: FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup')))]))));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(index: _selectedIndex, children: _pages),
    bottomNavigationBar: NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: _navigate,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.search_rounded), label: 'Cari'),
        NavigationDestination(icon: Icon(Icons.category_outlined), selectedIcon: Icon(Icons.category_rounded), label: 'Kategori'),
        NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book_rounded), label: 'Panduan'),
        NavigationDestination(icon: Icon(Icons.add_box_outlined), selectedIcon: Icon(Icons.add_box_rounded), label: 'Catatan'),
        NavigationDestination(icon: Icon(Icons.history_rounded), label: 'Riwayat'),
      ],
    ),
  );
}
