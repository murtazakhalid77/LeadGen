import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lead_gen/constants/routes.dart';
import 'package:lead_gen/model/LocationModel.dart';
import 'package:lead_gen/model/RequestModel.dart';
import 'package:lead_gen/model/UserDto.dart';
import 'package:lead_gen/services/HelperService.dart';
import 'package:lead_gen/services/UserService.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/drawer/drawer.dart';
import 'package:lead_gen/view/seller/seller-card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllRequest extends StatefulWidget {
  final String? name;
  final String? phone;
  final String? address;
  final String? email;

  const AllRequest({
    this.name,
    this.phone,
    this.address,
    this.email,
    super.key, required bidAmount});

  @override
  State<AllRequest> createState() => _AllRequestState();
}

class _AllRequestState extends State<AllRequest> {

  late UserService userService;
  late User? user;
  List<RequestModel> fetchedRequests = [];
  late HelperService helperService;

  @override
  void initState() {
    user = User();
        helperService = HelperService();
    userService = UserService();
    super.initState();
    fetchUser();
    fetchData();

  }

Future<void> fetchData() async {
    try {
      List<RequestModel> fetchedRequests =
          await helperService.fetchSellerRequest("bikes");

      setState(() {
        this.fetchedRequests = fetchedRequests;
      });
    } catch (error) { 
      print('Error fetching Requests: $error');
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

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () {
            // Unfocus the current focus node before popping the screen
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).pop();// Add navigation functionality here
          },
        ),
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
          const SizedBox(height: 20,),
          SizedBox(
          height: 15,
          child: Center(
            child: fetchedRequests.isEmpty
                ? AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        "You don't have any requests",
                        textStyle: const TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                    ],
                    totalRepeatCount: 50000,
                  )
                : AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        'All Your Requests Are Listed Here',
                        textStyle: const TextStyle(
                          color: Colors.purple,
                        ),
                      )
                    ],
                    totalRepeatCount: 50000,
                  ),
          ),
        ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: const Text(
                        "Request Response", 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                  
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
                          '${location.locality ?? ''} '
                          '${location.subLocality ?? ''} '
                          '${location.subAdministrativeArea ?? ''}'
                          '${location.country ?? ''}'
                           '${location.street ?? ''}';
                      String categoryName = request.category!.name ?? '';
                       return SellerCard(
                        name: request.user!.firstName, // Pass name
                        description: request.description, // Pass description
                        locationText: locationText,
                        price: request.price, 
                     acceptedAmount: request.acceptedAmount,
                        date: request.createdDate,// Pass location text
                        title: request.title,
                        category: request.category?.name,
                       requestId: request.id.toString(),
                      isSellerAccepted: true
                      ,   buyerEmail: request.user!.email,
                         buyerUid:request.user!.email, 
                      );
                    }).toList(),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}