import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/models/weather_forecast_daily.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/widgets/buttom_list_view.dart';
import 'package:weather_app/widgets/city_view.dart';
import 'package:weather_app/widgets/detail_view.dart';
import 'package:weather_app/widgets/temp_view.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4DB6AC),
        elevation: 0,
        title: Text(
          'Weather Forecast',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(CupertinoIcons.location_solid, color: Colors.white),
          onPressed: () => _refreshWeather(false),
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.search, color: Colors.white),
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
      body: RefreshIndicator(
        backgroundColor: const Color(0xFF4DB6AC),
        color: Colors.white,
        onRefresh: () async => _refreshWeather(true),
        child: FutureBuilder<WeatherForecast>(
          future: forecastObject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    CityView(snapshot: snapshot),
                    SizedBox(height: 30),
                    TempView(snapshot: snapshot),
                    SizedBox(height: 30),
                    DetailView(snapshot: snapshot),
                    SizedBox(height: 30),
                    ButtomListView(snapshot: snapshot),
                    SizedBox(height: 20),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.exclamationmark_triangle,
                      size: 64,
                      color: const Color(0xFF4DB6AC),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Failed to load weather data',
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color(0xFF4DB6AC),
                      ),
                    ),
                    SizedBox(height: 20),
                    CupertinoButton(
                      color: const Color(0xFF4DB6AC),
                      child: Text('Retry', style: TextStyle(color: Colors.white)),
                      onPressed: () => _refreshWeather(true),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4DB6AC)),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Loading weather...',
                      style: TextStyle(
                        color: const Color(0xFF4DB6AC),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}