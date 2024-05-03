import 'package:flutter/material.dart';
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/myAllRequests/request_card.dart';
import 'package:lead_gen/view/myAllRequests/single_request_card.dart';

class MyRequestInfo extends StatelessWidget {
  final String? title;
  final String? requestText;
  final String? locationText;
  final String? date;
  final String? categoryName;

  const MyRequestInfo({
    required this.title,
    required this.requestText,
    required this.locationText,
    required this.date,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (context) => MyHomePage(option: true, email: '',), // goes to home page
              ),
            );
          },
        ),
        backgroundColor: Colors.lightBlue,
        elevation: 0.2,
        title: const Text(
          'Requests Details',
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F3),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [ 
                      MySingleRequestCard(
                          title: title,
                          requestText: requestText!,
                          locationText: locationText!,
                          date: date!,
                          categoryName: categoryName!)
                          ],
      
                    //  fetchedRequests.map((request) {
                    //   String locationText = '${request.locationModel.administrativeArea ?? ''} '
                    //       '${request.locationModel.street ?? ''} '
                    //       '${request.locationModel.subLocality ?? ''}';
      
                    //   String categoryName = request.category!.name ?? '';
                    //   return MyRequestCard(
                    //       title: request.title,
                    //       requestText: request.description,
                    //       locationText: locationText,
                    //       date: request.createdDate,
                    //       categoryName: categoryName);
                    // }).toList(),
                  ),
                ),
             /*   Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle Close Request button action
                      },
                      child: const Text('Close Request'),
                    ),
                    const SizedBox(width: 20), // Adjust spacing between buttons
                    ElevatedButton(
                      onPressed: () {
                        // Handle Show Bids button action
                      },
                      child: const Text('Show Bids'),
                    ),
                  ],
                ),*/
                
                // Text(
                //   'Request: $requestText',
                //   style: const TextStyle(fontSize: 18),
                // ),
                // const SizedBox(height: 12),
                // Text(
                //   'Location: $locationText',
                //   style: const TextStyle(fontSize: 18),
                // ),
                // const SizedBox(height: 12),
                // Text(
                //   'Date: $date',
                //   style: const TextStyle(fontSize: 18),
                // ),
                // const SizedBox(height: 12),
                // Text(
                //   'Category: $categoryName',
                //   style: const TextStyle(fontSize: 18),
                // ),
              ],        
            ),
          ),
        ),
      ),
    );
  }
}
