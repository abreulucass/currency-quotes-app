import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotações Financeiras'),
      ),
      body: const Center(
        child: Text(
          'Bem-vindo ao App de Cotações!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
