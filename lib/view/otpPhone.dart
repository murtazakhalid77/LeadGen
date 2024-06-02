import 'package:flutter/material.dart';

class MyPhone  extends StatefulWidget {
  const MyPhone ({super.key});

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

  
Future signIn() async {
  // showDialog(
  //   context: context,
  //   builder: (context) {
  //     return Center(
  //       child: CircularProgressIndicator(
  //         valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange), // Change the color here
  //       ),
  //     );
  //   },
  // );

  print("hello worl");
    Navigator.pushNamed(context, '/otpEnter');
}

    return WillPopScope(
      onWillPop: () async {
        // Returning false will prevent the back button from popping the current route
        return false;
      },
      child: Scaffold(
         extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
               const SizedBox(
                  height: 25,
                ),
               const Text(
                textAlign:TextAlign.center,
                  "Phone \n Verification",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
               const SizedBox(
                  height: 10,
                ),
      
               const Text(
                  "We need to register your email without getting started!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              const  SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child:  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
    
                    SizedBox(
                        width: 10,
                      ),
                    Expanded(
                          child: TextField(
                        keyboardType:  TextInputType.emailAddress,
                        decoration:  InputDecoration(
                          border: InputBorder.none,
                          hintText: "xYZ@gmail.com",
                        ),
                      ))
                    ],
                  ),
                ),
              const  SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                       signIn();
                      },
                      child: const Text("Send the code")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}