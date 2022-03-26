import 'package:clima/model/models.dart';

import '../services/location.dart';
import 'package:http/http.dart' as http;


class WeatherRepository {
  final apiKey = '56996242f92ae790e2fc19ccca695369';
  final openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<Weather> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future<Weather> getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Weather.fromJson(response.body);
    } else {
      return Future.error("Something error!");
    }
  }
}
