import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class BannersList {
  List<AdsBanner> banners;
  BannersList({required this.banners});

  factory BannersList.fromJson(Map<String, dynamic> json) {
    debugPrint('from json BannersList');
    var bannersJson = json['banners'] as List;
    debugPrint('BannersJson');
    debugPrint(bannersJson.toString());
    List<AdsBanner> bannersList = bannersJson.map((i) => AdsBanner.fromJson(i)).toList();

    return BannersList(
      banners: bannersList,
    );
  }
}

class AdsBanner {
  late final String id;
  late final String bannerId;
  late final String bannerName;
  late final String path;

  AdsBanner({
    required this.id,
    required this.bannerId,
    required this.bannerName,
    required this.path,
  });

  factory AdsBanner.fromJson(Map<String, dynamic> json) {
    return AdsBanner(
      id: json['id'] as String,
      bannerId: json['bannerId'] as String,
      bannerName: json['bannerName'] as String,
      path: json['path'] as String,
    );
  }

  Future<BannersList> getBannersList() async {
    // const url = 'https://about.google/static/data/locations.json';
    // const url = 'http://localhost/test/users_list.php';
    const url = 'https://cadillacapp.ru/test/banners_list.php';
    final response = await http.get(Uri.parse(url));
    debugPrint('response body user getBannersList');
    debugPrint('response body');
    if (response.statusCode == 200) {
      return BannersList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bannerId'] = bannerId;
    data['bannerName'] = bannerName;
    data['path'] = path;

    return data;
  }
}
