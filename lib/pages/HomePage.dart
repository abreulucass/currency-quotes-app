import 'package:cotacoes_app/widgets/ExchangeRateTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ExchangeRate.dart';
import '../providers/ExchangeProvider.dart';
import '../services/ApiService.dart';
import '../widgets/CurrencySelectorBottomSheet.dart';

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
              final selected = await showModalBottomSheet<String>(
                context: context,
                isScrollControlled: true,
                builder: (context) => const CurrencySelectorBottomSheet(),
              );

              if (selected != null) {
                Provider.of<ExchangeProvider>(context, listen: false)
                    .setBase(selected);
              }
            },
            child: const Text('Selecionar moeda'),
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
