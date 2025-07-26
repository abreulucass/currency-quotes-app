import 'dart:convert';
import 'package:cotacoes_app/config/AppConfig.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:cotacoes_app/services/ApiService.dart';
import 'package:cotacoes_app/models/ExchangeRate.dart';

import 'ApiService_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('ApiService.fetchExchangeRates', () {
    test('Retorna uma lista de ExchangeRate quando a resposta é 200', () async {
      final client = MockClient();

      const mockResponse = {
        "time_last_update_utc": "Mon, 01 Jan 2025 00:00:01 +0000",
        "conversion_rates": {
          "USD": 5.15,
          "EUR": 5.50
        }
      };

      when(client.get(Uri.parse('https://v6.exchangerate-api.com/v6/${AppConfig.apiKey}/latest/BRL')))
          .thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

      final rates = await ApiService.fetchExchangeRates(client: client);

      expect(rates.length, 2);
      expect(rates[0].date, "Mon, 01 Jan 2025 00:00:01 +0000");
      expect(rates[0].currency, 'USD');
      expect(rates[0].rate, 5.15);
      expect(rates[1].currency, 'EUR');
      expect(rates[1].rate, 5.50);
    });

    test('Lança exceção quando statusCode != 200', () async {
      final client = MockClient();

      when(client.get(any)).thenAnswer((_) async => http.Response('Erro', 400));

      expect(() => ApiService.fetchExchangeRates(client: client), throwsA(isA<Exception>()));
    });
  });

  group('ApiService.fetchCodes', () {
    test('Retorna uma lista de CurrencyCode quando a resposta é 200', () async {
      final client = MockClient();
      final apiKey = AppConfig.apiKey;

      final mockResponse = {
        "supported_codes": [
          ["USD", "United States Dollar"],
          ["EUR", "Euro"]
        ]
      };

      when(client.get(Uri.parse('https://v6.exchangerate-api.com/v6/$apiKey/codes')))
          .thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

      final codes = await ApiService.fetchCodes(client: client);

      expect(codes.length, 2);
      expect(codes[0].code, 'USD');
      expect(codes[0].name, 'United States Dollar');
    });

    test('Lança exceção quando statusCode != 200', () async {
      final client = MockClient();

      when(client.get(any)).thenAnswer((_) async => http.Response('Erro', 500));

      expect(() => ApiService.fetchCodes(client: client), throwsException);
    });
  });

  group('ApiService.pairConversion', () {
    test('Retorna PairConversion quando a resposta é 200', () async {
      final client = MockClient();
      final apiKey = AppConfig.apiKey;

      final mockResponse = {
        "base_code": "USD",
        "target_code": "BRL",
        "conversion_rate": 5.25
      };

      when(client.get(Uri.parse('https://v6.exchangerate-api.com/v6/$apiKey/pair/USD/BRL')))
          .thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

      final pair = await ApiService.pairConversion(
        baseCode: 'USD',
        targetCode: 'BRL',
        client: client,
      );

      expect(pair.baseCode, 'USD');
      expect(pair.targetCode, 'BRL');
      expect(pair.rate, 5.25);
    });

    test('Lança exceção quando statusCode != 200', () async {
      final client = MockClient();

      when(client.get(any)).thenAnswer((_) async => http.Response('Erro', 404));

      expect(() => ApiService.pairConversion(
        baseCode: 'USD',
        targetCode: 'BRL',
        client: client,
      ), throwsException);
    });
  });
}
