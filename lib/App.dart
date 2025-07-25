
import 'package:cotacoes_app/pages/DetailsPage.dart';
import 'package:cotacoes_app/pages/HomePage.dart';
import 'package:cotacoes_app/pages/SelectCurrencyPage.dart';
import 'package:flutter/material.dart';
import 'models/ExchangeRate.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cotações Financeiras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(),
        //'/details': (context) => const DetailsPage(rate: rate, code: code)
        '/select_base': (context) => const SelectCurrencyPage(),
      },

    );
  }
}