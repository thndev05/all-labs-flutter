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

class DemoWeatherService implements WeatherService {
  @override
  Future<WeatherData> fetchCity(String city) async => WeatherData(
        city: city,
        temperature: 27,
        conditionId: 800,
        description: 'clear sky',
      );
}
