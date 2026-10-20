import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../data/repositories/waste_repository.dart';
import '../../data/seed/waste_seed.dart';
import '../../models/waste_record.dart';
import '../../widgets/sortify_widgets.dart';

class WasteRecordPage extends StatefulWidget {
  const WasteRecordPage({super.key, required this.onSaved});
  final VoidCallback onSaved;
  @override
  State<WasteRecordPage> createState() => _WasteRecordPageState();
}

class _WasteRecordPageState extends State<WasteRecordPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  String _category = wasteCategories.first.id;
  String _unit = 'kg';
  String _method = 'Didaur ulang';
  DateTime _date = DateTime.now();
  bool _saving = false;

  @override
  void dispose() { _nameController.dispose(); _amountController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(18, 16, 18, 28), children: [
    const AppHeader(title: 'Catatan Sampah', subtitle: 'Rekam langkah baik yang kamu lakukan.'),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.greenLight, borderRadius: BorderRadius.circular(16)), child: const Row(children: [Icon(Icons.edit_note_rounded, color: AppColors.green, size: 28), SizedBox(width: 10), Expanded(child: Text('Isi informasi dengan benar agar riwayat dan statistikmu akurat.', style: TextStyle(color: AppColors.text, height: 1.4)))])),
    const SizedBox(height: 18),
    Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Informasi sampah', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      AppTextField(controller: _nameController, label: 'Nama sampah', hint: 'Contoh: botol plastik', prefixIcon: Icons.recycling_rounded, validator: (value) => value == null || value.trim().isEmpty ? 'Nama sampah wajib diisi.' : null),
      const SizedBox(height: 13),
      DropdownButtonFormField<String>(value: _category, decoration: const InputDecoration(labelText: 'Kategori sampah', prefixIcon: Icon(Icons.category_outlined)), items: wasteCategories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(), onChanged: _saving ? null : (value) { if (value != null) setState(() => _category = value); }),
      const SizedBox(height: 13),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: AppTextField(controller: _amountController, label: 'Jumlah / berat', hint: 'Contoh: 0.5', keyboardType: const TextInputType.numberWithOptions(decimal: true), prefixIcon: Icons.scale_outlined, validator: (value) { final amount = double.tryParse((value ?? '').trim().replaceAll(',', '.')); if (value == null || value.trim().isEmpty) return 'Jumlah wajib diisi.'; if (amount == null || !amount.isFinite) return 'Masukkan angka yang valid.'; if (amount <= 0) return 'Jumlah harus lebih besar dari 0.'; return null; })), const SizedBox(width: 10), SizedBox(width: 112, child: DropdownButtonFormField<String>(value: _unit, decoration: const InputDecoration(labelText: 'Satuan'), items: const [DropdownMenuItem(value: 'kg', child: Text('Kilogram')), DropdownMenuItem(value: 'g', child: Text('Gram')), DropdownMenuItem(value: 'buah', child: Text('Buah'))], onChanged: _saving ? null : (value) { if (value != null) setState(() => _unit = value); }))]),
      const SizedBox(height: 13),
      InkWell(onTap: _saving ? null : _pickDate, borderRadius: BorderRadius.circular(14), child: InputDecorator(decoration: const InputDecoration(labelText: 'Tanggal aktivitas', prefixIcon: Icon(Icons.calendar_month_rounded)), child: Text('${_date.day.toString().padLeft(2, '0')}/${_date.month.toString().padLeft(2, '0')}/${_date.year}'))),
      const SizedBox(height: 13),
      DropdownButtonFormField<String>(value: _method, decoration: const InputDecoration(labelText: 'Metode pengelolaan', prefixIcon: Icon(Icons.loop_rounded)), items: const [DropdownMenuItem(value: 'Didaur ulang', child: Text('Didaur ulang')), DropdownMenuItem(value: 'Dikomposkan', child: Text('Dikomposkan')), DropdownMenuItem(value: 'Digunakan kembali', child: Text('Digunakan kembali')), DropdownMenuItem(value: 'Disetor ke bank sampah', child: Text('Disetor ke bank sampah')), DropdownMenuItem(value: 'Dibuang sesuai prosedur', child: Text('Dibuang sesuai prosedur')), DropdownMenuItem(value: 'Titik pengumpulan khusus', child: Text('Titik pengumpulan khusus'))], onChanged: _saving ? null : (value) { if (value != null) setState(() => _method = value); }),
      const SizedBox(height: 22),
      PrimaryButton(label: 'Simpan catatan', icon: Icons.save_rounded, loading: _saving, onPressed: _save),
    ])),
  ]));

  Future<void> _pickDate() async {
    final picked = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2020), lastDate: DateTime.now().add(const Duration(days: 365)), helpText: 'Pilih tanggal aktivitas');
    if (picked != null && mounted) setState(() => _date = picked);
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final amount = double.parse(_amountController.text.trim().replaceAll(',', '.'));
      await WasteRepository.instance.addRecord(WasteRecord(wasteName: _nameController.text.trim(), categoryId: _category, amount: amount, unit: _unit, recordDate: DateTime(_date.year, _date.month, _date.day), method: _method, createdAt: DateTime.now()));
      if (!mounted) return;
      _nameController.clear();
      _amountController.clear();
      setState(() { _date = DateTime.now(); _category = wasteCategories.first.id; _unit = 'kg'; _method = 'Didaur ulang'; });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Catatan berhasil disimpan.'), behavior: SnackBarBehavior.floating));
      widget.onSaved();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Catatan gagal disimpan. Periksa penyimpanan perangkat. Detail: $error'), behavior: SnackBarBehavior.floating, backgroundColor: Colors.red.shade700));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
