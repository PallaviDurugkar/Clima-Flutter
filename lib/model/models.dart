import 'dart:convert';

class Weather {
  final int condition;
  final String name;
  final int temp;

  Weather({
    required this.condition,
    required this.name,
    required this.temp,
  });
  



  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      condition: map['weather'][0]['id'] as int,
      name:  map['name'] ?? '',
      temp:  (map['main']['temp'] as double).toInt(),
    );
  }


  factory Weather.fromJson(String source) => Weather.fromMap(json.decode(source));


  String get getWeatherIcon {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String get getMessage {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

}
