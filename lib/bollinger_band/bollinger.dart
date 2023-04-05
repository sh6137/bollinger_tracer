import 'dart:math';

import '../model/upbit_ticker_model.dart';

class BollingerBands {
  List<double> smaList;
  List<double> upperBandList;
  List<double> lowerBandList;

  BollingerBands(this.smaList, this.upperBandList, this.lowerBandList);
}

Future<BollingerBands> calculateBollingerBands(
    Future<List<UpbitTickerModel>> tickers) async {
  List<UpbitTickerModel> price = await tickers;
  List<double> smaList = List.filled(price.length, 0.0);
  List<double> upperBandList = List.filled(price.length, 0.0);
  List<double> lowerBandList = List.filled(price.length, 0.0);

  int period = 20;
  double stdDev = 2;

  for (int i = period - 1; i < price.length; i++) {
    double sma = 0;
    for (int j = i - period + 1; j <= i; j++) {
      sma += price[j].tradePrice;
    }
    sma /= period;
    smaList[i] = sma;

    double stdDeviation = 0;
    for (int j = i - period + 1; j <= i; j++) {
      stdDeviation += (price[j].tradePrice - sma) * (price[j].tradePrice - sma);
    }
    stdDeviation = stdDeviation / period;
    stdDeviation = sqrt(stdDeviation);

    upperBandList[i] = sma + stdDev * stdDeviation;
    lowerBandList[i] = sma - stdDev * stdDeviation;
  }

  return BollingerBands(smaList, upperBandList, lowerBandList);
}
