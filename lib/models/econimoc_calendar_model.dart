class ExchangeModel {
  final String name;
  final String country;
  final int trustScore;
  final double dailyVBtc;
  final String imageUrl;

  const ExchangeModel({
    required this.name,
    required this.country,
    required this.trustScore,
    required this.dailyVBtc,
    required this.imageUrl,
  });

  factory ExchangeModel.fromJson(Map<String, dynamic> json) {
    return ExchangeModel(
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      trustScore: json['trust_score'],
      dailyVBtc: json['trade_volume_24h_btc'],
      imageUrl: json['image'] ?? '',
    );
  }
}
