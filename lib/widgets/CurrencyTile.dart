import 'package:flutter/material.dart';
import '../models/CurrencyCode.dart';

class CurrencyTile extends StatelessWidget {
  final CurrencyCode currency;

  const CurrencyTile({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(
          currency.code,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          currency.name,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pop(context, currency.code);
        },
      ),
    );
  }
}
