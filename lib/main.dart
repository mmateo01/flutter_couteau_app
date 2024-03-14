// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '/age_prediction.dart';
import '/gender_prediction.dart';
import '/universities_list.dart';
import '/weather_rd.dart';
import '/wordpress_news.dart';
import '/about_me.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tu App Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/age_prediction': (context) => AgePrediction(),
        '/gender_prediction': (context) => GenderPrediction(),
        '/universities_list': (context) => UniversitiesList(),
        '/weather_rd': (context) => WeatherRd(),
        '/wordpress_news': (context) => WordPressNews(),
        '/about_me': (context) => AboutMe(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Image.asset('images/tools.png', height: 300,),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(height: 50.0),
            Image.asset('images/tools.png', height: 200,),
            ListTile(
              title: Text('Predicción de Género'),
              onTap: () {
                Navigator.pushNamed(context, '/gender_prediction');
              },
            ),
            ListTile(
              title: Text('Determinación de Edad'),
              onTap: () {
                Navigator.pushNamed(context, '/age_prediction');
              },
            ),
            ListTile(
              title: Text('Universidades por País'),
              onTap: () {
                Navigator.pushNamed(context, '/universities_list');
              },
            ),
            ListTile(
              title: Text('Clima en RD'),
              onTap: () {
                Navigator.pushNamed(context, '/weather_rd');
              },
            ),
            ListTile(
              title: Text('Noticias de WordPress'),
              onTap: () {
                Navigator.pushNamed(context, '/wordpress_news');
              },
            ),
            ListTile(
              title: Text('Acerca de'),
              onTap: () {
                Navigator.pushNamed(context, '/about_me');
              },
            ),
          ],
        ),
      ),
    );
  }
}
