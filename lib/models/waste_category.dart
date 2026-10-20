import 'package:flutter/material.dart';

class WasteCategory {
  const WasteCategory({required this.id, required this.name, required this.description, required this.examples, required this.howTo, required this.icon, required this.color});
  final String id;
  final String name;
  final String description;
  final List<String> examples;
  final String howTo;
  final IconData icon;
  final Color color;
}
