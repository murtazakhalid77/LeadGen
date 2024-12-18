import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/services/ChatService.dart';
import 'package:lead_gen/view/Chats/person_chat.dart';
import 'package:lead_gen/view/seller/Seller-Single-Request.dart';

class SellerCard extends StatefulWidget {
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
  _SellerCardState createState() => _SellerCardState();
}

class _SellerCardState extends State<SellerCard> {
  double? bidAmount = 0;
  double? buyerBidAmount = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialBidAmount();
  }

  Future<void> _loadInitialBidAmount() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    // Get the current user
    User? currentUser = firebaseAuth.currentUser;

    if (currentUser != null) {
      // Get the bid amount and buyer bid amount for the current user from Firestore
      DocumentSnapshot bidSnapshot = await firestore
          .collection('requests')
          .doc(widget.requestId)
          .collection('bids')
          .doc(currentUser.uid)
          .get();

      if (bidSnapshot.exists) {
        setState(() {
          bidAmount = bidSnapshot['amount'] ?? 0;
          buyerBidAmount = bidSnapshot['buyerBid'] ?? 0; // Fetch the buyerBid amount
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Convert date string to DateTime and format it
    final DateTime dateTime = DateTime.parse(widget.date);
    final String formattedDate = DateFormat('MMMM d, yyyy').format(dateTime);

    return GestureDetector(
      onLongPressStart: (details) {
        Navigator.of(context).push(_buildPreviewRoute(context));
      },
      onLongPressEnd: (details) {
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.isSellerAccepted
                ? Colors.green.shade100
                : Colors.blue.shade100, // Conditionally set the background color
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
                    widget.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade400,
                    ),
                  ),
                  if (widget.isSellerAccepted)
                    IconButton(
                      onPressed: () {
                        print(widget.buyerEmail);
                        print(widget.buyerUid);
                        sendMessage(context, widget.description, widget.buyerEmail, widget.buyerUid);
                      },
                      icon: Icon(
                        Icons.message,
                        color: Colors.green,
                      ),
                      iconSize: 24,
                    ),
                  if (widget.isSellerAccepted)
                    Text(
                      'Accepted Amount: \$${widget.acceptedAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green, // Customize the color for the accepted amount
                      ),
                    ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                widget.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 5),
              Text(
                'Location: ${widget.locationText}',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black87),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category: ${widget.category}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Text(
                    'Price: \$${widget.price}', // Display price with currency symbol
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                'Date: $formattedDate', // Display formatted date
                style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              Text(
                'Last Offer: \$${bidAmount?.toStringAsFixed(2)}', // Display the current bid amount
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              if (buyerBidAmount != 0)
                SizedBox(height: 5),
                Text(
                  'Buyer Reply: \$${buyerBidAmount?.toStringAsFixed(2)}', // Display the buyer's bid amount
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo, // Customize the color for the buyer bid amount
                  ),
                ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: widget.isSellerAccepted
                        ? null
                        : () {
                            _showOfferDialog(
                                context, widget.requestId, double.parse(widget.price));
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route _buildPreviewRoute(BuildContext context) {
    return PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.5),
            body: Center(
              child: SellerSingleRequest(
                firstName: widget.name,
                description: widget.description,
                locationText: widget.locationText,
                isSellerAccepted: widget.isSellerAccepted,
                requestId: widget.requestId,
                price: widget.price,
              ),
            ),
          ),
        );
      },
    );
  }

  void sendMessage(BuildContext context, String requestDescription,
      String receiveUserEmail, String receivedUserId) async {
    String message =
        "Hey, I heard about you needing this: \"$requestDescription\". Can we talk?";
    ChatService chatService = ChatService();
    print(receivedUserId);
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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.white,
          elevation: 10.0,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter Your Offer',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Offer must be between \$${minOffer.toStringAsFixed(2)} and \$${maxOffer.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: offerController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Retrieve the bid amount from the offer controller
                        double? offerAmount = double.tryParse(offerController.text);

                        // If the bid amount is valid and within the range, call addBidToRequest
                        if (offerAmount != null &&
                            offerAmount >= minOffer &&
                            offerAmount <= maxOffer) {
                          addBidToRequest(requestId, offerAmount);
                          // Update the bid amount state
                          setState(() {
                            bidAmount = offerAmount;
                          });
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
                ),
              ],
            ),
          ),
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
          'buyerBid': amount, // Add buyerBid to Firestore
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
