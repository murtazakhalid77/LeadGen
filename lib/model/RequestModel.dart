import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/model/LocationModel.dart';
import 'package:lead_gen/model/category.dart';

class RequestModel {
   String title;
   String description;
   LocationModel locationModel;
   Categoryy? category;
   String number;
   String condition;
   String price;

 RequestModel({
 
    required this.title,
    required this.description,
    required this.locationModel,
    required this.category,
    required this.number,
    required this.condition,
    required this.price,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      title: json['title'] as String,
      description: json['description'] as String,
      locationModel: LocationModel.fromJson(json['locationModel']),
      number: json['number'],
      category: Categoryy.fromJson(json['categoryy']),
      condition: json['condition'] as String,
      price: json['price'] as String,
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'location':locationModel.toJson(),
      'number':number,
      'category': category?.toJson(),
      'condition': condition,
      'price':price
    };
  }
}
