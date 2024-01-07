import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/model/Subcategory.dart';
import 'package:lead_gen/model/category.dart';
import 'package:http/http.dart' as http;


class CategoryService extends ChangeNotifier {
Future<List<Categoryy>> fetchCategories() async {
    try {
      final response = await http.get(
         UrlConfig.buildUri('category/getAll'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
      
        List<Categoryy> fetchCats = (jsonDecode(response.body) as List)
            .map((data) => Categoryy.fromJson(data))
            .toList();
        return fetchCats;
      } else {
        print('Failed to fetch categories: ${response.statusCode}');
        return []; 
      }
    } catch (error) {
      print('Error fetching categories: $error');
      return [];
    }
  
}
Future<List<Map<dynamic, dynamic>>> fetchCategoriesForHomePage() async {
  try {
    final response = await http.get(
      UrlConfig.buildUri('category/getAll'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> fetchedCategories = jsonDecode(response.body) as List<dynamic>;
      return fetchedCategories.cast<Map<dynamic, dynamic>>();
    } else {
      print('Failed to fetch categories: ${response.statusCode}');
      return [];
    }
  } catch (error) {
    print('Error fetching categories: $error');
    return [];
  }
}



Future<List<SubCategory>> fetchSubCat(String? subcat) async {
   
    try {
      final response = await http.get(
        UrlConfig.buildUri('subcategory/getByName/$subcat'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        List<SubCategory> fetchedSubCategories = (jsonDecode(response.body) as List)
            .map((data) => SubCategory.fromJson(data))
            .toList();
        return fetchedSubCategories;
      } else {
        print('Failed to fetch subcategories: ${response.statusCode}');
        return []; // Return an empty list if there's an issue with the API call
      }
    } catch (error) {
      print('Error fetching subcategories: $error');
      return []; // Return an empty list in case of error
    }
  }
  
}
