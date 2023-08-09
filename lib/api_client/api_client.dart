import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:know_weather/services/location_service.dart';

import '../models/weather.dart';

class ApiClient{
  static const String baseURL = 'https://api.openweathermap.org/data/2.5/weather';
  static Future<Climate> fetchCityWeather({required String cityName})async{
    final url = Uri.parse('$baseURL?appid=${dotenv.get('WeatherApiKey')}&q=$cityName&units=metric');
    final response = await http.get(url);

    final jsonData = jsonDecode(response.body);
    final climateData = Climate.fromJson(jsonData);

    return climateData;
  }
  static Future<Climate> fetchUserCityWeather()async{
    final userPosition = await LocationService.getCurrentUserLocation();
    final url = Uri.parse('$baseURL?appid=${dotenv.get('WeatherApiKey')}&lat=${userPosition.latitude}&lon=${userPosition.longitude}&units=metric');
    final response = await http.get(url);

    final jsonData = jsonDecode(response.body);
    final climateData = Climate.fromJson(jsonData);

    return climateData;
  }


}
