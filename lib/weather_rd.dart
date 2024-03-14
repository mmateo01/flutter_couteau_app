// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use, prefer_const_declarations

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherRd extends StatefulWidget {
  @override
  _WeatherRdState createState() => _WeatherRdState();
}

class _WeatherRdState extends State<WeatherRd> {
  String _weatherDescription = '';
  String _temperature = '';
  String city = 'santo-domingo-este';
  String apiKey = 'wngpvfoixlm00mlf6jb1qk3oup3z3yr2oljdrfhy'; 

  Future<void> fetchWeatherData() async {
    final url = 'https://www.meteosource.com/api/v1/free/point?place_id=$city&language=en&units=metric&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final currentWeather = data['current'];
      
      setState(() {
        _weatherDescription = currentWeather['summary'].toString();
        _temperature = currentWeather['temperature'].toString();
      });
    } else {
      setState(() {
        _weatherDescription = 'Error al obtener el clima';
        _temperature = '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en Santo Domingo'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Descripción del Clima: $_weatherDescription',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Temperatura: $_temperature °C',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
