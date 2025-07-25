import 'package:cotacoes_app/models/CurrencyCode.dart';
import 'package:flutter/material.dart';
import '../services/ApiService.dart';

import '../models/ExchangeRate.dart'; // ou onde estiver seu model

class ExchangeProvider with ChangeNotifier {
  String _base = 'USD';
  List<ExchangeRate> _rates = [];
  List<CurrencyCode> _codes = [];
  bool _isLoading = false;

  String get base => _base;
  List<ExchangeRate> get rates => _rates;
  List<CurrencyCode> get codes => _codes;
  bool get isLoading => _isLoading;

  Future<void> fetchRates() async {
    _isLoading = true;
    notifyListeners();

    try {
      _rates = await ApiService.fetchExchangeRates(base: _base);
    } catch (e) {
      print('Erro: $e');
      _rates = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCodes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _codes = await ApiService.fetchCodes();
    } catch (e) {
      print('Erro: $e');
      _codes = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void setBase(String newBase) {
    _base = newBase;
    fetchRates();
  }
}