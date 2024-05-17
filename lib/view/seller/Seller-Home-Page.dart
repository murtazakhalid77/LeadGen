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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(userType: 'seller', user: user),
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Disable the automatic leading widget
        centerTitle: true,
        title: const Text("Welcome to Lead Gen"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Image.asset("lib/assets/leadGen.png"),
            onPressed: () {
              // do something
            },
          )
        ],
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
                        "Request",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Padding(
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
                    ),
                  ],
                ),
                Center(
                  child: Wrap(
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
                        return SizedBox();
                      }
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 40, left: 20),
                child: const Text(
                  "Summary",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        summarDto!.totalRequestServed.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 50, color: Colors.blue),
                      ),
                      SizedBox(width: 63),
                      Text(
                        summarDto!.overAllRating.toStringAsFixed(1),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 50, color: Colors.blue),
                      ),
                      Spacer(),
                      Text(
                        summarDto!.totalEarning.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 50, color: Colors.blue),
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
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 5),
                child: Row(children: [
                  const SizedBox(width: 20),
                  TextButton(
                      child: Text("Total Orders",
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () => null),
                  const SizedBox(width: 40),
                  ElevatedButton(
                      child: Text("Pending",
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () => null),
                  const SizedBox(width: 35),
                  ElevatedButton(
                      child: Text("Earnings",
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () => null),
                ]),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                child: SizedBox(
                    child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 30),
                  /*    child: Text(
                    "Advertisement",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),*/
                )),
              )
            ],
          )
        ],
      ),
    );
  }
}
