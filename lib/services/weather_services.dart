import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../model/weather_model.dart';
import 'package:http/http.dart' as http;
class WeatherService{
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async{
    final response = await http
    .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
    
    if(response.statusCode==200){
      return Weather.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load data');
    }
  }

  // Future<Weather> getCurrentCity() async{
  //   //get permission from user
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if(permission == LocationPermission.denied){
  //     permission = await Geolocator.requestPermission();
  //   }

  //   // fetch the current location
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy:LocationAccuracy.high );

  //   // Convert the location into a list of placemark objects
  //   List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude,position.longitude);

  //   //extract the city name from thr first placemark
  //   String? city = placemarks[0].locality;

  //   return city ?? "";
  // }
  Future<Weather> getCurrentCity() async {
  // Get permission from the user
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  // Fetch the current location
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  // Convert the location into a list of placemark objects
  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

  // Extract the city name from the first placemark
  String? city = placemarks[0].locality;

  // If city is null or empty, throw an exception
  if (city == null || city.isEmpty) {
    throw Exception('Unable to fetch the city name from the location');
  }

  // Fetch and return the weather for the detected city
  return getWeather(city);
}

}