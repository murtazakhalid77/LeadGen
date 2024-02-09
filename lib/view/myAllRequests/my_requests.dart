import 'package:flutter/material.dart';
import 'package:lead_gen/view/myAllRequests/request_card.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:core'; // Import this to use maxFinite

class MyRequests extends StatelessWidget {
  const MyRequests({super.key, required String phoneNumber});

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
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            right: 10,
            left: 10,
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              SizedBox(
                height: 40,
                //animated text "All Your Requests Are Listed Here"
                child: AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText('All Your Requests Are Listed Here',
                    textStyle: const TextStyle(
                      color: Colors.purple,
                      ),
                    ),
                  ],
                  totalRepeatCount: 50000, //count of animation repeatition 
                  onTap: () {
                    print("isRepeatingAnimation");
                  },
                ),
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 10, // Adjust the spacing between cards
                runSpacing: 10, // Adjust the spacing between rows
                children: [
                  MyRequestCard(
                    imagePath: 'lib/assets/cars.png',
                    requestText: 'I want a Civic car in white color.',
                    locationText: 'Khayaban e Mujahid, Defence.',
                    date: DateTime.now(),
                  ),
                  MyRequestCard(
                    imagePath: 'lib/assets/mobile.jpg',
                    requestText: 'I want a mobile. Camera should be in good quality.',
                    locationText: 'Khayaban e Mujahid, Defence.',
                    date: DateTime.now(),
                  ),
                  MyRequestCard(
                    imagePath: 'lib/assets/furniture and home decore.png',
                    requestText: 'I want a modern study table.',
                    locationText: 'Khayaban e Mujahid, Defence.',
                    date: DateTime.now(),
                  ),
                  MyRequestCard(
                    imagePath: 'lib/assets/businesses.png',
                    requestText: 'I need a shop on rent in Johar.',
                    locationText: 'Khayaban e Mujahid, Defence.',
                    date: DateTime.now(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
