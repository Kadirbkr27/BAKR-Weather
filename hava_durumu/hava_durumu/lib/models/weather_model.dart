class WeatherModel {
  final String ikon;
  final String durum;
  final String derece;
  final String min;
  final String max;
  final String gece;
  final String nem;
  final String gun;

  WeatherModel({
    required this.ikon,
    required this.durum,
    required this.derece,
    required this.min,
    required this.max,
    required this.gece,
    required this.nem,
    required this.gun,
  });

  WeatherModel.fromJson(Map<String, dynamic> json)
    : ikon = json['icon'],
      durum = json['description'],
      derece = json['degree'],
      min = json['min'],
      max = json['max'],
      gece = json['night'],
      nem = json['humidity'],
      gun = json['day'];
}
