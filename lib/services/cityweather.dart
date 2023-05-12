import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class CityWeatherService {
  // get weather
  Future<String> getCityWeather({required String city}) async {
    // endpoint
    final uri =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=92f90171a9639b008090aa98c05df965';

    // http request
    try {
      final res = await http.get(Uri.parse(uri));

      if (res.statusCode == 200) {
        return res.body;
      } else {
        throw ('error');
      }
    } catch (e) {
      throw ('error');
    }
  }

  (
    String city,
    String icon,
    String condition,
    String description,
    double currentTemp,
    double tempMin,
    double tempMax
  ) getCityWeatherData({required String json}) {
    final cityWeather = jsonDecode(json);

    final iconUrl =
        'https://openweathermap.org/img/wn/${cityWeather['weather'].first['icon']}@2x.png';
    log(json);
    return (
      cityWeather['name'],
      iconUrl,
      cityWeather['weather'].first['main'],
      cityWeather['weather'].first['description'],
      cityWeather['main']['temp'],
      cityWeather['main']['temp_min'],
      cityWeather['main']['temp_max'],
    );
  }
}
