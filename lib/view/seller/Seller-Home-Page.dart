import 'package:flutter/material.dart';
import 'package:lead_gen/view/drawer/drawer.dart';

class SellerHomePage extends StatefulWidget {
  const SellerHomePage({super.key});

  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}


class _SellerHomePageState extends State<SellerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const NavBar(userType: 'seller'),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Welcome to Lead Gen"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Image.asset("assets/leadGen.png"),
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
            children: <Widget>[
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
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Container(
                        color: Colors.blue.shade100,
                        child: Wrap(
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Murtaza Khalid",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.message),
                                  color: Colors.blue.shade300,
                                  onPressed: () {
                                    // do something
                                  },
                                ),
                              ],
                            ),
                            Container(
                              child: const Wrap(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 10, left: 10),
                                    child: Text(
                                      "I want a teacher for my coaching center he/she should be graduated and must have strong oop and dsa concepts.will give him market competetive salary."
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10, left: 10, top: 5),
                                    child: Text(
                                      "(4/567 Shah Faisal Colony, Karachi)",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10, top: 5, right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text(
                                      "Offer",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white
                                      )
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                        )
                                      )
                                    ),
                                    onPressed: () => null
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    child: Text(
                                      "Accept",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white
                                      )
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                        )
                                      )
                                    ),
                                    onPressed: () => null
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    child: Text(
                                      "Deny",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white
                                      )
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                        )
                                      )
                                    ),
                                    onPressed: () => null
                                  )
                                ]
                              ),
                            ),
                          ]
                        )
                      ),
                    )
                  ],
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
                    child: Container(
                      color: Colors.blue.shade100,
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Haris Adeel",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.message),
                                color: Colors.blue.shade300,
                                onPressed: () {
                                  // do something
                                },
                              ),
                            ],
                          ),
                          Container(
                            child: const Wrap(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  child: Text(
                                    "I want a teacher for my son he is in 5th grade he is not good in studies so i want a strict teacher will pay him market competive salary."
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10, left: 10, top: 5),
                                  child: Text(
                                    "(4/567 Shah Faisal Colony, Karachi)",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 5, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: Text(
                                    "Offer",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white
                                    )
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      )
                                    )
                                  ),
                                  onPressed: () => null
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  child: Text(
                                    "Accept",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white
                                    )
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      )
                                    )
                                  ),
                                  onPressed: () => null
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  child: Text(
                                    "Deny",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white
                                    )
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      )
                                    )
                                  ),
                                  onPressed: () => null
                                )
                              ]
                            ),
                          ),
                        ]
                      )
                    ),
                  )
                ],
              ),
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
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.blue
                      ),
                    ),
                    SizedBox(width: 63),
                    Text(
                      "4.3",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.blue
                      ),
                    ),
                    Spacer(),
                    Text(
                      "100k",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.blue
                      ),
                    ),
                  ],
                )
              ),
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
                    SizedBox(width: 46),
                    Text(
                      "Total Earning",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 5),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    TextButton(
                      child: Text(
                        "Total Orders",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white
                        )
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                        )
                      ),
                      onPressed: () => null
                    ),
                    const SizedBox(width: 40),
                    ElevatedButton(
                      child: Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white
                        )
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                        )
                      ),
                      onPressed: () => null
                    ),
                    const SizedBox(width: 38),
                    ElevatedButton(
                      child: Text(
                        "Earnings",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white
                        )
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                        )
                      ),
                      onPressed: () => null
                    ),
                  ]
                ),
              ),
             const Padding(
              padding: EdgeInsets.only(top: 20, right: 20, left: 20),
              child:  SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 30),
                  child: Text(
                    "Advertisement",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ),
            )
            ],
          )
        ],
      ),
    );
  }
}
