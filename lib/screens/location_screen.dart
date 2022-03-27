import 'package:clima/screens/loading_screen.dart';
import 'package:clima/screens/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'city_screen.dart';

final cityProvider = StateProvider<String>((ref) => '');

class LocationScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final city = ref.watch(cityProvider.state);
    final weatherAsync = ref.watch(weatherProvider(city.state));
    return weatherAsync.when(
        data: (weather) => Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/location_background.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8), BlendMode.dstATop),
                  ),
                ),
                constraints: BoxConstraints.expand(),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                            onPressed: () async {
                              // var weatherData = await weather.getLocationWeather();
                              // updateUI(weatherData);
                            },
                            child: Icon(
                              Icons.near_me,
                              size: 50.0,
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              var typedName = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CityScreen();
                                  },
                                ),
                              );
                              if (typedName != null) {
                                city.state = typedName;
                              }
                            },
                            child: Icon(
                              Icons.location_city,
                              size: 50.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '${weather.temp}°',
                              style: kTempTextStyle,
                            ),
                            Text(
                              weather.getWeatherIcon,
                              style: kConditionTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Text(
                          '${weather.getMessage} in ${weather.name}',
                          textAlign: TextAlign.right,
                          style: kMessageTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        error: (e, s) => Scaffold(),
        loading: () => LoadingScreen());
  }
}
