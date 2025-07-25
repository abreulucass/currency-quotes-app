import 'package:cotacoes_app/widgets/ExchangeRateTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ExchangeRate.dart';
import '../providers/ExchangeProvider.dart';
import '../services/ApiService.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExchangeProvider>(context);
    final rates = provider.rates;
    final baseCurrency = provider.base;

    return Scaffold(
      appBar: AppBar(title: Text('Cotações em ${baseCurrency}')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final selected = await Navigator.pushNamed(
                  context, '/select_base');
              if (selected != null && selected is String) {
                provider.setBase(selected);
              }
            },
            child: Text('Base atual: ${baseCurrency}'),
          ),
          if (provider.isLoading)
            const CircularProgressIndicator()
          else
            Expanded(
              child: ListView.builder(
                itemCount: rates.length,
                itemBuilder: (context, index) {
                  final rate = rates[index];
                  return ExchangeRateTile(
                    rate: rate,
                    onTap: () {
                      Navigator.pushNamed(context, '/details', arguments: rate);
                    }, baseCurrency: provider.base,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
