import 'package:cotacoes_app/models/CurrencyCode.dart';
import 'package:flutter/material.dart';
import '../models/PairConversion.dart';
import '../services/ApiService.dart';
import '../models/ExchangeRate.dart';

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

  Future<PairConversion?> currencyConverter(String fromCurrency, String toCurrency) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.pairConversion(
        baseCode: fromCurrency,
        targetCode: toCurrency,
      );

      return response;
    } catch (e) {
      print('Erro: $e');
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setBase(String newBase) {
    _base = newBase;
    fetchRates();
  }
}