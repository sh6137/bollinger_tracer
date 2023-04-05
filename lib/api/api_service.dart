import 'dart:convert';

import 'package:bollinger_tracer/model/upbit_ticker_model.dart';
import 'package:http/http.dart';

class ApiService {
  static const String baseUrl = "api.upbit.com";

  static Future<List<UpbitTickerModel>> getTicker(
      String unit, String market, String coin, String count) async {

    List<UpbitTickerModel> upbitTickerInstances = [];
    String today = "/v1/candles/minutes/$unit";
    var url = Uri.https(baseUrl, today, {'market': '$market-$coin','count':count});
    final response = await get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        upbitTickerInstances.add(UpbitTickerModel.fromJson(webtoon));
      }
      return upbitTickerInstances;
    }
    throw Error();
  }
}
