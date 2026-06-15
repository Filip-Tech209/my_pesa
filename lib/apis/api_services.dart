import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:my_pesa/models/data_model.dart';

class ApiService {
  final String _apiUrl = "https://script.google.com/macros/s/AKfycbz4qO4YPxE50ndFGo2dtbEUvU_1gc2VycPEqMIIAHju_KFyABjbHctDSDojHnd2Fh2K/exec";

  Future<UserAccount> fetchAccountData() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        // Check if there's an error message from the script
        if (jsonResponse.containsKey('error')) {
          throw Exception(jsonResponse['error']);
        }
        
        return UserAccount.fromJson(jsonResponse);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}