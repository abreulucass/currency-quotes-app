import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/CurrencyCode.dart';
import '../providers/ExchangeProvider.dart';
import 'CurrencyTile.dart';

class CurrencySelectorBottomSheet extends StatefulWidget {
  const CurrencySelectorBottomSheet({super.key});

  @override
  State<CurrencySelectorBottomSheet> createState() => _CurrencySelectorBottomSheetState();
}

class _CurrencySelectorBottomSheetState extends State<CurrencySelectorBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<CurrencyCode> _filtered = [];

  @override
  void initState() {
    super.initState();
    final codes = Provider.of<ExchangeProvider>(context, listen: false).codes;
    _filtered = codes;

    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      setState(() {
        _filtered = codes
            .where((c) =>
            c.code.toLowerCase().contains(query) ||
            c.name.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Selecione uma moeda', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Buscar moeda...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(child: Text('Nenhuma moeda encontrada.'))
                : ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final currency = _filtered[index];
                return CurrencyTile(currency: currency);
              },
            ),
          ),
        ],
      ),
    );
  }
}
