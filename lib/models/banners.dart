import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class BannersList {
  List<AdsBanner> banners;
  BannersList({required this.banners});

  factory BannersList.fromJson (Map<String, dynamic> json) {
    print('from json BannersList');
    print(json);
    print(json['Banners']);
    var bannersJson = json['banners'] as List;

    print('BannersJson');
    print(bannersJson);
    List<AdsBanner> bannersList = bannersJson.map((i) => AdsBanner.fromJson(i)).toList();

    print('BannersList');
    print(bannersList);


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
    print('response body user getBannersList');
    print('response body');
    if(response.statusCode == 200) {
      return BannersList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bannerId'] = this.bannerId;
    data['bannerName'] = this.bannerName;
    data['path'] = this.path;

    return data;
  }
}

