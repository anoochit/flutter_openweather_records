import 'package:flutter/material.dart';
import 'package:flutter_openweathermap/services/cityweather.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City Weather'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 260,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CityWeatherCard(city: 'London'),
                CityWeatherCard(city: 'New York'),
                CityWeatherCard(city: 'Bangkok'),
                CityWeatherCard(city: 'Beijing'),
                CityWeatherCard(city: 'Singapore'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CityWeatherCard extends StatelessWidget {
  const CityWeatherCard({
    super.key,
    required this.city,
  });

  final String city;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CityWeatherService().getCityWeather(city: city),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // has error
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error, cannot load weather data'),
          );
        }

        // has data
        if (snapshot.hasData) {
          final json = snapshot.data;

          final (
            city,
            icon,
            condition,
            description,
            currentTemp,
            tempMin,
            tempMax
          ) = CityWeatherService().getCityWeatherData(json: json);

          return Center(
            child: SizedBox(
              width: 200,
              height: 280,
              child: Card(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(city),
                      Image.network(icon),
                      Text(condition),
                      Text(description),
                      Text('Temp : $currentTemp'),
                      Text('Min Temp : $tempMin'),
                      Text('Max Temp : $tempMax'),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        // loading
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
