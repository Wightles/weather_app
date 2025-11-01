import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_daily.dart';
import 'package:weather_app/utilites/forecast_util.dart';

class DetailView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const DetailView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var pressure = forecastList![0].pressure! * 0.750062;
    var humidity = forecastList[0].humidity;
    var wind = forecastList[0].speed;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4DB6AC).withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Color(0xFF4DB6AC).withOpacity(0.1),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDetailItem(
            CupertinoIcons.chart_bar,
            'Pressure',
            '${pressure.round()}',
            'mm Hg',
          ),
          _buildDetailItem(
            CupertinoIcons.drop,
            'Humidity',
            '$humidity',
            '%',
          ),
          _buildDetailItem(
            CupertinoIcons.wind,
            'Wind',
            '${wind!.toInt()}',
            'm/s',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value, String unit) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 24,
            color: Color(0xFF26A69A),
          ),
        ),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF26A69A),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF00796B),
          ),
        ),
        Text(
          unit,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF26A69A).withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}