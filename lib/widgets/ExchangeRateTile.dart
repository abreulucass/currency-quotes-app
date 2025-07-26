import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/ExchangeRate.dart';

class ExchangeRateTile extends StatelessWidget {
  final ExchangeRate rate;
  final String baseCurrency;
  final VoidCallback onTap;

  const ExchangeRateTile({
    super.key,
    required this.rate,
    required this.baseCurrency,
    required this.onTap,
  });

  static final _numberFormat = NumberFormat.currency(
    symbol: '',
    decimalDigits: 2,
    locale: 'pt_BR', // ou obtenha do contexto/localização
  );

  @override
  Widget build(BuildContext context) {
    final formattedRate = rate.rate > 0
        ? _numberFormat.format(rate.rate)
        : 'N/A';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rate.currency,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      semanticsLabel: 'Código da moeda: ${rate.currency}',
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '1 $baseCurrency = $formattedRate ${rate.currency}',
                      style: const TextStyle(fontSize: 16),
                      semanticsLabel:
                      'Taxa de câmbio: 1 $baseCurrency equivale a $formattedRate ${rate.currency}',
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
