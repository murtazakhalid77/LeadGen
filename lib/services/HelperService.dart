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
         UrlConfig.buildUri('/userRequest/saverequest'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestModel?.toJson()),
    );

    if (response.statusCode == 200) {
      // Parse the response JSON to a RequestModel object
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      RequestModel updatedRequestModel = RequestModel.fromJson(responseData);

      return updatedRequestModel;
    } else {
      // If the response status code is not 200, handle the error accordingly
      print('Request failed with status: ${response.statusCode}');
      return null; // Return null or throw an appropriate error
    }
  } catch (error) {
    print('Error: $error');
    rethrow; // Rethrow the error to propagate it further
  }
}
}