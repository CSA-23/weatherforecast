import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'London';
      String apiKey = 'a4a354a506681c4e1ba7d9914c734c89';
      final result = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$apiKey'),
      );
      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
        throw 'UnExpected error occured';
      }
      // data['list'][0]['main']['temp'];
      return data;
    } catch (e) {
      throw e.toString();
    }
  }