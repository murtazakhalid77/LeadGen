import 'package:flutter/material.dart';

class SellerCard extends StatelessWidget {
  const SellerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child : Column(
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
    );
  }
}