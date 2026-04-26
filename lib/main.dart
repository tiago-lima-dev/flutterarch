import 'package:flutter/material.dart';
import 'package:flutterarch/features/financial/financial_module.dart';

void main() {
  // Inicializar dependências da feature Financial
  FinancialModule.setup();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterArch - Financeiro',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[850],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: Colors.grey[800],
          elevation: 0,
        ),
      ),
      home: FinancialModule.getFinancialPage(),
    );
  }
}

