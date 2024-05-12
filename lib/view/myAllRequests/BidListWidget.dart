import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/services/HelperService.dart';

class BidListWidget extends StatefulWidget {
  final String requestId;

  const BidListWidget({required this.requestId, Key? key}) : super(key: key);

  @override
  _BidListWidgetState createState() => _BidListWidgetState();
}

class _BidListWidgetState extends State<BidListWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<DocumentSnapshot> _bids = [];

  @override
  void initState() {
    super.initState();
    // Listen to changes in the bids subcollection
    FirebaseFirestore.instance
        .collection('requests')
        .doc(widget.requestId)
        .collection('bids')
        .orderBy('amount', descending: false) // Sort by amount in ascending order
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      _updateList(snapshot.docs);
    });
  }

  // Function to update the list with animations
  void _updateList(List<DocumentSnapshot> newDocs) {
    // Determine the changes in the list
    for (int i = 0; i < _bids.length; i++) {
      if (!newDocs.contains(_bids[i])) {
        _removeItem(i);
        i--;
      }
    }

    for (int i = 0; i < newDocs.length; i++) {
      if (!_bids.contains(newDocs[i])) {
        _insertItem(i, newDocs[i]);
      }
    }

    _bids = newDocs;
  }

  // Function to insert an item with animation
  void _insertItem(int index, DocumentSnapshot doc) {
    _bids.insert(index, doc);
    _listKey.currentState?.insertItem(index);
  }

  // Function to remove an item with animation
  void _removeItem(int index) {
    DocumentSnapshot removedDoc = _bids[index];
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedDoc, animation),
      duration: Duration(milliseconds: 300), // Duration of the animation
    );
    _bids.removeAt(index);
  }

  // Function to build each item with animation
  Widget _buildItem(DocumentSnapshot doc, Animation<double> animation) {
    Map<String, dynamic> bidData = doc.data() as Map<String, dynamic>;
    double? bidAmount = bidData['amount'] as double?;
    Timestamp? bidTimestamp = bidData['timestamp'] as Timestamp?;
    bool? accepted = bidData['accepted'] as bool?;
    String userName = bidData['userName'] as String;
   

print(bidAmount);
    // Format the bid timestamp to a readable date
    String bidDate = bidTimestamp != null
        ? DateFormat('dd-MM-yyyy HH:mm').format(bidTimestamp.toDate())
        : '';

    // Build the list item with animation
    return SizeTransition(
      sizeFactor: animation,
      child: GestureDetector(
        // Only allow long press if no bid has been accepted and the current bid is not accepted
        onLongPress: (accepted ?? true)
            ? () {
                // Show a dialog with an "Accept" button when long press is detected
                _showAcceptDialog(context, bidId: doc.id, bidderEmail: userName,bidAmount:bidAmount);
              }
            : null, // Disable long press if the bid is accepted
        child: Card(
          elevation: 4, // Elevation for a shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          margin: const EdgeInsets.all(8), // Margin for spacing between cards
          child: ListTile(
            leading: accepted == true
                ? Icon(Icons.check_circle, color: Colors.green, size: 30) // Accepted icon
                : Icon(Icons.circle_outlined, size: 30), // Unaccepted icon
            title: Text(
              'Bid Amount: \$${bidAmount?.toStringAsFixed(2) ?? 'N/A'}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: accepted == true ? Colors.green : Colors.black), // Change color if accepted
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bids for Request ID: ${widget.requestId}'),
        backgroundColor: Colors.blue, // Optional: Set a custom color for the app bar
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _bids.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(_bids[index], animation);
        },
      ),
    );
  }

  // Function to show the "Accept" dialog
  void _showAcceptDialog(BuildContext context, {required String bidId, required String bidderEmail, double? bidAmount}) {
    // Create an instance of HelperService
    HelperService helperService = HelperService();
print(bidAmount);
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
                  // Use a Firestore transaction to accept the bid and set other bids' accepted fields to false
                  await FirebaseFirestore.instance.runTransaction((transaction) async {
                    DocumentReference bidDocRef = FirebaseFirestore.instance
                        .collection('requests')
                        .doc(widget.requestId)
                        .collection('bids')
                        .doc(bidId);

                    // Set the accepted field of the selected bid to true
                    transaction.update(bidDocRef, {'accepted': true});

                    // Get all other bid documents in the request
                    QuerySnapshot allBidsSnapshot = await FirebaseFirestore.instance
                        .collection('requests')
                        .doc(widget.requestId)
                        .collection('bids')
                        .get();

                    // Iterate through all bids and set their accepted fields to false (except the selected bid)
                    for (DocumentSnapshot doc in allBidsSnapshot.docs) {
                      if (doc.id != bidId) {
                        DocumentReference otherBidDocRef = doc.reference;
                        transaction.update(otherBidDocRef, {'accepted': false});
                      }
                    }
                  });

                  // Call acceptRequest from HelperService to accept the request
                  bool success = await helperService.acceptRequest(widget.requestId, bidderEmail,bidAmount);

                  // If the request is accepted successfully, close the dialog
                  if (success) {
                    Navigator.of(context).pop();
                  } else {
                    print('Error accepting request');
                  }
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
