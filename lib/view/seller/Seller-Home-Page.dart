// ignore_for_file: prefer_interpolation_to_compose_strings

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
  List<RequestModel> fetchedRequests = [];
  late HelperService helperService;

  @override
  void initState() {
    userService = UserService();
    helperService = HelperService();
    super.initState();
fetchUser();
    fetchData();
  }

 Future<void> fetchUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
        String  phoneNumber = prefs.getString('phoneNumber')!;
       user =
          await userService.getLoggedInUser(phoneNumber);
          
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
      drawer: NavBar(userType: 'seller', user: user!),
      appBar: AppBar(
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
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    LocationModel location =
                        LocationModel.fromString(request.locationModel!);
                    String locationText =
                        '${location.administrativeArea ?? ''} '
                        '${location.street ?? ''} '
                        '${location.subLocality ?? ''}';
                    String categoryName = request.category!.name ?? '';
                    return SellerCard(
                      name: request.user!.firstName, // Pass name
                      description: request.description, // Pass description
                      locationText: locationText, // Pass location text
                    );
                  }).toList(),
                ),
              ),
              // const SellerCard(),
            ],
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
              const Padding(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "23",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 50, color: Colors.blue),
                      ),
                      SizedBox(width: 63),
                      Text(
                        "4.3",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 50, color: Colors.blue),
                      ),
                      Spacer(),
                      Text(
                        "100k",
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
                      SizedBox(width: 30),
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
                  const SizedBox(width: 30),
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
                  const SizedBox(width: 10),
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
                  child: Text(
                    "Advertisement",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                )),
              )
            ],
          )
        ],
      ),
    );
  }
}
