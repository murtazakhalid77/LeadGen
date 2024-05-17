import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/services/ChatService.dart';
import 'package:lead_gen/view/Chats/person_chat.dart';
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
  final bool isSellerAccepted; // New parameter
  final int acceptedAmount;
  final String buyerUid;
  final String buyerEmail;

  const SellerCard({
    required this.name,
    required this.description,
    required this.locationText,
    required this.price,
    required this.date,
    required this.category,
    required this.title,
    required this.requestId,
    required this.acceptedAmount,
    required this.isSellerAccepted,
    required this.buyerEmail,
    required this.buyerUid,
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
            color: isSellerAccepted
                ? Colors.green.shade100
                : Colors
                    .blue.shade100, // Conditionally set the background color
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
                  if (isSellerAccepted)
                    IconButton(
                      onPressed: () {
                        print(buyerEmail);
                        print(buyerUid);
                        sendMessage(context, description, buyerEmail, buyerUid);
                      },
                      icon: Icon(
                        Icons.message,
                        color: Colors.green,
                      ),
                      iconSize: 24,
                    ),
                  if (isSellerAccepted)
                    Text(
                      'Accepted Amount: \$${acceptedAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .green, // Customize the color for the accepted amount
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
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category: $category',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
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
                    onPressed: isSellerAccepted
                        ? null
                        : () {
                            _showOfferDialog(
                                context, requestId, double.parse(price));
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // ElevatedButton(
                  //   onPressed: isSellerAccepted
                  //       ? null
                  //       : () {
                  //           // Handle deny button tap
                  //         },
                  //   child: Text(
                  //     'Deny',
                  //     style: TextStyle(
                  //       fontSize: 14,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.blue,
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 16, vertical: 8),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendMessage(BuildContext context, String requestDescription,
      String receiveUserEmail, String receivedUserId) async {
    String message =
        "Hey, I heard about you needing this: \"$requestDescription\". Can we talk?";
    ChatService chatService = new ChatService();
    // Send the predefined message using the ChatService
    await chatService.sendMessage(receivedUserId, message);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          receiveUserEmail: receiveUserEmail,
          receivedUserId: receivedUserId,
        ),
      ),
    );
  }

  void _showOfferDialog(BuildContext context, String requestId, double price) {
    TextEditingController offerController = TextEditingController();
    double minOffer = price * 0.9; // Minimum 90% of the price
    double maxOffer = price * 1.1; // Maximum 110% of the price

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Your Offer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Offer must be between \$${minOffer.toStringAsFixed(2)} and \$${maxOffer.toStringAsFixed(2)}',
              ),
              SizedBox(height: 10),
              TextField(
                controller: offerController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Retrieve the bid amount from the offer controller
                double? bidAmount = double.tryParse(offerController.text);

                // If the bid amount is valid and within the range, call addBidToRequest
                if (bidAmount != null &&
                    bidAmount >= minOffer &&
                    bidAmount <= maxOffer) {
                  addBidToRequest(requestId, bidAmount);
                  // Close the dialog
                  Navigator.of(context).pop();
                } else {
                  // Show an error message if the amount is out of range
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Please enter an amount between \$${minOffer.toStringAsFixed(2)} and \$${maxOffer.toStringAsFixed(2)}'),
                    ),
                  );
                }
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
        await firestore
            .collection('requests')
            .doc(requestId)
            .collection('bids')
            .doc(userId)
            .set({
          'userName': currentUser.email,
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
