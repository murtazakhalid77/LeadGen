import 'package:flutter/material.dart';

class Categoryy {
  final int? id;
  final String? name;
  final String? icon;
  final String? backgroundColor;

  Categoryy({
    required this.id,
    required this.name,
    required this.icon,
    required this.backgroundColor,
  });

factory Categoryy.fromJson(Map<String, dynamic> json) {
  return Categoryy(
    id: json['id'] as int?, 
    name: json['categoryName'] as String?,
    icon: json['icon'] as String?,
    backgroundColor: json['backgroundColor'] as String?
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryName': name,
      // Add other properties to the JSON if needed
    };
  }
}
