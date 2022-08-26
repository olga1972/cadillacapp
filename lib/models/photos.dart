import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PhotosList {
  List<Photo> photos;
  PhotosList({required this.photos});

  factory PhotosList.fromJson(Map<String, dynamic> json) {
    debugPrint('from json PhotosList');
    var photosJson = json['photos'] as List;
    debugPrint('PhotosJson');
    debugPrint(photosJson.toString());
    List<Photo> photosList = photosJson.map((i) => Photo.fromJson(i)).toList();

    return PhotosList(
      photos: photosList,
    );
  }
}

class Photo {
  late final String id;
  late final String photoId;
  late final String photoName;
  late final String path;

  Photo({
    required this.id,
    required this.photoId,
    required this.photoName,
    required this.path,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      photoId: json['photoId'] as String,
      photoName: json['photoName'] as String,
      path: json['path'] as String,
    );
  }

  Future<PhotosList> getPhotosList() async {
    const url = 'https://cadillacapp.ru/test/photos_list.php';
    final response = await http.get(Uri.parse(url));
    debugPrint('response body user getBannersList');
    debugPrint('response body');
    if (response.statusCode == 200) {
      return PhotosList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photoId'] = photoId;
    data['photoName'] = photoName;
    data['path'] = path;

    return data;
  }
}
