import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sample_tree/config/api_config.dart';
import 'package:sample_tree/main.dart';

class ReviewPostMethod {
  Future<void> postReviewContent(
    String name,
    String phone,
    String email,
    String message,
    int star,
  ) async {
    const String apiKey = 'df504a1a-1490-4029-ad7f-b1b72695099f';
    const endPoint = 'add-reviews';

    try {
      final response = await http.post(
        Uri.parse(Config.apiUrl + endPoint),
        headers: {
          'api-key': apiKey,
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'uid': uid,
          'cust_name': name,
          'cust_phone': phone.toString(),
          'cust_email': email,
          'message': message,
          'no_of_stars': star,
        }),
      );

      if (response.statusCode == 200) {
        print('Content Added');
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
