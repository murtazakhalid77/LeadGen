import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/model/RequestModel.dart';
import 'package:lead_gen/services/HelperService.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/myAllRequests/my_requests.dart';
import 'package:lead_gen/view/myAllRequests/single_request_info.dart';

class MySingleRequestCard extends StatefulWidget {
  final bool option;
  final String email;
  final int? id;
  final String title;
  final String requestText;
  final String locationText;
  final String? date;
  final String categoryName;
  final String? bidAmount; // Add bidAmount parameter

  const MySingleRequestCard({
    Key? key,
    required this.option,
    required this.email,
    required this.id,
    required this.title,
    required this.requestText,
    required this.locationText,
    required this.categoryName,
    required this.date,
    this.bidAmount, // Initialize bidAmount parameter
  }): super(key: key);

  @override
  _MySingleRequestCard createState() => _MySingleRequestCard();
}

class _MySingleRequestCard extends State<MySingleRequestCard> {
  late HelperService helperService;
  RequestModel? request;

  @override
  void initState() {
    super.initState();
    helperService = HelperService();
  }
 
  Future<void> cancelRequest()async {
    try {
      RequestModel? canceledRequest = 
          await helperService.cancelSellerRequest(widget.id);

      if(canceledRequest != null){
        showCustomToast("Request Cancelled");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(option: widget.option, email: widget.email)
              )
          );
      }else{
        showCustomToast('Error fetching Requests');
      }
      
    } catch (error) {
      print('Error fetching Requests: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.date!));

    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 170,
        decoration: BoxDecoration(
          color: Colors.pink.shade200, // Soft blue color for the background
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.shade400.withOpacity(0.4), // Semi-transparent blue shadow
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
                const SizedBox(height: 15),
                const Text(
                  "Title:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Location:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.locationText,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Date:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Category:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.categoryName,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Description:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.requestText,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                
                const SizedBox(height: 50),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )
                          )
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Bid Again",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                          )
                        )
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )
                          )
                        ),
                        onPressed: () {
                          cancelRequest();
                        },
                        child: const Text(
                          "Cancel Request",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                          )
                        )
                      )
                    ],
                  ),
                
                ),
                const SizedBox(height: 20),
               const Text(
                'Bids',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
                if (widget.bidAmount != null) // Display bid amount if available
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Bid Amount: $widget.bidAmount",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
