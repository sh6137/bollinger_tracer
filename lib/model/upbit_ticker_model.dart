class UpbitTickerModel {
  final dynamic market,
      candleDateTimeUtc,
      candleDateTimeKst,
      openingPrice,
      highPrice,
      lowPrice,
      tradePrice,
      timestamp,
      candleAccTradePrice,
      candleAccTradeVolume,
      unit;

  UpbitTickerModel.fromJson(Map<String, dynamic> json)
      : market = json['market'],
        candleDateTimeUtc = json['candle_date_time_utc'],
        candleDateTimeKst = json['candle_date_time_kst'],
        openingPrice = json['opening_price'],
        highPrice = json['high_price'],
        lowPrice = json['low_price'],
        tradePrice = json['trade_price'],
        timestamp = json['timestamp'],
        candleAccTradePrice = json['candle_acc_trade_price'],
        candleAccTradeVolume = json['candle_acc_trade_volume'],
        unit = json['unit'];
}
