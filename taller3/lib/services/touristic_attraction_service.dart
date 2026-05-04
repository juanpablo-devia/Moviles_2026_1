import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/touristic_attraction.dart';

class TouristicAttractionService {
  static Future<List<TouristicAttraction>> getAll() async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/TouristicAttraction'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => TouristicAttraction.fromJson(json)).toList();
  }

  static Future<TouristicAttraction> getById(int id) async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/TouristicAttraction/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    return TouristicAttraction.fromJson(jsonData);
  }
}
