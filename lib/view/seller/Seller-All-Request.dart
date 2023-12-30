import 'package:flutter/material.dart';
import 'package:lead_gen/view/drawer/drawer.dart';

class AllRequest extends StatefulWidget {
  const AllRequest({super.key});

  @override
  State<AllRequest> createState() => _AllRequestState();
}

class _AllRequestState extends State<AllRequest> {
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
                        "Request Response", 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

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
                              padding: const EdgeInsets.only(bottom: 10, right: 8, top: 5),
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
                                  SizedBox(width: 10),
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
                    padding: EdgeInsets.only(right: 20, left: 20, top: 10),
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
                                icon: Icon(Icons.message),
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
                            padding: EdgeInsets.only(bottom: 10, right: 8, top: 5),
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
                                SizedBox(width: 10),
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
                    padding: EdgeInsets.only(right: 20, left: 20, top: 10),
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
                                icon: Icon(Icons.message),
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
                            padding: EdgeInsets.only(bottom: 10, right: 8, top: 5),
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
                                SizedBox(width: 10),
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
                    padding: EdgeInsets.only(right: 20, left: 20, top: 10),
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
                                icon: Icon(Icons.message),
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
                            padding: EdgeInsets.only(bottom: 10, right: 8, top: 5),
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
                                SizedBox(width: 10),
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
        ],
      ),
    );
  }
}