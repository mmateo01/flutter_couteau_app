// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, prefer_const_declarations, non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMe extends StatelessWidget {
  final String _firstName = 'Melquisedec';
  final String _lastName = 'Mateo Neris';
  final String _phoneNumber = '(809) 637-1212';
  final String _email = '20220238@itla.edu.do';

  final String _imagePath = 'images/foto.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de mí'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(_imagePath),
            ),
            SizedBox(height: 20),
            Text(
              '$_firstName $_lastName',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.phone),
                  onPressed: () {
                    launch('tel:$_phoneNumber');
                  },
                ),
                Text(_phoneNumber),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.email),
                  onPressed: () {
                    launch('mailto:$_email');
                  },
                ),
                Text(_email),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AboutMe(),
  ));
}
