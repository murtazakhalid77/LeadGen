import 'package:flutter/material.dart';
import 'package:lead_gen/view/myAllRequests/request_card.dart';

class MyRequestInfo extends StatefulWidget {
  const MyRequestInfo({super.key});

  @override
  State<MyRequestInfo> createState() => _MyRequestInfoState();
}

class _MyRequestInfoState extends State<MyRequestInfo> {
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
        child: SizedBox(
          height: 500,
          width: 300,
          child: MyRequestCard(
                      imagePath: 'lib/assets/cars.png',
                      requestText: 'I want a Civic car in white color.',
                      locationText: 'Khayaban e Mujahid, Defence.',
                      date: DateTime.now(),
                    ),
        ),
      ),
    );
  }
}