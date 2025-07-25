class CurrencyCode {
  final String code;
  final String name;

  CurrencyCode({required this.code, required this.name});

  factory CurrencyCode.fromJson(List<dynamic> json) {
    return CurrencyCode(
      code: json[0],
      name: json[1],
    );
  }
}