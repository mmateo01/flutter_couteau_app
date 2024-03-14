// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class GenderPrediction extends StatefulWidget {
  @override
  _GenderPredictionState createState() => _GenderPredictionState();
}

class _GenderPredictionState extends State<GenderPrediction> {
  TextEditingController _nameController = TextEditingController();
  String _gender = '';
  String _color = '';

  Future<void> predictGender() async {
    String name = _nameController.text;
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
    final data = json.decode(response.body);

    setState(() {
      _gender = data['gender'];
      _color = (_gender.toLowerCase() == 'male') ? 'azul' : 'rosa';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Género'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 15.0),
            ElevatedButton(
              onPressed: () => predictGender(),
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 15.0),
            Text(
              'Género: $_gender',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            if (_color.isNotEmpty)
              Text(
                'Color asociado: $_color',
                style: TextStyle(fontSize: 20.0),
              ),
            SizedBox(height: 20.0),
            // Mostrar la imagen correspondiente al género
            if (_color.isNotEmpty)
              FutureBuilder(
                future: rootBundle.load('images/$_color.png'), // Carga la imagen desde assets
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Image.memory(snapshot.data!.buffer.asUint8List(), width: 150, height: 150);
                    } else {
                      return Text('No se pudo cargar la imagen');
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
