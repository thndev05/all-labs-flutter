import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherData {
  const WeatherData({
    required this.city,
    required this.temperature,
    required this.conditionId,
    required this.description,
  });

  final String city;
  final double temperature;
  final int conditionId;
  final String description;

  String get icon {
    if (conditionId < 300) return '🌩️';
    if (conditionId < 600) return '🌧️';
    if (conditionId < 700) return '❄️';
    if (conditionId < 800) return '🌫️';
    if (conditionId == 800) return '☀️';
    return '☁️';
  }

  String get message {
    if (temperature > 25) return 'It’s 🍦 time';
    if (temperature > 20) return 'Time for shorts and 👕';
    if (temperature < 10) return 'You’ll need 🧣 and 🧤';
    return 'Bring a 🧥 just in case';
  }

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final weather =
        (json['weather'] as List<dynamic>).first as Map<String, dynamic>;
    final main = json['main'] as Map<String, dynamic>;
    return WeatherData(
      city: json['name'] as String? ?? 'Unknown',
      temperature: (main['temp'] as num).toDouble(),
      conditionId: weather['id'] as int,
      description: weather['description'] as String? ?? '',
    );
  }
}

abstract interface class WeatherService {
  Future<WeatherData> fetchCity(String city);
}

class OpenWeatherService implements WeatherService {
  OpenWeatherService({required this.apiKey, http.Client? client})
      : _client = client ?? http.Client();

  final String apiKey;
  final http.Client _client;

  @override
  Future<WeatherData> fetchCity(String city) async {
    final uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'q': city,
      'appid': apiKey,
      'units': 'metric',
      'lang': 'en',
    });
    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Weather API request failed: ${response.statusCode}');
    }

    return WeatherData.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }
}

class DemoWeatherService implements WeatherService {
  @override
  Future<WeatherData> fetchCity(String city) async => WeatherData(
        city: city,
        temperature: 27,
        conditionId: 800,
        description: 'clear sky',
      );
}
