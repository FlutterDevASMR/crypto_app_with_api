class CryptoModel {
  int? rank;
  String? name;
  String? symbol;
  double? priceUsd;
  double? changePercent24Hr;

  CryptoModel({
    this.rank,
    this.name,
    this.symbol,
    this.priceUsd,
    this.changePercent24Hr,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      rank: int.parse(json['rank']),
      name: json['name'],
      symbol: json['symbol'],
      priceUsd: double.parse(json['priceUsd']),
      changePercent24Hr: double.parse(json['changePercent24Hr']),
    );
  }
}
