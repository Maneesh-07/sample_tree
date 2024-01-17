import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_tree/config/api_config.dart';
import 'package:sample_tree/main.dart';
import 'package:sample_tree/model/suggestion_model.dart';


class ApiServicesSuggestionDetails {
 Future<List<GetSuggestion>> fetchSuggestion() async {
  const String apiKey = 'df504a1a-1490-4029-ad7f-b1b72695099f';
  try {
    final response = await http.get(
      Uri.parse("${Config.apiUrl}add-suggestion?uid=$uid"),
      headers: {
        'api-key': apiKey,
      },
    );

   if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List) {
          print('API Response: ${response.body}');
          List<GetSuggestion> companies = responseData
              .map((json) =>
                  GetSuggestion.fromJson(json as Map<String, dynamic>))
              .toList();
          return companies;
        } else if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          final List<GetSuggestion> companies = [
            GetSuggestion.fromJson(
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
      Align(
        alignment: Alignment.center,
        child: Center(
        child: throw Exception('Failed to get data $e'),
      
        ),
      );
    }
}


}
