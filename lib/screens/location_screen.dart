import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/screens/weather_forecast_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  void getLocationData() async {
    try {
      var weatherInfo = await WeatherApi().fetchWeatherForecast(
        cityName: 'London',
        isCity: false, // Используем геолокацию по умолчанию
      );

      if (weatherInfo == null) {
        print('WeatherInfo was null: $weatherInfo');
        return;
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WeatherForecastScreen(locationWeather: weatherInfo);
      }));
    } catch (e) {
      print('Error: $e');
      // Fallback на город по умолчанию
      var weatherInfo = await WeatherApi().fetchWeatherForecast(
        cityName: 'London',
        isCity: true,
      );
      
      if (weatherInfo != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WeatherForecastScreen(locationWeather: weatherInfo);
        }));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(radius: 20),
            SizedBox(height: 20),
            Text(
              'Getting your location...',
              style: TextStyle(
                fontSize: 18,
                color: CupertinoColors.secondaryLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}