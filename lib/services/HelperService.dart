import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/model/ProfanityCheckResponse.dart';
import 'package:lead_gen/model/RequestModel.dart';
import 'package:lead_gen/model/Review.dart';
import 'package:lead_gen/model/SummaryDto.dart';

class HelperService extends ChangeNotifier {
  Future<RequestModel?> cancelSellerRequest(int? id) async {
    try {
      final response = await http.put(
        UrlConfig.buildUri('userRequest/cancelRequest/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
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
      print('Error fetching request: $error');
    }
  }

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
        print(
            'Failed to decode JSON: Response body is null or not in expected format');
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
        print(
            'Failed to decode JSON: Response body is null or not in expected format');
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

  Future<bool> acceptRequest(String RequestId, String? emailOFAcceptedSeller,
      double? bidAmount) async {
    try {
      final response = await http.post(
          UrlConfig.buildUri(
              'userRequest/accept/$RequestId/$emailOFAcceptedSeller/$bidAmount'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
    }
  Future<SummarDto?> getSummary(String emailOFSeller) async {
    try {
      final response = await http.get(
        UrlConfig.buildUri('userReviews/rate/$emailOFSeller'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Assuming the response body contains the summary data in JSON format
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return SummarDto.fromJson(jsonResponse); // Assuming SummaryDto has a fromJson constructor
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to fetch summary');
      }
    } catch (error) {
      print('Error: $error');
      rethrow; // Rethrow the error to propagate it to the caller
    }
  }


 Future<bool> rateUser(String emailOFSeller, int? requestId, int rating, String note) async {
  try {
    final response = await http.post(
      UrlConfig.buildUri('userReviews/rate/$requestId/$emailOFSeller/$rating/$note'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse['result']; // Assuming the response contains a 'result' field indicating success or failure
    } else {
      print('Request failed with status: ${response.statusCode}');
      return false; // Return false or handle the failure accordingly
    }
  } catch (error) {
    print('Error: $error');
    rethrow; // Rethrow the error to propagate it to the caller
  }
}


  Future<List<Review>> getReviews(String emailOFSeller) async {
    try {
      final response = await http.get(
       UrlConfig.buildUri('userReviews/reviews/$emailOFSeller'), // Replace with your actual API URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((reviewJson) => Review.fromJson(reviewJson)).toList();
      } else {
        print('Request failed with status: ${response.statusCode}');
        return []; // Return an empty list on failure
      }
    } catch (error) {
      print('Error: $error');
      rethrow; // Rethrow the error to propagate it to the caller
    }
  }

}
