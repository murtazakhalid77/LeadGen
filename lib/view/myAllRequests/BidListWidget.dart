import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/services/HelperService.dart';
import 'package:lead_gen/view/ReviewAndRating/reviews.dart';

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
    FirebaseFirestore.instance
        .collection('requests')
        .doc(widget.requestId)
        .collection('bids')
        .orderBy('amount', descending: false)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      _updateList(snapshot.docs);
    });
  }

  void _updateList(List<DocumentSnapshot> newDocs) {
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

  void _insertItem(int index, DocumentSnapshot doc) {
    _bids.insert(index, doc);
    _listKey.currentState?.insertItem(index);
  }

  void _removeItem(int index) {
    DocumentSnapshot removedDoc = _bids[index];
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedDoc, animation),
      duration: Duration(milliseconds: 300),
    );
    _bids.removeAt(index);
  }

  Widget _buildItem(DocumentSnapshot doc, Animation<double> animation) {
    Map<String, dynamic> bidData = doc.data() as Map<String, dynamic>;
    double? bidAmount = bidData['amount'] as double?;
    Timestamp? bidTimestamp = bidData['timestamp'] as Timestamp?;
    bool? accepted = bidData['accepted'] as bool?;
    String userName = bidData['userName'] as String;

    String bidDate = bidTimestamp != null
        ? DateFormat('dd-MM-yyyy HH:mm').format(bidTimestamp.toDate())
        : '';

    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: accepted == true
                    ? Icon(Icons.check_circle, color: Colors.green, size: 30)
                    : Icon(Icons.circle_outlined, size: 30),
                title: Text(
                  'Bid Amount: \$${bidAmount?.toStringAsFixed(2) ?? 'N/A'}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accepted == true ? Colors.green : Colors.black,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bid Date: $bidDate',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    if (userName != null)
                      Text(
                        'Bidder: $userName',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    if (accepted == true)
                      Text(
                        'Status: Accepted',
                        style: TextStyle(color: Colors.green, fontSize: 14),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewsPage(sellerName: userName),
                          ),
                        );
                      },
                      child: Text('Seller Reviews'),
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                        textStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: (accepted ?? false)
                          ? null
                          : () {
                              _showAcceptDialog(context, bidId: doc.id, bidderEmail: userName, bidAmount: bidAmount);
                            },
                      child: Text('Accept Bid'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        textStyle: TextStyle(fontSize: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pop();
          },
        ),
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

  void _showAcceptDialog(BuildContext context, {required String bidId, required String bidderEmail, double? bidAmount}) {
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
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance.runTransaction((transaction) async {
                    DocumentReference bidDocRef = FirebaseFirestore.instance
                        .collection('requests')
                        .doc(widget.requestId)
                        .collection('bids')
                        .doc(bidId);

                    transaction.update(bidDocRef, {'accepted': true});

                    QuerySnapshot allBidsSnapshot = await FirebaseFirestore.instance
                        .collection('requests')
                        .doc(widget.requestId)
                        .collection('bids')
                        .get();

                    for (DocumentSnapshot doc in allBidsSnapshot.docs) {
                      if (doc.id != bidId) {
                        DocumentReference otherBidDocRef = doc.reference;
                        transaction.update(otherBidDocRef, {'accepted': false});
                      }
                    }
                  });

                  bool success = await helperService.acceptRequest(widget.requestId, bidderEmail, bidAmount);

                  if (success) {
                    Navigator.of(context).pop();
                  } else {
                    print('Error accepting request');
                  }
                } catch (error) {
                  print('Error accepting bid: $error');
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
