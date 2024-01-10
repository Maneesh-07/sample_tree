import 'dart:convert';
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
      final responseData = jsonDecode(response.body);

      if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
        if (responseData['data'] is Map<String, dynamic>) {
          // If the response is a map with "data" field as a Map, parse it using GetSuggestion.fromJson
          GetSuggestion suggestion = GetSuggestion.fromJson(responseData['data']);
          return [suggestion];
        } else if (responseData['data'] is String) {
          // If the response is a map with "data" field as a String, create a single GetSuggestion with that data
          GetSuggestion suggestion = GetSuggestion(data: responseData['data']);
          return [suggestion];
        } else {
          // Handle unexpected formats where 'data' is neither a Map nor a String
          throw Exception("Invalid data format. 'data' should be either a Map or a String.");
        }
      } else {
        // Handle unexpected formats where 'data' is not present or not a Map
        throw Exception("Invalid data format. 'data' field not found or not a Map.");
      }
    } else {
      // Handle other status codes
      throw Exception(
          'Failed to fetch data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print(e);
    throw Exception('Error fetching data: $e');
  }
}

}
