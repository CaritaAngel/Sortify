import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../models/waste_category.dart';
import '../models/waste_item.dart';
import '../models/waste_record.dart';
import '../data/seed/waste_seed.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.title, this.subtitle, this.showAvatar = false});
  final String title;
  final String? subtitle;
  final bool showAvatar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.muted)),
              ],
            ],
          ),
        ),
        if (showAvatar)
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(color: AppColors.greenLight, shape: BoxShape.circle),
            child: const Icon(Icons.person_rounded, color: AppColors.green),
          ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.actionLabel, this.onAction});
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Row(children: [Expanded(child: Text(title, style: Theme.of(context).textTheme.titleLarge)), if (actionLabel != null) TextButton(onPressed: onAction, child: Text(actionLabel!))]);
}

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.value, required this.label, required this.icon, this.tint = AppColors.greenLight});
  final String value;
  final String label;
  final IconData icon;
  final Color tint;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: AppColors.border)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 32, height: 32, decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(10)), child: Icon(icon, size: 18, color: AppColors.green)), const SizedBox(height: 10), Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20)), const SizedBox(height: 2), Text(label, style: Theme.of(context).textTheme.bodySmall)]));
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category, required this.onTap, this.compact = false});
  final WasteCategory category;
  final VoidCallback onTap;
  final bool compact;
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18), child: Container(padding: EdgeInsets.all(compact ? 11 : 14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: compact ? 38 : 44, height: compact ? 38 : 44, decoration: BoxDecoration(color: category.color, borderRadius: BorderRadius.circular(13)), child: Icon(category.icon, color: AppColors.green, size: compact ? 21 : 24)), const SizedBox(height: 9), Text(category.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: compact ? 13 : 14)), const SizedBox(height: 3), Text(category.description, maxLines: compact ? 2 : 3, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall)])));
}

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.controller, required this.onChanged, this.hint = 'Cari jenis sampah...'});
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hint;
  @override
  Widget build(BuildContext context) => TextField(controller: controller, onChanged: onChanged, textInputAction: TextInputAction.search, decoration: InputDecoration(hintText: hint, prefixIcon: const Icon(Icons.search_rounded), suffixIcon: controller.text.isEmpty ? null : IconButton(onPressed: () { controller.clear(); onChanged(''); }, icon: const Icon(Icons.close_rounded))));
}

class WasteItemCard extends StatelessWidget {
  const WasteItemCard({super.key, required this.item, required this.onTap});
  final WasteItem item;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final category = wasteCategories.firstWhere((c) => c.id == item.categoryId);
    return Card(child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18), child: Padding(padding: const EdgeInsets.all(13), child: Row(children: [Container(width: 45, height: 45, decoration: BoxDecoration(color: category.color, borderRadius: BorderRadius.circular(13)), child: Icon(item.icon, color: AppColors.green)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.name, style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 3), Text(category.name, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.green)), const SizedBox(height: 3), Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall)])), const Icon(Icons.chevron_right_rounded, color: AppColors.muted)]))));
  }
}

class GuideStepCard extends StatelessWidget {
  const GuideStepCard({super.key, required this.number, required this.title, required this.description, required this.icon, required this.checked, required this.onChanged});
  final int number;
  final String title;
  final String description;
  final IconData icon;
  final bool checked;
  final ValueChanged<bool?> onChanged;
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 38, height: 38, decoration: const BoxDecoration(color: AppColors.greenLight, shape: BoxShape.circle), child: Icon(icon, color: AppColors.green, size: 20)), const SizedBox(width: 11), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('$number. $title', style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 4), Text(description, style: Theme.of(context).textTheme.bodySmall)])), Checkbox(value: checked, onChanged: onChanged, activeColor: AppColors.green)])));
}

class AppTextField extends StatelessWidget {
  const AppTextField({super.key, required this.controller, required this.label, this.hint, this.keyboardType, this.validator, this.prefixIcon});
  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  @override
  Widget build(BuildContext context) => TextFormField(controller: controller, keyboardType: keyboardType, validator: validator, decoration: InputDecoration(labelText: label, hintText: hint, prefixIcon: prefixIcon == null ? null : Icon(prefixIcon)));
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, required this.onPressed, this.icon, this.loading = false});
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool loading;
  @override
  Widget build(BuildContext context) => SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: loading ? null : onPressed, icon: loading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : Icon(icon ?? Icons.check_rounded), label: Text(label)));
}

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key, required this.record, required this.onTap});
  final WasteRecord record;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final category = wasteCategories.firstWhere((c) => c.id == record.categoryId, orElse: () => wasteCategories.last);
    final date = '${record.recordDate.day.toString().padLeft(2, '0')}/${record.recordDate.month.toString().padLeft(2, '0')}/${record.recordDate.year}';
    return Card(child: ListTile(onTap: onTap, contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4), leading: Container(width: 42, height: 42, decoration: BoxDecoration(color: category.color, borderRadius: BorderRadius.circular(12)), child: Icon(category.icon, color: AppColors.green)), title: Text(record.wasteName, style: Theme.of(context).textTheme.titleMedium), subtitle: Text('$date · ${record.method}', maxLines: 1, overflow: TextOverflow.ellipsis), trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [Text(_amount(record), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.green)), Text(category.name, style: Theme.of(context).textTheme.bodySmall)])));
  }
  String _amount(WasteRecord r) => '${r.amount == r.amount.roundToDouble() ? r.amount.toInt() : r.amount} ${r.unit}';
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.title, required this.message, this.icon = Icons.inbox_outlined, this.actionLabel, this.onAction});
  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Center(child: Padding(padding: const EdgeInsets.all(28), child: Column(mainAxisSize: MainAxisSize.min, children: [Container(width: 68, height: 68, decoration: const BoxDecoration(color: AppColors.greenLight, shape: BoxShape.circle), child: Icon(icon, size: 32, color: AppColors.green)), const SizedBox(height: 14), Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 6), Text(message, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.muted)), if (actionLabel != null) ...[const SizedBox(height: 16), OutlinedButton(onPressed: onAction, child: Text(actionLabel!))]])));
}
