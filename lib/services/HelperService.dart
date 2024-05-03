import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/model/ProfanityCheckResponse.dart';
import 'package:lead_gen/model/RequestModel.dart';

class HelperService extends ChangeNotifier {


Future<RequestModel?> requestPost(RequestModel? requestModel) async {
  try {
    final response = await http.post(
         UrlConfig.buildUri('userRequest/saverequest'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestModel?.toJson()),
    );

    if (response.statusCode == 200) {
  
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      RequestModel updatedRequestModel = RequestModel.fromJson(responseData);

      return updatedRequestModel;
    } else {
      
      print('Request failed with status: ${response.statusCode}');
      return null; 
    }
  } catch (error) {
    print('Error: $error');
    rethrow; 
  }
}


Future<List<RequestModel>> fetchUserRequest(String email) async {
  try {
    final response = await http.get(
       UrlConfig.buildUri('userRequest/getAllUserRequests/$email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Check for null response body
      if (response.body != null) {
        List<dynamic>? fetchedRequest = jsonDecode(response.body);
        if (fetchedRequest != null) {
          List<RequestModel> requestList = fetchedRequest
              .map((data) => RequestModel.fromJson(data))
              .toList();
          return requestList;
        }
      }
      print('Failed to decode JSON: Response body is null or not in expected format');
      return [];
    } else {
      print('Failed to fetch request: ${response.statusCode}');
      return [];
    }
  } catch (error) {
    print('Error fetching request: $error');
    return [];
  }

}
  Future<List<RequestModel>> fetchSellerRequest(String categoryName) async {
  try {
    final response = await http.get(
      UrlConfig.buildUri('userRequest/getAllSellerRequest/$categoryName'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Check for null response body
      if (response.body != null) {
        List<dynamic>? fetchedRequest = jsonDecode(response.body);
        if (fetchedRequest != null) {
          List<RequestModel> requestList = fetchedRequest
              .map((data) => RequestModel.fromJson(data))
              .toList();
          return requestList;
        }
      }
      print('Failed to decode JSON: Response body is null or not in expected format');
      return [];
    } else {
      print('Failed to fetch request: ${response.statusCode}');
      return [];
    }
  } catch (error) {
    print('Error fetching request: $error');
    return [];
  }
}






}