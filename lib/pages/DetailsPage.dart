import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ExchangeRate.dart';
import 'package:intl/intl.dart';
import '../providers/ExchangeProvider.dart';

class DetailsPage extends StatelessWidget {
  final ExchangeRate rate;

  const DetailsPage({super.key, required this.rate});

  String formatData(String rawDate) {
    final inputFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss Z", 'en_US');
    final dateTime = inputFormat.parse(rawDate);
    final outputFormat = DateFormat("dd/MM/yyyy 'às' HH:mm", 'pt_BR');
    return outputFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExchangeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Detalhes: ${rate.currency}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Moeda: ${rate.currency}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Taxa: 1 ${provider.base} = ${rate.rate.toStringAsFixed(2)} ${rate.currency}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Data da Cotação: ${formatData(rate.date)}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
