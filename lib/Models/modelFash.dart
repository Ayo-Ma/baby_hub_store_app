import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AppModel {
  final String name;
  final String description;
  final String image;
  final String uploadedBy;
  final int quantity;
  final double price;
  final List<Color> fcolor;
  final List<String> size;
  final String category;
  final List<Review> reviews;
  final bool isFeatured;

  AppModel({
    required this.name,
    required this.description,
    required this.image,
    required this.uploadedBy,
    required this.quantity,
    required this.price,
    required this.fcolor,
    required this.size,
    required this.category,
    required this.reviews,
    required this.isFeatured,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      uploadedBy: json['uploadedBy'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0.0,
      fcolor: (json['fColor'] as String)
          .split(',')
          .map((color) => Color(int.parse(color)))
          .toList(),
      size: (json['fSize'] as String).split(',').toList(),
      category: json['category']['name'] ?? '',
      reviews: (json['reviews'] as List)
          .map((review) => Review.fromJson(review))
          .toList(),
      isFeatured: json['isFeatured'] ?? false,
    );
  }
}

class Review {
  final String comment;
  final int rating;

  Review({
    required this.comment,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      comment: json['comment'] ?? '',
      rating: json['rating'] ?? 0,
    );
  }
}

Future<List<AppModel>> fetchProducts() async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/products/getAll'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => AppModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
