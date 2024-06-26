import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lead_gen/model/RequestModel.dart';
import 'package:lead_gen/services/HelperService.dart';
import 'package:lead_gen/view/buyer/HomePage.dart';
import 'package:lead_gen/view/myAllRequests/request_card.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../model/LocationModel.dart';

class MyRequests extends StatefulWidget {
  final email;
  final option;

  const MyRequests({Key? key, required this.email, required this.option})
      : super(key: key);

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  late String email;
  List<RequestModel> fetchedRequests = [];
  late HelperService helperService;

  @override
  void initState() {
    super.initState();
    helperService = HelperService();
    email = widget.email;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<RequestModel> fetchedRequests =
          await helperService.fetchUserRequest(widget.email);

      setState(() {
        this.fetchedRequests = fetchedRequests;
      });
    } catch (error) {
      print('Error fetching Requests: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Disable the automatic leading widget
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        elevation: 0.2,
        title: const Text(
          'My Requests',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (context) => MyHomePage(
                  option: true,
                  email: email,
                ), // goes to home page
              ),
            );
          },
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F3),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              fetchedRequests.isNotEmpty
                  ? SizedBox(
                      height: 40,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          FadeAnimatedText(
                            'All Your Requests Are Listed Here',
                            textStyle: const TextStyle(
                              color: Colors.purple,
                            ),
                          ),
                        ],
                        totalRepeatCount: 50000,
                        onTap: () {
                          print("isRepeatingAnimation");
                        },
                      ),
                    )
                  : Center(
                      child: AnimatedTextKit(
                        animatedTexts: [
                          FadeAnimatedText(
                            'You have not made any requests yet',
                            textStyle: const TextStyle(
                              color: Colors.purple,
                            ),
                          ),
                        ],
                        totalRepeatCount: 50000,
                        onTap: () {
                          print("isRepeatingAnimation");
                        },
                      ),
                    ),
              const SizedBox(height: 5),
              fetchedRequests.isNotEmpty
                  ? Center(
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: fetchedRequests.map((request) {
                          try {
                            // continue from here i have made an method for string to model then user it here to display all reqyest

                            LocationModel location = LocationModel.fromString(
                                request.locationModel!);

                            String locationText =
                                '${location.administrativeArea ?? ''} '
                                '${location.street ?? ''} '
                                '${location.subLocality ?? ''}';

                            String categoryName = request.category!.name ?? '';
                            print(request.acceptedSeller!.email);
                            print(request.acceptedSeller!.uid);
                            return MyRequestCard(
                                  accepted:request.accepted,
                              option: widget.option,
                              email: widget.email,
                              id: request.id,
                              title: request.title,
                              requestText: request.description,
                              locationText: locationText,
                              date: request.createdDate,
                              categoryName: categoryName,
                              acceptedSellerUid:request.acceptedSeller!.uid,
                              acceptedSellerEmail:request.acceptedSeller!.email,
                              status: request.status,
                              
                        
                            );
                          } catch (e) {
                            // Handle decoding error
                            print('Error decoding location model: $e');
                            // Provide a placeholder or fallback behavior
                            return MyRequestCard(
                              accepted:request.accepted,
                              option: widget.option,
                              email: widget.email,
                              id: request.id,
                              title: request.title,
                              requestText: request.description,
                              locationText:
                                  'Location information not available',
                              date: request.createdDate,
                              categoryName: request.category?.name ?? '',
                                acceptedSellerUid:request.acceptedSeller!.uid,
                              acceptedSellerEmail:request.acceptedSeller!.email,
                              status: request.status,
                            );
                          }
                        }).toList(),
                      ),
                    )
                  : SizedBox(), // empty SizedBox when there are no requests
            ],
          ),
        ),
      ),
    );
  }
}
