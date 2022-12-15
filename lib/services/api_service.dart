import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url); // will await 'future' to finish
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id"); // 1. created the url
    final response = await http.get(url); // 2. send a request to a url
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response
          .body); //3. take the response body which is a string and turn it into json
      WebtoonDetailModel.fromJson(webtoon); // -> json
      return WebtoonDetailModel.fromJson(
          webtoon); // send the json to the constructor of the webtoon detail model
    }
    throw Error();
  }
}
