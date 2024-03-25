import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/view/myAllRequests/single_request_info.dart';

class MySingleRequestCard extends StatelessWidget {
  final String? title;
  final String requestText;
  final String? locationText;
  final String? date;
  final String categoryName;

  const MySingleRequestCard({
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
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-170,
        decoration: BoxDecoration(
          color: Colors.blue.shade200, // Soft blue color for the background
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade400.withOpacity(0.6), // Semi-transparent blue shadow
              spreadRadius: 4,
              blurRadius: 10,
              offset: Offset(0, 4), // Slightly shifted shadow for a lifted effect
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "$title",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                const Text(
                  "Location:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "$locationText",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Date:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Category:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  categoryName,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Description:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "$requestText",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      child: Text(
                        "Bid Again",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white
                        )
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                        )
                      ),
                      onPressed: () {}
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      child: Text(
                        "Cancel Requset",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white
                        )
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                        )
                      ),
                      onPressed: () {}
                    )
                  ],
                )
                
              ],
            ),
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
