import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/president.dart';

class PresidentService {
  static Future<List<President>> getAll() async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/President'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => President.fromJson(json)).toList();
  }

  static Future<President> getById(int id) async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/President/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    return President.fromJson(jsonData);
  }
}
