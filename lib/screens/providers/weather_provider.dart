import 'package:clima/model/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repository/weather_repository.dart';

final weatherProvider = FutureProvider.family<Weather, String>((ref, city) {
  final repo = WeatherRepository();

  if (city.isEmpty) {
    return repo.getLocationWeather();
  } else {
    return repo.getCityWeather(city);
  }
});
