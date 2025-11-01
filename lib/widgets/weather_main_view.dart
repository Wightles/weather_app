import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_daily.dart';
import 'package:weather_app/utilites/forecast_util.dart';

class WeatherMainView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const WeatherMainView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var city = snapshot.data?.city!.name;
    var country = snapshot.data?.city!.country;
    var formattedDate = DateTime.fromMillisecondsSinceEpoch(forecastList![0].dt! * 1000);
    var icon = forecastList[0].getIconUrl();
    var temp = forecastList[0].temp!.day!.toStringAsFixed(0);
    var description = forecastList[0].weather[0].description;
    var pressure = forecastList[0].pressure! * 0.750062;
    var humidity = forecastList[0].humidity;
    var wind = forecastList[0].speed;
    var feelsLike = forecastList[0].feelsLike!.day!.toStringAsFixed(0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            '$city',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.1,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(2, 2),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            country ?? '',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.9),
              shadows: [
                Shadow(
                  blurRadius: 6,
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Text(
            Util.getFormattedDate(formattedDate),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.8),
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Image.network(
              icon,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 26),
            child: Text(
              '$temp°',
              style: TextStyle(
                fontSize: 84,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.0,
                shadows: [
                  Shadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(3, 3),
                  ),
                  Shadow(
                    blurRadius: 30,
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 6),
          Text(
            description?.toUpperCase() ?? '',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white.withOpacity(0.95),
              letterSpacing: 1.0,
              shadows: [
                Shadow(
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Feels like $feelsLike°',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8),
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherDetail('PRESSURE', '${pressure.round()}', 'mm Hg', CupertinoIcons.chart_bar),
                _buildWeatherDetail('HUMIDITY', '$humidity', '%', CupertinoIcons.drop),
                _buildWeatherDetail('WIND', '${wind!.toInt()}', 'm/s', CupertinoIcons.wind),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(String title, String value, String unit, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black.withOpacity(0.2),
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 24,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 6,
                color: Colors.black.withOpacity(0.3),
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.8),
            letterSpacing: 0.5,
            shadows: [
              Shadow(
                blurRadius: 4,
                color: Colors.black.withOpacity(0.2),
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        Text(
          unit,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.7),
            shadows: [
              Shadow(
                blurRadius: 4,
                color: Colors.black.withOpacity(0.2),
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}