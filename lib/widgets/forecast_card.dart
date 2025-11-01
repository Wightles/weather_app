import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utilites/forecast_util.dart';

Widget forecastCard(AsyncSnapshot snapshot, int index) {
  var forecastList = snapshot.data.list;
  var dayOfWeek = '';
  DateTime date =
      DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt * 1000);
  var fullDate = Util.getFormattedDate(date);
  dayOfWeek = fullDate.split(',')[0];
  var tempMin = forecastList[index].temp.min.toStringAsFixed(0);
  var tempMax = forecastList[index].temp.max.toStringAsFixed(0);
  var icon = forecastList[index].getIconUrl();
  
  return Container(
    width: 110,
    height: 150,
    margin: EdgeInsets.symmetric(horizontal: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF4DB6AC).withOpacity(0.1),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
      border: Border.all(
        color: Color(0xFF4DB6AC).withOpacity(0.2),
        width: 1,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            dayOfWeek,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF26A69A),
            ),
            textAlign: TextAlign.center,
          ),
          
          Image.network(
            icon, 
            width: 45,
            height: 45,
          ),
          
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.arrow_up,
                    size: 12,
                    color: Color(0xFFE57373),
                  ),
                  SizedBox(width: 2),
                  Text(
                    '$tempMax°',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE57373),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 2),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.arrow_down,
                    size: 12,
                    color: Color(0xFF64B5F6),
                  ),
                  SizedBox(width: 2),
                  Text(
                    '$tempMin°',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64B5F6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}