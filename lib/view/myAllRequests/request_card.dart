import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/view/myAllRequests/single_request_info.dart';

class MyRequestCard extends StatelessWidget {
  final String? requestText;
  final String? locationText;
  final String? date;
  final String categoryName;

  const MyRequestCard({
    required this.requestText,
    required this.locationText,
    required this.categoryName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(date!));

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
             builder: (context) => const MyRequestInfo(requestText: '', locationText: '', date: '', categoryName: '',),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Text(
                _truncateText(requestText!),
                style: const TextStyle(
                  fontSize: 15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                _truncateText(locationText!),
                style: const TextStyle(
                  fontSize: 15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                categoryName,
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

  String _truncateText(String text) {
    if (text.length > 25) {
      return text.substring(0, 25) + '...';
    }
    return text;
  }
}
