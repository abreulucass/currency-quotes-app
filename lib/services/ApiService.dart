import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exchange_rate.dart';
import '../config/AppConfig.dart';

final String baseUrl = AppConfig.apiBaseUrl;
final String apiKey = AppConfig.apiKey;

class ApiService {
  static final String _url = '$baseUrl$apiKey/latest/USD';

  static Future<List<ExchangeRate>> fetchExchangeRates() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final Map<String, dynamic> conversionRates = jsonData['conversion_rates'];

      return conversionRates.entries.map((entry) {
        return ExchangeRate(
          currency: entry.key,
          rate: (entry.value as num).toDouble(),
        );
      }).toList();
    } else {
      throw Exception('Erro ao carregar cotações');
    }
  }
}