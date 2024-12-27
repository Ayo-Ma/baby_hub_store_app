import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryModel {
  String id;
  String name;
  String imageUrl;

  CategoryModel({required this.id, required this.name, required this.imageUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'].toString(), // Convert id to string
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}

Future<List<CategoryModel>> fetchCategories() async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/categories/AllCategory'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}
