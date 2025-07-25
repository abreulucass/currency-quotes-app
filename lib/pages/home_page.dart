import 'package:flutter/material.dart';
import '../models/exchange_rate.dart';
import '../services/ApiService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ExchangeRate>> _exchangeRates;

  @override
  void initState() {
    super.initState();
    _exchangeRates = ApiService.fetchExchangeRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cotações em USD')),
      body: FutureBuilder<List<ExchangeRate>>(
        future: _exchangeRates,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma cotação encontrada.'));
          }

          final rates = snapshot.data!;
          return ListView.builder(
            itemCount: rates.length,
            itemBuilder: (context, index) {
              final rate = rates[index];
              return ListTile(
                title: Text(rate.currency),
                subtitle: Text('1 USD = ${rate.rate.toStringAsFixed(2)} ${rate.currency}'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: rate,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
