// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, prefer_const_declarations, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_browser/flutter_web_browser.dart';

class WordPressNews extends StatefulWidget {
  @override
  _WordPressNewsState createState() => _WordPressNewsState();
}

class _WordPressNewsState extends State<WordPressNews> {
  List<NewsItem> _newsItems = [];

  Future<void> fetchNews() async {
    final url = 'https://www.nasa.gov/wp-json/wp/v2/posts?per_page=5';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      
      setState(() {
        _newsItems = data.map((post) => NewsItem.fromJson(post)).toList();
        if (_newsItems.length > 3) {
          _newsItems = _newsItems.take(3).toList();
        }
      });
    } else {
      setState(() {
        _newsItems = [];
      });
    }
  }

  Future<void> _launchURL(String url) async {
    await FlutterWebBrowser.openWebPage(url: url);
  }
  
  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias de WordPress'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  'images/nasa.png', // Ajusta la ruta según la ubicación de tu imagen
                  width: 100,
                  height: 100,
                ),
                SizedBox(width: 10),
                Text(
                  'Sitio WordPress de la NASA',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _newsItems.length,
              itemBuilder: (context, index) {
                final newsItem = _newsItems[index];
                return ListTile(
                  title: Text(newsItem.title),
                  subtitle: Text(newsItem.summary),
                  onTap: () async {
                    String url = newsItem.link;
                    await _launchURL(url);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NewsItem {
  final String title;
  final String summary;
  final String link;

  NewsItem({required this.title, required this.summary, required this.link});

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title']['rendered'],
      summary: json['excerpt']['rendered'],
      link: json['link'],
    );
  }
}
