import 'package:flutter/material.dart';
import 'package:lead_gen/view/seller/Seller-All-Request.dart';

class SellerSingleRequest extends StatelessWidget {
  final String? firstName;
  final String? description;
  final String? locationText;

  const SellerSingleRequest({
    Key? key,
    this.firstName,
    this.description,
    this.locationText,
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
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.blueAccent],
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
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          firstName ?? "N/A",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
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
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          description ?? "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          locationText ?? "N/A",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Column(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.deepPurple, backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        backgroundColor: Colors.white,
                                        elevation: 10.0,
                                        child: Container(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                'Enter Bid Amount',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 20.0),
                                              TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Enter your bid amount',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      Colors.grey.shade200,
                                                ),
                                              ),
                                              const SizedBox(height: 20.0),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .redAccent,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      foregroundColor: Colors.white, backgroundColor: Colors
                                                          .blue,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    18.0),
                                                      ),
                                                      padding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 20,
                                                              vertical: 10),
                                                    ),
                                                    onPressed: () {
                                                      // Get the bid amount from the TextField
                                                      String bidAmount =
                                                          ''; // Get the bid amount here
                                                      Navigator.of(context)
                                                          .pop(bidAmount);
                                                    },
                                                    child: const Text(
                                                      'Bid',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) {
                                    // Pass the bid amount to the AllRequest widget
                                    if (value != null) {
                                      Navigator.of(context).pop(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AllRequest(
                                            bidAmount: value,
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: const Text(
                                  "Offer",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.green, backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                ),
                                onPressed: () {
                                  // Handle accept action
                                },
                                child: const Text(
                                  "Accept",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.red, backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                ),
                                onPressed: () {
                                  // Handle deny action
                                },
                                child: const Text(
                                  "Deny",
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
