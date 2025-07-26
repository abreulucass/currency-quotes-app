import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ExchangeProvider.dart';
import '../widgets/CurrencySelectorBottomSheet.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  String? _fromCurrency;
  String? _toCurrency;
  double? _convertedValue;
  final TextEditingController _amountController = TextEditingController();

  Future<void> _selectCurrency(bool isBase) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (_) => const CurrencySelectorBottomSheet(),
    );

    if (selected != null) {
      setState(() {
        if (isBase) {
          _fromCurrency = selected;
        } else {
          _toCurrency = selected;
        }
      });
    }
  }

  void _convert() async {
    final provider = Provider.of<ExchangeProvider>(context, listen: false);

    if (_fromCurrency == null || _toCurrency == null || _amountController.text.isEmpty) return;

    final amount = double.tryParse(_amountController.text);
    if (amount == null) return;

    final pairConversion = await provider.currencyConverter(_fromCurrency!, _toCurrency!);

    if(pairConversion == null) return;

    final converted = amount * pairConversion.rate;

    setState(() {
      _convertedValue = converted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversor de Moedas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _selectCurrency(true),
              child: Text(_fromCurrency == null ? 'Selecionar moeda base' : 'Base: $_fromCurrency'),
            ),
            ElevatedButton(
              onPressed: () => _selectCurrency(false),
              child: Text(_toCurrency == null ? 'Selecionar moeda destino' : 'Destino: $_toCurrency'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Converter'),
            ),
            const SizedBox(height: 20),
            if (_convertedValue != null)
              Text(
                'Resultado: ${_convertedValue!.toStringAsFixed(2)} $_toCurrency',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
