import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class PartnersList {
  List<Partner> partners;
  PartnersList({required this.partners});

  factory PartnersList.fromJson(Map<String, dynamic> json) {
    debugPrint('from json partnersList');
    var partnersJson = json['partners'] as List;

    debugPrint('partnersJson');
    debugPrint(partnersJson.toString());
    List<Partner> partnersList = partnersJson.map((i) => Partner.fromJson(i)).toList();
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
    const url = 'https://cadillacapp.ru/test/partners_list.php';
    final response = await http.get(Uri.parse(url));
    debugPrint('response body user getPartnersList');
    debugPrint('response body');
    if (response.statusCode == 200) {
      return PartnersList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['partnerId'] = partnerId;
    data['partnerName'] = partnerName;
    data['path'] = path;

    return data;
  }
}
