import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/view/myAllRequests/single_request_info.dart';

class MyRequestCard extends StatelessWidget {
  final String? title;
  final String? requestText;
  final String? locationText;
  final String? date;
  final String categoryName;

  const MyRequestCard({
    required this.title,
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
            builder: (context) => MyRequestInfo(
              title: title!,
              requestText: requestText!,
              locationText: locationText!,
              date: date!,
              categoryName: categoryName,
            ),
          ),
        );
      },
      child: Container(
        width: 180,
        height: 220,
        decoration: BoxDecoration(
          color: Colors.blue.shade200, // Soft blue color for the background
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade400.withOpacity(0.5), // Semi-transparent blue shadow
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 4), // Slightly shifted shadow for a lifted effect
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _truncateText(title!),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                _truncateText(requestText!),
                style: const TextStyle(
                  fontSize: 15,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                _truncateText(locationText!),
                style: const TextStyle(
                  fontSize: 15,
                ),
                maxLines: 1,
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
    // if (text.length > 25) {
    //   return text.substring(0, 25) + '...';
    // }
    return text;
  }
}
