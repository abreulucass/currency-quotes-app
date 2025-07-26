import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/CurrencyCode.dart';
import '../models/ExchangeRate.dart';
import '../models/PairConversion.dart';
import '../config/AppConfig.dart';

final String baseUrl = AppConfig.apiBaseUrl;
final String apiKey = AppConfig.apiKey;

class ApiService {
  static final String _urlExchanges = '$baseUrl$apiKey/latest/';
  static final String _urlCurrency = '$baseUrl$apiKey/codes';
  static final String _urlPairConversion = '$baseUrl$apiKey/pair/';

  static Future<List<ExchangeRate>> fetchExchangeRates({String base = 'BRL'}) async {
    final response = await http.get(Uri.parse('$_urlExchanges/$base'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final dateOfLastUpdate = jsonData['time_last_update_utc'];
      final Map<String, dynamic> conversionRates = jsonData['conversion_rates'];

      return conversionRates.entries.map((entry) {
        return ExchangeRate(
          currency: entry.key,
          rate: (entry.value as num).toDouble(),
          date: dateOfLastUpdate
        );
      }).toList();
    } else {
      throw Exception('Erro ao carregar cotações');
    }
  }

  static Future<List<CurrencyCode>> fetchCodes() async {
    final response = await http.get(Uri.parse(_urlCurrency));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List codes = data['supported_codes'];

      return codes.map((code) => CurrencyCode.fromJson(code)).toList();
    } else {
      throw Exception('Erro ao buscar moedas disponíveis');
    }
  }

  static Future<PairConversion> pairConversion({required String baseCode, required String targetCode}) async {
    final response = await http.get(Uri.parse('$_urlPairConversion$baseCode/$targetCode'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final baseCode = data['base_code'];
      final targetCode = data['target_code'];
      final rate = data['conversion_rate'];

      return PairConversion(baseCode: baseCode, targetCode: targetCode, rate: rate);
    } else {
      throw Exception('Erro ao convertar as moedas');
    }
  }


}