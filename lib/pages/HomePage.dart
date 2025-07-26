import 'package:cotacoes_app/widgets/ExchangeRateTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ExchangeProvider.dart';
import '../widgets/CurrencySelectorBottomSheet.dart';
import 'DetailsPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExchangeProvider>(context);
    final rates = provider.rates;
    final baseCurrency = provider.base;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cotações'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Atualizar',
            onPressed: () {
              provider.fetchRates();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: const Icon(Icons.monetization_on),
                title: Text('Moeda base: $baseCurrency'),
                trailing: FilledButton.icon(
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text('Trocar'),
                  onPressed: () async {
                    final selected = await showModalBottomSheet<String>(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (context) => const CurrencySelectorBottomSheet(),
                    );

                    if (selected != null) {
                      provider.setBase(selected);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (provider.isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else
              Expanded(
                child: ListView.separated(
                  itemCount: rates.length,
                  separatorBuilder: (context, index) => const Divider(height: 0),
                  itemBuilder: (context, index) {
                    final rate = rates[index];
                    return ExchangeRateTile(
                      rate: rate,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(rate: rate),
                          ),
                        );
                      },
                      baseCurrency: provider.base,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
