import 'package:flutter/material.dart';
import 'package:lead_gen/model/RequestModel.dart';
import 'package:lead_gen/services/HelperService.dart';
import 'package:lead_gen/view/myAllRequests/request_card.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MyRequests extends StatefulWidget {
  final phoneNumber;

  const MyRequests({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  late String phoneNumber;
  List<RequestModel> fetchedRequests = [];
  late HelperService helperService;

  @override
  void initState() {
    super.initState();
    helperService = HelperService();
    phoneNumber = widget.phoneNumber;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<RequestModel> fetchedRequests =
          await helperService.fetchUserRequest(widget.phoneNumber);

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
        backgroundColor: Colors.lightBlue,
        elevation: 0.2,
        title: const Text(
          'My Requests',
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
                          String locationText =
                              '${request.locationModel.administrativeArea ?? ''} '
                              '${request.locationModel.street ?? ''} '
                              '${request.locationModel.subLocality ?? ''}';

                          String categoryName = request.category!.name ?? '';
                          return MyRequestCard(
                              title: request.title,
                              requestText: request.description,
                              locationText: locationText,
                              date: request.createdDate,
                              categoryName: categoryName);
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
