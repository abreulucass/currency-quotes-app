import 'package:flutter/material.dart';

import '../models/CurrencyCode.dart';

class CurrencyTile extends StatelessWidget {
  final CurrencyCode currency;

  const CurrencyTile({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(currency.code),
      subtitle: Text(currency.name),
      onTap: () {
        Navigator.pop(context, currency.code);
      },
    );
  }
}
