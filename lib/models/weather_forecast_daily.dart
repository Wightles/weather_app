import 'package:weather_app/utilites/constants.dart';

class WeatherForecast {
  WeatherForecast({
    required this.city,
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
  });

  final City? city;
  final String? cod;
  final num? message; // Changed to num to handle both int and double
  final int? cnt;
  final List<ListElement> list;

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      city: json["city"] == null ? null : City.fromJson(json["city"]),
      cod: json["cod"]?.toString(), // Convert to string if needed
      message: json["message"],
      cnt: json["cnt"] is int ? json["cnt"] : (json["cnt"] as num?)?.toInt(),
      list: json["list"] == null
          ? []
          : List<ListElement>.from(
              json["list"]!.map((x) => ListElement.fromJson(x))),
    );
  }
}

class City {
  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
  });

  final int? id;
  final String? name;
  final Coord? coord;
  final String? country;
  final int? population;
  final int? timezone;

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json["id"] is int ? json["id"] : (json["id"] as num?)?.toInt(),
      name: json["name"],
      coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
      country: json["country"],
      population: json["population"] is int
          ? json["population"]
          : (json["population"] as num?)?.toInt(),
      timezone: json["timezone"] is int
          ? json["timezone"]
          : (json["timezone"] as num?)?.toInt(),
    );
  }
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  final double? lon;
  final double? lat;

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json["lon"] is double ? json["lon"] : (json["lon"] as num?)?.toDouble(),
      lat: json["lat"] is double ? json["lat"] : (json["lat"] as num?)?.toDouble(),
    );
  }
}

class ListElement {
  ListElement({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.weather,
    required this.speed,
    required this.deg,
    required this.gust,
    required this.clouds,
    required this.pop,
    required this.rain,
  });

  final int? dt;
  final int? sunrise;
  final int? sunset;
  final Temp? temp;
  final FeelsLike? feelsLike;
  final int? pressure;
  final int? humidity;
  final List<Weather> weather;
  final double? speed;
  final int? deg;
  final double? gust;
  final int? clouds;
  final double? pop;
  final double? rain;

  factory ListElement.fromJson(Map<String, dynamic> json) {
    return ListElement(
      dt: json["dt"] is int ? json["dt"] : (json["dt"] as num?)?.toInt(),
      sunrise: json["sunrise"] is int
          ? json["sunrise"]
          : (json["sunrise"] as num?)?.toInt(),
      sunset: json["sunset"] is int
          ? json["sunset"]
          : (json["sunset"] as num?)?.toInt(),
      temp: json["temp"] == null ? null : Temp.fromJson(json["temp"]),
      feelsLike: json["feels_like"] == null
          ? null
          : FeelsLike.fromJson(json["feels_like"]),
      pressure: json["pressure"] is int
          ? json["pressure"]
          : (json["pressure"] as num?)?.toInt(),
      humidity: json["humidity"] is int
          ? json["humidity"]
          : (json["humidity"] as num?)?.toInt(),
      weather: json["weather"] == null
          ? []
          : List<Weather>.from(
              json["weather"]!.map((x) => Weather.fromJson(x))),
      speed: json["speed"] is double
          ? json["speed"]
          : (json["speed"] as num?)?.toDouble(),
      deg: json["deg"] is int ? json["deg"] : (json["deg"] as num?)?.toInt(),
      gust: json["gust"] is double
          ? json["gust"]
          : (json["gust"] as num?)?.toDouble(),
      clouds: json["clouds"] is int
          ? json["clouds"]
          : (json["clouds"] as num?)?.toInt(),
      pop: json["pop"] is double
          ? json["pop"]
          : (json["pop"] as num?)?.toDouble(),
      rain: json["rain"] is double
          ? json["rain"]
          : (json["rain"] as num?)?.toDouble(),
    );
  }

  String getIconUrl() {
    return '${Constants.WEATHER_IMAGES_URL}${weather[0].icon}.png';
  }
}

class FeelsLike {
  FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  final double? day;
  final double? night;
  final double? eve;
  final double? morn;

  factory FeelsLike.fromJson(Map<String, dynamic> json) {
    return FeelsLike(
      day: json["day"] is double
          ? json["day"]
          : (json["day"] as num?)?.toDouble(),
      night: json["night"] is double
          ? json["night"]
          : (json["night"] as num?)?.toDouble(),
      eve: json["eve"] is double
          ? json["eve"]
          : (json["eve"] as num?)?.toDouble(),
      morn: json["morn"] is double
          ? json["morn"]
          : (json["morn"] as num?)?.toDouble(),
    );
  }
}

class Temp {
  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  final double? day;
  final double? min;
  final double? max;
  final double? night;
  final double? eve;
  final double? morn;

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
      day: json["day"] is double
          ? json["day"]
          : (json["day"] as num?)?.toDouble(),
      min: json["min"] is double
          ? json["min"]
          : (json["min"] as num?)?.toDouble(),
      max: json["max"] is double
          ? json["max"]
          : (json["max"] as num?)?.toDouble(),
      night: json["night"] is double
          ? json["night"]
          : (json["night"] as num?)?.toDouble(),
      eve: json["eve"] is double
          ? json["eve"]
          : (json["eve"] as num?)?.toDouble(),
      morn: json["morn"] is double
          ? json["morn"]
          : (json["morn"] as num?)?.toDouble(),
    );
  }
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json["id"] is int ? json["id"] : (json["id"] as num?)?.toInt(),
      main: json["main"],
      description: json["description"],
      icon: json["icon"],
    );
  }
}