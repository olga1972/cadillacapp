import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class NewsList {
  List<New> news;
  NewsList({required this.news});

  factory NewsList.fromJson (Map<String, dynamic> json) {
    print('from json newsList');
    print(json);
    print(json['news']);
    var newsJson = json['news'] as List;

    print('newsJson');
    print(newsJson);
    List<New> newsList = newsJson.map((i) => New.fromJson(i)).toList();

    print('newsList');
    print(newsList);
    print(newsList.runtimeType);

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

  //late final XFile? photo;

  New({
    required this.id,
    required this.newsId,
    required this.newsName,
    required this.newsDate,
    required this.newsLocation,
    required this.newsDescr,

    //this.photo,
  });

  factory New.fromJson(Map<String, dynamic> json) {
    return New(
      id: json['id'] as String,
      newsId: json['newsId'] as String,
      newsName: json['newsName'] as String,
      newsDate: json['newsDate'] as String,
      newsLocation: json['newsLocation'] as String,
      newsDescr: json['newsDescr'] as String,

      //XFileImage(file!)photo: json['photo'] as XFile
    );
  }


  Future<NewsList> getNewsList() async {
    // const url = 'https://about.google/static/data/locations.json';
    // const url = 'http://localhost/test/users_list.php';
    const url = 'https://cadillacapp.ru/test/news_list.php';
    final response = await http.get(Uri.parse(url));
    print('response body user getNewsList');
    print('response body');
    if(response.statusCode == 200) {
      return NewsList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['newsId'] = this.newsId;
    data['newsName'] = this.newsName;
    data['newsDate'] = this.newsDate;
    data['newsLocation'] = this.newsLocation;
    data['newsDescrl'] = this.newsDescr;
    return data;
  }
}

// Future<NewsList> readJson() async {
//   final String response = await rootBundle.loadString('assets/news.json');
//   final data = await json.decode(response);
//   print('newslist readJson');
//   return NewsList.fromJson(json.decode(response));
//
// }
