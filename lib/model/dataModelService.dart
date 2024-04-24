import 'dart:convert';
import 'package:project/model/weatherDataModel.dart';


WeatherDatas weatherDatasFromJson(String str) =>
    WeatherDatas.fromJson(json.decode(str));

String weatherDatasToJson(WeatherDatas data) => json.encode(data.toJson());
