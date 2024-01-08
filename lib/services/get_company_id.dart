import 'dart:convert';

import 'package:sample_tree/config/api_config.dart';
import 'package:sample_tree/main.dart';
import 'package:sample_tree/model/get_user_id_model.dart';
import 'package:http/http.dart' as http;

class ApiServicesForLinkLabel {
 

  Future<List<GetCompanies>> fetchDetails() async {
    const String apiKey = 'df504a1a-1490-4029-ad7f-b1b72695099f';
    try {
      final response = await http.get(
        Uri.parse("${Config.apiUrl}get-link-label?uid=$uid"),
        headers: {
          'api-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List) {
          print('API Response: ${response.body}');
          List<GetCompanies> users = responseData
              .map(
                  (json) => GetCompanies.fromJson(json as Map<String, dynamic>))
              .toList();
          return users;
        } else if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          final List<GetCompanies> users = List<GetCompanies>.from(
            responseData['data'].map((json) => GetCompanies.fromJson(json)),
          );
          return users;
        } else {
          print(
              'Invalid data format. Expected a List or a Map with a "data" field.');
          throw Exception('Failed to load users');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get data $e');
    }
  }
}
