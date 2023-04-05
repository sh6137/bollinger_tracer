import 'dart:math';

import '../model/upbit_ticker_model.dart';

class BollingerBands {

  static Future<List<num>> calculateBollingerBands(Future<List<UpbitTickerModel>> tickers) async {
    List<num> middleBand = [];
    List<num> upperBand = [];
    List<num> lowerBand = [];
    int period = 20; // 이동평균선 기간
    double numStdDev = 2; // 표준편차 계수
    final List<UpbitTickerModel> data = await tickers; // tickers 변수가 반환하는 Future 데이터를 받아옵니다.

    // 이동평균선 계산
    for (int i = period - 1; i < data.length; i++) {
      num sum = 0;
      for (int j = i - period + 1; j <= i; j++) {
        sum +=  data[j].tradePrice as num;
      }
      middleBand.add(sum / period);
    }

    // 볼린저 밴드 상단선과 하단선 계산
    for (int i = period - 1; i < data.length; i++) {
      double sumOfSquaredDeviations = 0;
      for (int j = i - period + 1; j <= i; j++) {
        num deviation = data[j].tradePrice as num; - middleBand[i - period + 1];
        sumOfSquaredDeviations += pow(deviation, 2);
      }
      double stdDev = sqrt(sumOfSquaredDeviations / period);
      upperBand.add(middleBand[i - period + 1] + numStdDev * stdDev);
      lowerBand.add(middleBand[i - period + 1] - numStdDev * stdDev);
    }

    // 이동평균선, 상단선, 하단선을 하나의 리스트로 반환
    return [...middleBand, ...upperBand, ...lowerBand];
  }
}
