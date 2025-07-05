import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hava_durumu/models/weather_model.dart';
import 'package:hava_durumu/services/weather_service.dart';
import 'package:hava_durumu/widgets/weather_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WeatherModel> _weathers = [];
  String _city = "";
  final List<String> _cities = [
    'İstanbul',
    'Ankara',
    'İzmir',
    'Bursa',
    'Antalya',
    'Gaziantep',
  ];

  void _getWeatherData([String? selectedCity]) async {
    final (data, city) = await WeatherService().getWeatherDataWithCity(
      selectedCity,
    );
    setState(() {
      _weathers = data;
      _city = city;
    });
  }

  @override
  void initState() {
    super.initState();
    _getWeatherData(); // Varsayılan şehir
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arka plan resmi
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pxfuel.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Üstteki içerik (AppBar benzeri ve liste)
          SafeArea(
            child: Column(
              children: [
                // Saydam ve flu AppBar benzeri üst bar
                PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 48), // sol boşluk
                            Text(
                              _city.isNotEmpty ? _city : "Yükleniyor...",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w300,
                                color: Colors.lightBlue.shade200,
                              ),
                            ),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.location_on_outlined),
                              onSelected: (String selectedCity) {
                                _getWeatherData(selectedCity);
                              },
                              itemBuilder: (BuildContext context) {
                                return _cities.map((city) {
                                  return PopupMenuItem(
                                    value: city,
                                    child: Text(city),
                                  );
                                }).toList();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Hava durumu kartlarını listele
                Expanded(
                  child:
                      _weathers.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 12,
                            ),
                            itemCount: _weathers.length,
                            itemBuilder: (context, index) {
                              final weather = _weathers[index];
                              return WeatherCard(weather: weather);
                            },
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
