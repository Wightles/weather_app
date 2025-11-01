import 'dart:convert';
import 'dart:developer';

import 'package:weather_app/models/weather_forecast_daily.dart';
import 'package:weather_app/utilites/constants.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/utilites/location.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecast(
      {required String cityName, required bool isCity}) async {
    
    Map<String, String> parameters;

    if (isCity) {
      // Запрос по названию города
      parameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'q': cityName,
      };
    } else {
      // Запрос по геолокации
      try {
        LocationService location = LocationService();
        await location.getCurrentLocation();

        // Проверяем, что координаты получены
        if (location.latitude == null || location.longitude == null) {
          throw Exception('Location data is null');
        }

        parameters = {
          'APPID': Constants.WEATHER_APP_ID,
          'units': 'metric',
          'lat': location.latitude.toString(),
          'lon': location.longitude.toString(),
        };
      } catch (e) {
        log('Location error: $e');
        // Fallback на город по умолчанию если геолокация не работает
        parameters = {
          'APPID': Constants.WEATHER_APP_ID,
          'units': 'metric',
          'q': cityName.isEmpty ? 'London' : cityName,
        };
      }
    }

    final uri = Uri.https(
      Constants.WEATHER_BASE_URL_DOMAIN,
      Constants.WEATHER_FORECAST_PATH,
      parameters,
    );

    log('request: ${uri.toString()}');

    final response = await http.get(uri);

    log('response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('City not found');
    } else if (response.statusCode == 401) {
      throw Exception('Invalid API key');
    } else {
      throw Exception('Error response: ${response.statusCode}');
    }
  }
}