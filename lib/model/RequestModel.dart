import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/model/LocationModel.dart';

import 'package:lead_gen/model/category.dart';

class RequestModel {
  String title;
  String description;
  String? locationModel;
  String condition;
  Categoryy? category;
  String? number;
  String createdDate;
  String price;

  RequestModel(
      {required this.title,
      required this.description,
      required this.locationModel,
      required this.category,
      required this.condition,
      required this.price,
      required this.number,
      required this.createdDate});

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      condition: json['condition'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      locationModel: json['locationModel'] as String? ?? '',
      category: Categoryy.fromJson(
          json['categoryy'] ?? {}), 
          
          number: json['number'] as String? ?? '',
      createdDate: json['createdDate'] as String? ?? '',

      price: json['price'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'locationModel': locationModel,
      'createdDate': createdDate,
      'categoryy': category?.toJson(),
      'number':number,
      'condition': condition,
      'price': price
    };
  }
}
