import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/view/myAllRequests/single_request_info.dart';

class MyRequestCard extends StatelessWidget {
  final String imagePath;
  final String requestText;
  final String locationText;
  final DateTime date;

  const MyRequestCard({
    required this.imagePath,
    required this.requestText,
    required this.locationText,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);

    return InkWell(
     onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MyRequestInfo(), 
         ),
       );
     },
      child: Container(
        width: 180,
        height: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                height: 90,
              ),
              const SizedBox(height: 6),
              Text(
                requestText,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                locationText,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              // Display the current date
              Text(
                'Date: $formattedDate',
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
