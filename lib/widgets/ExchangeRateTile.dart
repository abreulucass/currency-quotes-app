import 'package:flutter/material.dart';
import '../models/ExchangeRate.dart';

class ExchangeRateTile extends StatelessWidget {
  final ExchangeRate rate;
  final String baseCurrency;
  final VoidCallback onTap;

  const ExchangeRateTile({super.key, required this.rate, required this.baseCurrency, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          rate.currency,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '1 ${baseCurrency} = ${rate.rate.toStringAsFixed(2)} ${rate.currency}',
          style: const TextStyle(fontSize: 16),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}