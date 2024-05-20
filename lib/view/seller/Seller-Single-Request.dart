import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lead_gen/view/seller/Seller-All-Request.dart';

class SellerSingleRequest extends StatelessWidget {
  final String? firstName;
  final String? description;
  final String? locationText;
  final bool? isSellerAccepted;
  final String? requestId;
  final String? price;

  const SellerSingleRequest({
    Key? key,
    this.firstName,
    this.isSellerAccepted,
    this.description,
    this.locationText,
    this.requestId,
    this.price,
  }) : super(key: key);

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
                builder: (context) => const AllRequest(
                  bidAmount: null,
                ),
              ),
            );
          },
        ),
        backgroundColor: Colors.blue,
        elevation: 0.2,
        title: const Text('Request Details'),
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isSellerAccepted != null && isSellerAccepted!
                          ? [Colors.green.shade100, Colors.green.shade200]
                          : [Colors.blue.shade100, Colors.blue.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 4,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "First Name",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          firstName ?? "N/A",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          description!,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          locationText ?? "N/A",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.deepPurple,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                ),
                                onPressed: isSellerAccepted!
                                    ? null
                                    : () {
                                        _showOfferDialog(context, requestId!,
                                            double.parse(price!));
                                      },
                                child: const Text(
                                  "Offer",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
