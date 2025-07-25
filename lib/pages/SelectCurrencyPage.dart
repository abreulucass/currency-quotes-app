import 'package:cotacoes_app/widgets/CurrencyTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/CurrencyCode.dart';
import '../providers/ExchangeProvider.dart';
import '../services/ApiService.dart';

class SelectCurrencyPage extends StatelessWidget {
  const SelectCurrencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selecionar moeda')),
      body: Consumer<ExchangeProvider>(
        builder: (context, provider, child) {
          final codes = provider.codes;

          return ListView.builder(
            itemCount: codes.length,
            itemBuilder: (context, index) {
              final currency = codes[index];
              return CurrencyTile(currency: currency);
            },
          );
        },
      ),
    );
  }
}
