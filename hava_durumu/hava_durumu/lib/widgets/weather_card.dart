import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hava_durumu/colors/color.dart';
import 'package:hava_durumu/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // flu miktarı
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.getColorForWeather(
                weather.durum,
              ).withOpacity(0.2), // daha saydam
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  weather.gun,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${double.parse(weather.derece).toInt()}°",
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 25),
                    Image.network(weather.ikon, width: 80),
                    const SizedBox(width: 40),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weather.durum.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
