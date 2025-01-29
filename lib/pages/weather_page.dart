import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/weather_model.dart';
import 'package:flutter_application_1/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('d81b2ca173d0928b568feed35e06c58f');
  Weather? _weather;
  bool _isLoading = true;  // To track the loading state
  String? _errorMessage;

  Future<void> _fetchWeather() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;  // Clear any previous errors
      });

      // Get weather for current city
      final weather = await _weatherService.getCurrentCity();

      // Update the state with the fetched weather
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      // Handle any error
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error fetching weather: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather(); // Fetch the weather when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather")),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()  // Show loading indicator
            : _errorMessage != null
                ? Text(_errorMessage!)  // Show error message if there's an issue
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Display city name (with null check)
                      Text(
                        _weather?.cityName ?? "Loading City...",
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      // Display temperature (with null check)
                      Text(
                        '${_weather?.temperature.round() ?? 0}° C',
                        style: const TextStyle(fontSize: 40),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _fetchWeather,  // Refresh weather
                        child: const Text('Refresh'),
                      ),
                    ],
                  ),
      ),
    );
  }
}
