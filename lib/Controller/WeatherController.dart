import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:weather/weather.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class WeatherController extends GetxController {
  String key = 'b482ce163e0b790ab946ebf4d08bb1b2';
  late WeatherFactory ws;
  RxList data = [].obs;
  AppState state = AppState.NOT_DOWNLOADED;
  double? lat, lon;
  String cityName = "";

  @override
  void onInit() {
    super.onInit();
    ws = new WeatherFactory(key);
  }

  queryForecast() async {
    /// Removes keyboard
    // FocusScope.of(context).requestFocus(FocusNode());

    state = AppState.DOWNLOADING;

    List<Weather> forecasts = await ws.fiveDayForecastByLocation(lat!, lon!);

    data.value = forecasts;
    state = AppState.FINISHED_DOWNLOADING;
  }

  queryForecastCity(cityName) async {
    /// Removes keyboard
    // FocusScope.of(context).requestFocus(FocusNode());
    print(cityName);
    state = AppState.DOWNLOADING;

    List<Weather> forecast = await ws.fiveDayForecastByCityName(cityName);

    data.value = forecast;
    state = AppState.FINISHED_DOWNLOADING;
  }

  queryWeather() async {
    /// Removes keyboard
    //  FocusScope.of(context).requestFocus(FocusNode());

    state = AppState.DOWNLOADING;

    Weather weather = await ws.currentWeatherByLocation(lat!, lon!);

    data.value = [weather];
    state = AppState.FINISHED_DOWNLOADING;
  }

  queryWeatherCity(cityName) async {
    /// Removes keyboard
    //  FocusScope.of(context).requestFocus(FocusNode());

    state = AppState.DOWNLOADING;

    Weather weather = await ws.currentWeatherByCityName(cityName);

    data.value = [weather];
    state = AppState.FINISHED_DOWNLOADING;
  }

  saveLat(String input) {
    lat = double.tryParse(input);
    print(lat);
  }

  saveLon(String input) {
    lon = double.tryParse(input);
    print(lon);
  }

  saveCity(String input) {
    cityName = input.toString();
    print('save:${cityName}');
  }
}
