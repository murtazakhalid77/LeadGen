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
  String accepted;
  User? acceptedSeller;
  int acceptedAmount;
  bool status;

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
      required this.accepted,
      required this.acceptedSeller,
      required this.acceptedAmount,
      required this.status,
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
      accepted:  json['accepted'] as String ??'',
      price: json['price'] as String? ?? '',
      acceptedSeller:  User.fromJson(json['acceptedSeller'] ?? {}), 
      acceptedAmount: json['acceptedAmount'] as int? ?? 0,
      status: json['status'] as bool? ?? true  ,
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
      'accepted': accepted,
      'acceptedSeller':acceptedSeller,
      'acceptedAmount':acceptedAmount,
      'price': price,
      'status': status
    };
  }
}
