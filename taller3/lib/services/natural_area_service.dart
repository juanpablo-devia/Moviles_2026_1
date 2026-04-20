import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/natural_area.dart';

class NaturalAreaService {
  static Future<List<NaturalArea>> getAll() async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/NaturalArea'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => NaturalArea.fromJson(json)).toList();
  }

  static Future<NaturalArea> getById(int id) async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/NaturalArea/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    return NaturalArea.fromJson(jsonData);
  }
}
