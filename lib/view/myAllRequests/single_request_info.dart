import 'package:flutter/material.dart';
import 'package:lead_gen/view/myAllRequests/request_card.dart';

class MyRequestInfo extends StatelessWidget {
  final String requestText;
  final String locationText;
  final String date;
  final String categoryName;

  const MyRequestInfo({
    required this.requestText,
    required this.locationText,
    required this.date,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0.2,
        title: const Text(
          'Requests Details',
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F3),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Request: $requestText',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              Text(
                'Location: $locationText',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              Text(
                'Date: $date',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              Text(
                'Category: $categoryName',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
