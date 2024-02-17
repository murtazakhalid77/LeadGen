  import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/model/LocationModel.dart';
  
  import 'package:lead_gen/model/category.dart';

  class RequestModel {
    String title;
    String description;
    LocationModel locationModel;
    Categoryy? category;

    String createdDate;
    String price;

  RequestModel({
  
      required this.title,
      required this.description,
      required this.locationModel,
      required this.category,
    
      // required this.condition,
      required this.price,
      required this.createdDate
    });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      locationModel: LocationModel.fromJson(json['locationModel'] ?? {}),
      category: Categoryy.fromJson(json['categoryy'] ?? {}) , // Provide a default category if null
      createdDate: json['createdDate'] as String? ?? '',
      
    
      price: json['price'] as String? ?? '',
    );
  }

    Map<String, dynamic> toJson() {
      return {
        'title': title,
        'description': description,
        'location':locationModel.toJson(),
      'createdDate':createdDate,
        'category': category?.toJson(),
        // 'condition': condition,
        'price':price
      };
    }
  }
