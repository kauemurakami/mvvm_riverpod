import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamWeatherProvider = StreamProvider.autoDispose<String>((ref) async* {
  ref.keepAlive();
  // final weather = await WeatherReopsitory.fetchWeather();
  // yield weather;
  //changing in realtime
  while (true) {
    final weather = await WeatherReopsitory.fetchWeather();
    yield weather;
  }
});

class WeatherReopsitory {
  static final Random _random = Random();

  static Future<String> fetchWeather() async {
    await Future.delayed(const Duration(seconds: 2));
    final weatherStates = ["Sunny", "Rainy", "Cloudy", "Snowy", "Windy"];
    final temperature = 15 + _random.nextInt(15);
    final weather = weatherStates[_random.nextInt(weatherStates.length - 1)];
    return "$weather, ${temperature}c";
  }
}
