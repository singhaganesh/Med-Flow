import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme.dart';
import 'core/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MediFlowApp()));
}

class MediFlowApp extends StatelessWidget {
  const MediFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MediFlow',
      theme: AppTheme.light,
      routerConfig: routerProvider,
      debugShowCheckedModeBanner: false,
    );
  }
}
