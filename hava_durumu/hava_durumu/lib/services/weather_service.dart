import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:dio/dio.dart';
import 'package:hava_durumu/models/weather_model.dart';

class WeatherService {
  Future<String> getLocation() async {
    //Kullanıcının konumu açık mı
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Future.error("Konum servisiniz kapalı");
    }
    //Konum izni vermişmi
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission == await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Future.error("Konum izni vermelisiniz");
      }
    }
    //Pozisyonu aldık
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    //pozisyon ile yerleşim yerini bulduk
    final List<Placemark> placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    //yerleşim yerini kaydettik
    final String? city = placemark[0].administrativeArea;
    if (city == null) Future.error("Bir hata oluştu");
    return city!;
  }

  Future<(List<WeatherModel>, String)> getWeatherDataWithCity([
    String? city,
  ]) async {
    final String selectedCity =
        city ?? await getLocation(); // dışarıdan geldiyse onu kullan
    final String url =
        "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=${Uri.encodeComponent(selectedCity)}";
    const Map<String, dynamic> headers = {
      "authorization": "apikey 6J2eLzt8UnZZ9vVH2W5pzu:7oBXijkip5MWJGX5RU0EJS",
      "content-type": "application/json",
    };

    final dio = Dio();
    final response = await dio.get(url, options: Options(headers: headers));

    if (response.statusCode != 200) {
      return Future.error("Bir hata oluştu");
    }

    final List list = response.data['result'];
    final List<WeatherModel> weatherList =
        list.map((e) => WeatherModel.fromJson(e)).toList();

    return (weatherList, selectedCity);
  }
}
