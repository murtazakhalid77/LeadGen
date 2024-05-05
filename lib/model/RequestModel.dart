import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/model/LocationModel.dart';
import 'package:lead_gen/model/UserDto.dart';

import 'package:lead_gen/model/category.dart';

class RequestModel {
  int id;
  String title;
  String description;
  String? locationModel;
  String condition;
  Categoryy? category;
  User? user;
  String? email;
  String createdDate;
  String price;

  RequestModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.locationModel,
      required this.category,
      required this.condition,
      required this.price,
      required this.email,
      required this.createdDate,
      this.user});

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'] as int,
      condition: json['condition'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      locationModel: json['locationModel'] as String? ?? '',
      category: Categoryy.fromJson( json['categoryy'] ?? {}), 
           user: User.fromJson(json['user'] ?? {}), 
          email: json['email'] as String? ?? '',
      createdDate: json['createdDate'] as String? ?? '',

      price: json['price'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'locationModel': locationModel,
      'createdDate': createdDate,
      'categoryy': category?.toJson(),
      'email':email,
      'user':user?.toJson(),
      'condition': condition,
      'price': price
    };
  }
}
