import 'package:lead_gen/model/Subcategory.dart';
class Categoryy {
  final int id;
  final String name;


  Categoryy(this.id, this.name);

  factory Categoryy.fromJson(Map<String, dynamic> json) { 
    return Categoryy(
      json['id'] as int,
      json['categoryName'] as String,
    
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'categoryName': name
    };
  }
}
