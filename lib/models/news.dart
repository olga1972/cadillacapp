import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NewsList {
  List<New> news;
  NewsList({required this.news});

  factory NewsList.fromJson(Map<String, dynamic> json) {
    debugPrint('from json newsList');
    var newsJson = json['news'] as List;
    debugPrint('newsJson');
    debugPrint(newsJson.toString());
    List<New> newsList = newsJson.map((i) => New.fromJson(i)).toList();
    return NewsList(
      news: newsList,
    );
  }
}

class New {
  late final String id;
  late final String newsId;
  late final String newsName;
  late final String newsDate;
  late final String newsLocation;
  late final String newsDescr;
  late final String path;

  New(
      {required this.id,
      required this.newsId,
      required this.newsName,
      required this.newsDate,
      required this.newsLocation,
      required this.newsDescr,
      required this.path});

  factory New.fromJson(Map<String, dynamic> json) {
    return New(
        id: json['id'] as String,
        newsId: json['newsId'] as String,
        newsName: json['newsName'] as String,
        newsDate: json['newsDate'] as String,
        newsLocation: json['newsLocation'] as String,
        newsDescr: json['newsDescr'] as String,
        path: json['path'] as String);
  }

  Future<NewsList> getNewsList() async {
    const url = 'https://cadillacapp.ru/test/news_list.php';
    final response = await http.get(Uri.parse(url));
    debugPrint('response body user getNewsList');
    debugPrint('response body');
    if (response.statusCode == 200) {
      return NewsList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['newsId'] = newsId;
    data['newsName'] = newsName;
    data['newsDate'] = newsDate;
    data['newsLocation'] = newsLocation;
    data['newsDescrl'] = newsDescr;
    data['path'] = path;
    return data;
  }
}
