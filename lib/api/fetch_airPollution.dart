import 'dart:convert';
import 'package:project/api/api_key.dart';
import 'package:project/models/airpollution_data.dart';
import 'package:http/http.dart' as http;
import '../models/airModel.dart';
import '../models/airpollution_data_components.dart';

class FetchAirPollutionAPI {
  // AirPollutionData? airpollutionData;

  // Future<AirPollutionData> processData(lat, lon) async {
  //   var response = await http.get(Uri.parse(apiURL(lat, lon)));
  //   var jsonString = jsonDecode(response.body);
  //   airpollutionData = AirPollutionData(AirPollutionDataComponents.fromJson(jsonString));

  //   return airpollutionData!;
  // }

  // String apiURL(var lat, var lon) {
  //   String url;
  //   url =
  //       "http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey";
  //   return url;
  // }

  AirModel? airpollutionData;

  Future<AirModel> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    airpollutionData = AirModel.fromJson(jsonString);

    return airpollutionData!;
  }

  String apiURL(var lat, var lon) {
    String url;
    url =
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey";
    return url;
  }
}
