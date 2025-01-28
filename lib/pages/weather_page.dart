import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/weather_model.dart';
import 'package:flutter_application_1/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api Key
  final _weatherService = WeatherService('d81b2ca173d0928b568feed35e06c58f');
  Weather ? _Weather;

  //fetch Weather
  Future<void> _fetchWeather() async {
  try {
    // Get city name
    String cityName = await WeatherService.getCurrentCity();

    // Get Weather for city
    final weather = await _weatherService.getWeather(cityName);

    // Update the state with the fetched weather
    setState(() {
      _Weather = weather;
    });
  } catch (e) {
    // Handle any error
    print('Error fetching weather: $e');
  }
}
// initial state
@override
  void initState() {
    super.initState();

  //fetch the weather
  _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}