import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/ExchangeRate.dart';
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
    final numberFormat = NumberFormat.currency(
      symbol: '',
      decimalDigits: 2,
      locale: 'pt_BR',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da ${rate.currency}'),
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow(
                  icon: Icons.monetization_on_outlined,
                  label: 'Moeda',
                  value: rate.currency,
                  context: context,
                ),
                const SizedBox(height: 16),
                _infoRow(
                  icon: Icons.swap_horiz,
                  label: 'Taxa',
                  value:
                  '1 ${provider.base} = ${numberFormat.format(rate.rate)} ${rate.currency}',
                  context: context,
                ),
                const SizedBox(height: 16),
                _infoRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'Data da Cotação',
                  value: formatData(rate.date),
                  context: context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
    required BuildContext context,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(value, style: textTheme.bodyLarge),
            ],
          ),
        )
      ],
    );
  }
}
