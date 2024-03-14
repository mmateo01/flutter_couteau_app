// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_browser/flutter_web_browser.dart';

class UniversitiesList extends StatefulWidget {
  @override
  _UniversitiesListState createState() => _UniversitiesListState();
}

class _UniversitiesListState extends State<UniversitiesList> {
  TextEditingController _countryController = TextEditingController();
  List<University> _universities = [];

  Future<void> fetchUniversities() async {
    String country = _countryController.text.trim().replaceAll(' ', '+');
    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    final data = json.decode(response.body);

    setState(() {
      _universities = List<University>.from(data.map((uni) => University.fromJson(uni)));
    });
  }

  Future<void> _launchURL(String url) async {
    await FlutterWebBrowser.openWebPage(url: url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Universidades'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _countryController,
              decoration: InputDecoration(labelText: 'País'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => fetchUniversities(),
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _universities.length,
                itemBuilder: (context, index) {
                  final university = _universities[index];
                  return InkWell(
                    onTap: () async {
                      String url = university.webPages.first;
                      await _launchURL(url);
                    },
                    child: ListTile(
                      title: Text(
                        university.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dominio: ${university.domains.join(', ')}',
                            style: TextStyle(color: Colors.black87),
                          ),
                          Text(
                            'Página web: ${university.webPages.join(', ')}',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class University {
  final String name;
  final List<String> domains;
  final List<String> webPages;

  University({required this.name, required this.domains, required this.webPages});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'],
      domains: List<String>.from(json['domains']),
      webPages: List<String>.from(json['web_pages']),
    );
  }
}
