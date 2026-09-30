import 'package:flutter/material.dart';

import 'services/weather_service.dart';

const _weatherApiKey = String.fromEnvironment('OPENWEATHER_API_KEY');

void main() => runApp(const ClimaApp());

class ClimaApp extends StatelessWidget {
  const ClimaApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Clima',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Spartan MB'),
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.indigo, brightness: Brightness.dark),
        ),
        home: const WeatherPage(),
      );
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, this.service});

  final WeatherService? service;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late final WeatherService _service = widget.service ??
      (_weatherApiKey.isEmpty
          ? DemoWeatherService()
          : OpenWeatherService(apiKey: _weatherApiKey));
  final _cityController = TextEditingController(text: 'Đà Nẵng');
  WeatherData? _weather;
  String? _error;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    final city = _cityController.text.trim();
    if (city.isEmpty) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final result = await _service.fetchCity(city);
      if (!mounted) return;
      setState(() {
        _weather = result;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Không thể tải dữ liệu thời tiết.';
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weather = _weather;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('Clima'),
        ),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/location_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black45,
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  key: const Key('city-input'),
                  controller: _cityController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => _loadWeather(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon:
                        const Icon(Icons.location_city, color: Colors.indigo),
                    suffixIcon: IconButton(
                        onPressed: _loadWeather,
                        icon: const Icon(Icons.search, color: Colors.indigo)),
                    hintText: 'Nhập tên thành phố',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 28),
                if (_loading)
                  const Expanded(
                      child: Center(child: CircularProgressIndicator()))
                else if (_error != null)
                  Expanded(
                      child: Center(
                          child: Text(_error!,
                              style: const TextStyle(fontSize: 20))))
                else if (weather != null)
                  Expanded(child: _WeatherCard(weather: weather))
                else
                  const Expanded(
                      child: Center(
                          child: Text('Nhập thành phố để xem thời tiết.'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WeatherCard extends StatelessWidget {
  const _WeatherCard({required this.weather});
  final WeatherData weather;

  @override
  Widget build(BuildContext context) => Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(weather.city,
                  key: const Key('weather-city'),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('${weather.temperature.round()}°',
                    style: const TextStyle(fontSize: 88)),
                Text(weather.icon, style: const TextStyle(fontSize: 60))
              ]),
              const SizedBox(height: 12),
              Text(weather.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25)),
              const SizedBox(height: 12),
              Text(weather.description,
                  style: const TextStyle(fontSize: 16, color: Colors.white70)),
            ],
          ),
        ),
      );
}
