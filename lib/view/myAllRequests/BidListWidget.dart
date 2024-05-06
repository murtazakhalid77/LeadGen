import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/services/HelperService.dart';

class BidListWidget extends StatelessWidget {
  final String requestId;

  const BidListWidget({required this.requestId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bids for Request ID: $requestId'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('requests')
            .doc(requestId)
            .collection('bids')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading bids: ${snapshot.error}'),
            );
          }

          final bidDocs = snapshot.data?.docs ?? [];

          if (bidDocs.isEmpty) {
            return Center(
              child: Text('No bids yet.'),
            );
          }

          return ListView.builder(
            itemCount: bidDocs.length,
            itemBuilder: (context, index) {
              final bidDoc = bidDocs[index];
              final bidData = bidDoc.data() as Map<String, dynamic>;
              final bidAmount = bidData['amount'] as double?;
              final bidTimestamp = bidData['timestamp'] as Timestamp?;
              final accepted = bidData['accepted'] as bool?;
              final userName = bidData['userName'] as String?;

              // Format the bid timestamp to a readable date
              final bidDate = bidTimestamp != null
                  ? DateFormat('dd-MM-yyyy HH:mm').format(bidTimestamp.toDate())
                  : '';

              // Use a GestureDetector to detect long press
              return GestureDetector(
                onLongPress: () {
                  // Show a dialog with an "Accept" button when long press is detected
                  _showAcceptDialog(context, bidDoc.id);
                },
                child: ListTile(
                  title: Text(
                    'Bid Amount: \$${bidAmount?.toStringAsFixed(2) ?? 'N/A'}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bid Date: $bidDate'),
                      if (userName != null)
                        Text('Bidder: $userName'),
                      if (accepted == true) // Show accepted status if true
                        Text('Status: Accepted', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Function to show the "Accept" dialog
    void _showAcceptDialog(BuildContext context, String bidId) {
    // Create an instance of HelperService
    HelperService helperService = HelperService();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Accept Bid'),
          content: Text('Do you want to accept this bid?'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog without accepting the bid
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Call acceptRequest from HelperService to accept the request
                  bool success = await helperService.acceptRequest(requestId);

                  // If the request is accepted successfully, update Firestore
                  if (success) {
                    await FirebaseFirestore.instance
                        .collection('requests')
                        .doc(requestId)
                        .collection('bids')
                        .doc(bidId)
                        .update({'accepted': true});
                  }

                  // Close the dialog after accepting the bid
                  Navigator.of(context).pop();
                } catch (error) {
                  print('Error accepting bid: $error');
                  // Optionally, display an error message to the user
                }
              },
              child: Text('Accept'),
            ),
          ],
        );
      },
    );
  }
  
}
