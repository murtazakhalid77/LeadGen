import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/view/seller/Seller-Single-Request.dart';

class SellerCard extends StatelessWidget {
  final String requestId;
  final String title;
  final String name;
  final String description;
  final String locationText;
  final String price;
  final String date;
  final String? category;
  final String accept;
  

  const SellerCard({
  
    required this.name,
    required this.description,
    required this.locationText,
    required this.price,
    required this.date,
    required this.category,
    required this.title,
    required this.accept,
  required this.requestId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert date string to DateTime and format it
    final DateTime dateTime = DateTime.parse(date);
    final String formattedDate = DateFormat('MMMM d, yyyy').format(dateTime);

    return InkWell(
      onTap: () {
        // Handle card tap
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SellerSingleRequest(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  
                ],
              ),
              SizedBox(height: 5),
              Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: 5),
              Text(
                'Location: $locationText',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category: $category',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Text(
                    'Price: \$${price}', // Display price with currency symbol
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                'Date: $formattedDate', // Display formatted date
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                  TextButton(
                    onPressed: () {
                         _showOfferDialog(context, requestId);
                    },
                    child: Text(
                      'Offer',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                 
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle deny button tap
                    },
                    child: Text(
                      'Deny',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
   void _showOfferDialog(BuildContext context, String requestId) {
    TextEditingController offerController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Your Offer'),
          content: TextField(
            controller: offerController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Retrieve the bid amount from the offer controller
                double? bidAmount = double.tryParse(offerController.text);

                // If the bid amount is valid, call addBidToRequest
                if (bidAmount != null) {
                  // Call addBidToRequest with the provided requestId and bid amount
                  addBidToRequest(requestId, bidAmount);
                }

                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog without any action
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> addBidToRequest(String requestId, double amount) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    // Get the current user
    User? currentUser = firebaseAuth.currentUser;

    if (currentUser != null) {
      // Get the current user's UID
      String userId = currentUser.uid;

      try {
        // Add a bid document to the specific request's bids subcollection
        await firestore.collection('requests').doc(requestId).collection('bids').doc(userId).set({
          'userName':currentUser.email,
          'amount': amount,
          'timestamp': FieldValue.serverTimestamp(),
        });

        print('Bid added to request ID: $requestId for user ID: $userId');
      } catch (e) {
        print('Error adding bid to request: $e');
      }
    } else {
      print('User not authenticated');
    }
  }
}
