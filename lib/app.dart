import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'navigation/app_shell.dart';

class SortifyApp extends StatelessWidget {
  const SortifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sortify',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AppShell(),
    );
  }
}
