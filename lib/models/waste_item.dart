import 'package:flutter/material.dart';

class WasteItem {
  const WasteItem({required this.id, required this.name, required this.categoryId, required this.description, required this.handling, required this.icon});
  final String id;
  final String name;
  final String categoryId;
  final String description;
  final String handling;
  final IconData icon;
}
