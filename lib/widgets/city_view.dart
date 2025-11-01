import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_daily.dart';
import 'package:weather_app/utilites/forecast_util.dart';

class CityView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const CityView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var city = snapshot.data?.city!.name;
    var country = snapshot.data?.city!.country;
    var formattedDate =
        DateTime.fromMillisecondsSinceEpoch(forecastList![0].dt! * 1000);
        
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4DB6AC).withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(
            '$city, $country',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24.0,
              color: Color(0xFF00796B),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            Util.getFormattedDate(formattedDate),
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFF26A69A),
            ),
          ),
        ],
      ),
    );
  }
}