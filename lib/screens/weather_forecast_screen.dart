import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/models/weather_forecast_daily.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/widgets/buttom_list_view.dart';
import 'package:weather_app/widgets/weather_main_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  final locationWeather;
  WeatherForecastScreen({this.locationWeather});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
  String _cityName = 'London';

  @override
  void initState() {
    super.initState();
    forecastObject = widget.locationWeather != null
        ? Future.value(widget.locationWeather)
        : WeatherApi().fetchWeatherForecast(cityName: _cityName, isCity: true);
  }

  void _refreshWeather(bool isCity) {
    setState(() {
      forecastObject = WeatherApi().fetchWeatherForecast(
        cityName: _cityName,
        isCity: isCity,
      );
    });
  }

  Color _getBackgroundColor(WeatherForecast? weather) {
    if (weather == null) return Color(0xFF47B2FF);
    
    final mainWeather = weather.list[0].weather[0].main?.toLowerCase();
    final hour = DateTime.now().hour;
    final isDay = hour > 6 && hour < 20;

    switch (mainWeather) {
      case 'clear':
        return isDay ? Color(0xFF47B2FF) : Color(0xFF0A1E3A);
      case 'clouds':
        return isDay ? Color(0xFF6C9BB4) : Color(0xFF2D3E50);
      case 'rain':
        return isDay ? Color(0xFF4A6572) : Color(0xFF1A2A3A);
      case 'snow':
        return isDay ? Color(0xFFA6C1D1) : Color(0xFF2C3E50);
      case 'thunderstorm':
        return Color(0xFF2C3E50);
      case 'drizzle':
        return Color(0xFF5D8CA8);
      default:
        return isDay ? Color(0xFF47B2FF) : Color(0xFF0A1E3A);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherForecast>(
      future: forecastObject,
      builder: (context, snapshot) {
        final backgroundColor = _getBackgroundColor(snapshot.data);
        
        return Scaffold(
          backgroundColor: backgroundColor,
          body: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  backgroundColor,
                  Color.alphaBlend(Colors.black.withOpacity(0.1), backgroundColor),
                ],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          minSize: 0,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(CupertinoIcons.location, color: Colors.white, size: 18),
                          ),
                          onPressed: () => _refreshWeather(false),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          minSize: 0,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(CupertinoIcons.search, color: Colors.white, size: 18),
                          ),
                          onPressed: () async {
                            var tappedName = await Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CityScreen(),
                              ),
                            );
                            if (tappedName != null) {
                              setState(() {
                                _cityName = tappedName;
                                _refreshWeather(true);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      backgroundColor: Colors.white,
                      color: backgroundColor,
                      onRefresh: () async => _refreshWeather(true),
                      child: snapshot.hasData
                          ? SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  WeatherMainView(snapshot: snapshot),
                                  ButtomListView(snapshot: snapshot),
                                ],
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Loading weather...',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}