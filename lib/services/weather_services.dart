import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherServices{
  final String apiKey = "3b719c8b28884fff91e233145260801";
  final String forecastBaseUrl = "http://api.weatherapi.com/v1/forecast.json";
  final String searchBaseUrl = "http://api.weatherapi.com/v1/search.json";

  //metodo para traer el clima actual
Future<Map<String, dynamic>> fetchCurrentWeather(String city) async{
  final url = '$forecastBaseUrl?key=$apiKey&q=$city&days=1&aqui=no&alerts=no';
  final response = await http.get(Uri.parse(url));

  if(response.statusCode == 200){
    return jsonDecode(response.body);
  }else{
    throw Exception('Failed to load Data');
  }
}

//metodo para traer el forecast de 7 dias
Future<Map<String, dynamic>> fetch7DaysWeather(String city) async{
    final url = '$forecastBaseUrl?key=$apiKey&q=$city&days=7&aqui=no&alerts=no';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception('Failed to load Data');
    }
}

  //metodo para traer el clima sugerido para una entrada
  Future<List<dynamic>> fetchCitySuggestionWeather(String query) async{
    final url = '$forecastBaseUrl?key=$apiKey&q=$query';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception('Failed to load Data');
    }
  }

}