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
  final FocusNode _amountFocusNode = FocusNode();

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
      _amountFocusNode.requestFocus();
    }
  }

  void _swapCurrencies() {
    if (_fromCurrency == null || _toCurrency == null) return;

    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      _convertedValue = null;
    });
  }

  Future<void> _convert() async {
    final provider = Provider.of<ExchangeProvider>(context, listen: false);

    final amountText = _amountController.text.trim();
    if (_fromCurrency == null || _toCurrency == null || amountText.isEmpty) {
      _showError('Por favor, selecione as moedas e informe o valor.');
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      _showError('Informe um valor numérico positivo.');
      return;
    }

    setState(() {
      _convertedValue = null;
    });

    final pairConversion = await provider.currencyConverter(_fromCurrency!, _toCurrency!);

    if (pairConversion == null) {
      _showError('Erro ao buscar taxa de conversão.');
      return;
    }

    final converted = amount * pairConversion.rate;

    setState(() {
      _convertedValue = converted;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<ExchangeProvider>(context);
    final isLoading = provider.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Moedas'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonalIcon(
                    icon: const Icon(Icons.attach_money_outlined),
                    label: Text(_fromCurrency ?? 'Selecionar moeda base'),
                    onPressed: isLoading ? null : () => _selectCurrency(true),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  iconSize: 30,
                  color: theme.colorScheme.primary,
                  tooltip: 'Trocar moedas',
                  icon: const Icon(Icons.swap_horiz),
                  onPressed: isLoading ? null : _swapCurrencies,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.tonalIcon(
                    icon: const Icon(Icons.currency_exchange_outlined),
                    label: Text(_toCurrency ?? 'Selecionar moeda destino'),
                    onPressed: isLoading ? null : () => _selectCurrency(false),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _amountController,
              focusNode: _amountFocusNode,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(),
              ),
              enabled: !isLoading,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: isLoading ? null : _convert,
              icon: isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
                  : const Icon(Icons.arrow_forward),
              label: Text(isLoading ? 'Convertendo...' : 'Converter'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            const SizedBox(height: 30),
            if (_convertedValue != null)
              Text(
                'Resultado: ${_convertedValue!.toStringAsFixed(2)} $_toCurrency',
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              )
            else if (!isLoading)
              Text(
                'Informe os dados e pressione "Converter"',
                style: theme.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
              ),
          ],
        ),
      ),
    );
  }
}
