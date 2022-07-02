import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PartnersList {
  List<Partner> partners;
  PartnersList({required this.partners});

  factory PartnersList.fromJson (Map<String, dynamic> json) {
    print('from json partnersList');
    print(json);
    print(json['partners']);
    var partnersJson = json['partners'] as List;

    print('partnersJson');
    print(partnersJson);
    List<Partner> partnersList = partnersJson.map((i) => Partner.fromJson(i)).toList();

    print('partnersList');
    print(partnersList);


    return PartnersList(
      partners: partnersList,
    );
  }
}

class Partner {
  late final String id;
  late final String partnerId;
  late final String partnerName;
  late final String path;


  Partner({
    required this.id,
    required this.partnerId,
    required this.partnerName,
    required this.path,

  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'] as String,
      partnerId: json['partnerId'] as String,
      partnerName: json['partnerName'] as String,
      path: json['path'] as String,
    );
  }


  Future<PartnersList> getPartnersList() async {
    // const url = 'https://about.google/static/data/locations.json';
    // const url = 'http://localhost/test/users_list.php';
    const url = 'https://cadillacapp.ru/test/partners_list.php';
    final response = await http.get(Uri.parse(url));
    print('response body user getPartnersList');
    print('response body');
    if(response.statusCode == 200) {
      return PartnersList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['partnerId'] = this.partnerId;
    data['partnerName'] = this.partnerName;
    data['path'] = this.path;

    return data;
  }
}

