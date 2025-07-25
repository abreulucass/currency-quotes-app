import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const CurrencyQuotesApp());
}

class CurrencyQuotesApp extends StatelessWidget {
  const CurrencyQuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cotações Financeiras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
