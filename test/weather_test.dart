import 'package:flutter_test/flutter_test.dart';
import 'package:clima/services/weather_service.dart';

void main() {
  test('maps weather data and chooses a message', () {
    const weather = WeatherData(
        city: 'Đà Nẵng',
        temperature: 28,
        conditionId: 800,
        description: 'clear sky');
    expect(weather.icon, '☀️');
    expect(weather.message, 'It’s 🍦 time');
  });
}
