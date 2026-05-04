import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/department.dart';

class DepartmentService {
  static Future<List<Department>> getAll() async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/Department'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Department.fromJson(json)).toList();
  }

  static Future<Department> getById(int id) async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/Department/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    return Department.fromJson(jsonData);
  }
}
