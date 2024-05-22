import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/view/myAllRequests/single_request_info.dart';

class MyRequestCard extends StatelessWidget {
  final bool? option;
  final String? email;
  final int? id;
  final String? title;
  final String? requestText;
  final String? locationText;
  final String? date;
  final String categoryName;
  final String accepted;
  final String acceptedSellerEmail;
  final String acceptedSellerUid;
  final bool status;

  const MyRequestCard(
      {required this.option,
      required this.email,
      required this.id,
      required this.title,
      required this.requestText,
      required this.locationText,
      required this.categoryName,
      required this.date,
      required this.accepted, 
      required this.acceptedSellerEmail,
      required this.status,
      required this.acceptedSellerUid});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(date!));

    return InkWell(
      onTap: () {
    
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MyRequestInfo(
              option: option!,
              email: email!,
              accepted:accepted,
              id: id!,
              title: title!,
              requestText: requestText!,
              locationText: locationText!,
              date: date!,
              categoryName: categoryName,
              requestId: id.toString(),
              acceptedSellerEmail:acceptedSellerEmail,
              acceptedSellerUid:acceptedSellerUid,
              status: status,

            ),
          ),
        );
      },
      child: Container(
        width: 180,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _getBoxShadows(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                _truncateText(title!),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
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

  List<BoxShadow> _getBoxShadows() {
    if (!status) {
      return [
        BoxShadow(
          color: Colors.red.withOpacity(1),
          spreadRadius: 3,
          blurRadius: 6,
          offset: Offset(0, 4),
        ),
      ];
    }

    return accepted == "true"
        ? [
            BoxShadow(
              color: Colors.green.shade400.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ]
        : [
            BoxShadow(
              color: Colors.pink.shade400.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ];
  }

  String _truncateText(String text) {
    // if (text.length > 25) {
    //   return text.substring(0, 25) + '...';
    // }
    return text;
  }
}
