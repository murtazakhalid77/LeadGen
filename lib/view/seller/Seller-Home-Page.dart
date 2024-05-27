import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:lead_gen/model/SummaryDto.dart';

import 'package:lead_gen/model/UserDto.dart';
import 'package:flutter/material.dart';
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/model/RequestModel.dart';
import 'package:lead_gen/model/UserDto.dart';
import 'package:lead_gen/services/HelperService.dart';
import 'package:lead_gen/services/UserService.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/drawer/drawer.dart';
import 'package:lead_gen/view/seller/seller-card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/LocationModel.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SellerHomePage extends StatefulWidget {
  final String categoryName;

  const SellerHomePage({Key? key, required this.categoryName})
      : super(key: key);

  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  late UserService userService;
  User? user;
  SummarDto? summarDto;
  List<RequestModel> fetchedRequests = [];
  late HelperService helperService;

  @override
  void initState() {
    userService = UserService();
    helperService = HelperService();
    fetchSummary();

    super.initState();
    fetchUser();

    fetchData();
  }

  Future<void> fetchSummary() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email')!;
      SummarDto? fetchedSummary = await helperService.getSummary(email);
      setState(() {
        summarDto = fetchedSummary;
      });
    } catch (error) {
      print('Error fetching Summary: $error');
    }
  }

  Future<void> fetchUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email')!;
      user = await userService.getLoggedInUser(email);

      if (user != null) {
        setState(() {
          // user!.firstName = loggedInUser.firstName;
          // user!.email = loggedInUser.email;
          // user!.location = loggedInUser.location;
          // user!.phoneNumber = phoneNumber;
        });
      }
    } catch (error) {
      print('Error fetching User: $error');
      showCustomToast("error while fetching logged In User");
    }
  }

  Future<void> fetchData() async {
    try {
      List<RequestModel> fetchedRequests =
          await helperService.fetchSellerRequest(widget.categoryName);

      setState(() {
        this.fetchedRequests = fetchedRequests;
      });
    } catch (error) {
      print('Error fetching Requests: $error');
    }
  }

  String formatEarnings(num? earnings) {
    if (earnings == null) return '0';
    if (earnings >= 1000000) {
      return '${(earnings / 1000000).toStringAsFixed(1)}M';
    } else if (earnings >= 1000) {
      return '${(earnings / 1000).toStringAsFixed(1)}K';
    } else {
      return earnings.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(user: user),
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Disable the automatic leading widget
        centerTitle: true,
        title: const Text("Welcome to Lead Gen"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: const Text(
                        "Seller Requests",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                     /*   Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.centerRight,
                          backgroundColor: Colors.blue, // Background color
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/seller-request");
                        },
                        child: const Text(
                          "See All",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
                Center(
                 child: fetchedRequests.isNotEmpty
                      ?  Wrap(
                    spacing: 12,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: fetchedRequests.map((request) {
                      // Extract location data
                      LocationModel location =
                          LocationModel.fromString(request.locationModel!);
                      String locationText =
                          '${location.locality ?? ''} ${location.subLocality ?? ''} ${location.subAdministrativeArea ?? ''} ${location.country ?? ''} ${location.street ?? ''}';

                      // Check if the accepted seller's email matches the logged-in user's email
                      // Check if the seller is accepted by the current user
                      bool isSellerAccepted = request.acceptedSeller?.email ==
                          firebase_auth
                              .FirebaseAuth.instance.currentUser?.email;

                      print(request.user!.uid);
// Display the seller card to all users if the seller is not accepted yet
                      if (!(request.accepted == "true")) {
                        return SellerCard(
                          name: request.user!.firstName, // Pass name
                          description: request.description, // Pass description
                          locationText: locationText, // Pass location text
                          price: request.price, // Pass price
                          date: request.createdDate, // Pass date
                          title: request.title, // Pass title
                          category: request.category?.name, // Pass category
                          requestId: request.id.toString(), // Pass requestId
                          acceptedAmount: request.acceptedAmount,
                          isSellerAccepted: isSellerAccepted,
                          buyerEmail: request.user!.email,
                          buyerUid: request.user!.uid,
                        );
                      }
// Display the seller card only to the accepted user
                      else if (isSellerAccepted) {
                        return SellerCard(
                          name: request.user!.firstName, // Pass name
                          description: request.description, // Pass description
                          locationText: locationText, // Pass location text
                          price: request.price, // Pass price
                          date: request.createdDate, // Pass date
                          title: request.title, // Pass title
                          category: request.category?.name, // Pass category
                          requestId: request.id.toString(), // Pass requestId
                          acceptedAmount: request.acceptedAmount,
                          isSellerAccepted: isSellerAccepted,
                          buyerEmail: request.user!.email,
                          buyerUid: request.user!.uid,
                        );
                      }
// If the seller is accepted but not by the current user, don't display the seller card
                      else {
                        return const SizedBox();
                      }
                    }).toList(),
                  )
                  : Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: SizedBox(
                            height: 40,
                            child: AnimatedTextKit(
                              animatedTexts: [
                                FadeAnimatedText(
                                  'You do not have any requests',
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
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: const Text(
                  "Summary",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      Text(
                        (summarDto?.totalRequestServed?.toString() ??
                            '0'), // Default to '0' if null
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 63),
                      Text(
                        (summarDto?.overAllRating?.toStringAsFixed(1) ??
                            '0.0'), // Default to '0.0' if null
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        formatEarnings(summarDto?.totalEarning),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  children: [
                    Text(
                      "Total Orders Taken",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 29),
                    Text(
                      "Overall Rating",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Total Earning",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
