import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/myAllRequests/BidListWidget.dart';
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
  final String requestId; // Add requestId parameter

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
    required this.requestId, // Initialize requestId parameter
  }) : super(key: key);

  @override
  _MySingleRequestCardState createState() => _MySingleRequestCardState();
}

class _MySingleRequestCardState extends State<MySingleRequestCard> {
  // HelperService helperService;
  // RequestModel? request;

  @override
  void initState() {
    super.initState();
    // helperService = HelperService();
  }

  Future<void> cancelRequest() async {
    try {
      // Call your cancel request function here
      // Show a toast notification on successful cancellation
      showCustomToast("Request Cancelled");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MyHomePage(option: widget.option, email: widget.email)),
      );
    } catch (error) {
      print('Error canceling request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Convert the date string to a human-readable format
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.date!));

    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 170,
        decoration: BoxDecoration(
          color: Colors.pink.shade200, // Soft blue color for the background
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.shade400
                  .withOpacity(0.4), // Semi-transparent blue shadow
              spreadRadius: 4,
              blurRadius: 10,
              offset:
                  Offset(0, 4), // Slightly shifted shadow for a lifted effect
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
                        onPressed: () {
                          // Navigate to the BidListWidget to display all bids for the given requestId
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  BidListWidget(requestId: widget.requestId),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        child: const Text(
                          "View All Bids",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.pinkAccent),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Change color of text/foreground
                          shape: MaterialStateProperty.all<OutlinedBorder?>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Your onPressed function here
                        },
                        child: const Text(
                          "Button Text",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
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
                const SizedBox(height: 10),
                // StreamBuilder to fetch bids for the given requestId
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('requests')
                      .doc(widget.requestId)
                      .collection('bids')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show loading indicator while fetching bids
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      // Display error message
                      return Text('Error loading bids: ${snapshot.error}');
                    }

                    // Retrieve the list of bid documents
                    final bidDocs = snapshot.data?.docs ?? [];

                    if (bidDocs.isEmpty) {
                      // Display message if there are no bids
                      return Text(
                        'No bids yet.',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      );
                    }

                    // Display the list of bids
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: bidDocs.length,
                      itemBuilder: (context, index) {
                        // Retrieve the bid data
                        final bidDoc = bidDocs[index];
                        final bidData = bidDoc.data() as Map<String, dynamic>;
                        final bidAmount = bidData['amount'] as double?;
                        final bidTimestamp = bidData['timestamp'] as Timestamp?;

                        // Format the bid timestamp to a readable date
                        final bidDate = bidTimestamp != null
                            ? DateFormat('dd-MM-yyyy HH:mm')
                                .format(bidTimestamp.toDate())
                            : '';

                        // Display the bid information using a ListTile
                        return ListTile(
                          title: Text(
                            'Bid Amount: \$${bidAmount?.toStringAsFixed(2) ?? 'N/A'}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Bid Date: $bidDate'),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
