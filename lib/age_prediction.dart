// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class AgePrediction extends StatefulWidget {
  @override
  _AgePredictionState createState() => _AgePredictionState();
}

class _AgePredictionState extends State<AgePrediction> {
  TextEditingController _nameController = TextEditingController();
  String _ageGroup = '';
  String _age = '';

  Future<void> predictAge() async {
    String name = _nameController.text;
    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    final data = json.decode(response.body);

    setState(() {
      _age = data['age'].toString();
      
      if (int.parse(_age) < 21) {
        _ageGroup = 'Joven';
      } else if (int.parse(_age) >= 21 && int.parse(_age) < 65) {
        _ageGroup = 'Adulto';
      } else {
        _ageGroup = 'Viejo';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Determinación de Edad'),
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
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => predictAge(),
              child: Text('Predecir Edad'),
            ),
            SizedBox(height: 20.0),
            Text('Grupo de Edad: $_ageGroup'),
            Text('Edad: $_age'),
            SizedBox(height: 20.0),
            // Mostrar la imagen correspondiente al grupo de edad
            if (_ageGroup.isNotEmpty)
              FutureBuilder(
                future: rootBundle.load('images/$_ageGroup.png'), // Carga la imagen desde assets
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