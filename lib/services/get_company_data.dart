import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sample_tree/config/api_config.dart';
import 'package:sample_tree/main.dart';
import 'package:sample_tree/model/fetch_companies.dart';

class ApiServicesForCompaniesDetails {
  Future<List<FetchCompanies>> fetchCompanies() async {
    const String apiKey = 'df504a1a-1490-4029-ad7f-b1b72695099f';
    try {
      final response = await http.get(
        Uri.parse("${Config.apiUrl}get-company-data?uid=$uid"),
        headers: {
          'api-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List) {
          print('API Response: ${response.body}');
          List<FetchCompanies> companies = responseData
              .map((json) =>
                  FetchCompanies.fromJson(json as Map<String, dynamic>))
              .toList();
          return companies;
        } else if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          final List<FetchCompanies> companies = [
            FetchCompanies.fromJson(
                responseData['data'] as Map<String, dynamic>)
          ];
          return companies;
        } else {
          print(
              'Invalid data format. Expected a List or a Map with a "data" field.');
          throw Exception('Failed to load companies');
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
