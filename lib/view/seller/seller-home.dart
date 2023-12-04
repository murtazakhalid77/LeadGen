import 'package:flutter/material.dart';

class SellerHomePage extends StatefulWidget {
  const SellerHomePage({super.key});

  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  int currentindex = 0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
        backgroundColor: Colors.blue,
      ),
      body: const Stack(
        children: [
          Text(
            "Seller Page",
            style: TextStyle(
              fontSize: 100
            ), 
          )
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: (index) => setState(() {
          currentindex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Feed",
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "chat",
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "User",
            backgroundColor: Colors.blue
          )
        ],
      ),
    );
  }
}