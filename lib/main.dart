import 'package:cotacoes_app/providers/ExchangeProvider.dart';
import 'package:flutter/material.dart';
import 'package:cotacoes_app/App.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  runApp(ChangeNotifierProvider(
    create: (_) {
      final provider = ExchangeProvider();
      provider.fetchRates();
      provider.fetchCodes();
      return provider;
    },
    child: const App(),
  ),);
}


