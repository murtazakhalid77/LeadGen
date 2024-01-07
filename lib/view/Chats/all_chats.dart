import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lead_gen/model/UserDto.dart';
import 'package:lead_gen/services/UserService.dart';
import 'package:lead_gen/view/Chats/person_chat.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/drawer/drawer.dart';

class AllChatsPage extends StatefulWidget {
   final String? name;
  final String? phone;
  final String? address;
  final String? email;

  const AllChatsPage({
    Key? key,
    this.name,
    this.phone,
    this.address,
    this.email,
  }) : super(key: key);


  @override
  _AllChatsPageState createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {

late UserService userService;
  late User user;

  @override
  void initState() {
    user = User();
    userService = UserService();
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      // Replace the 'widget' with 'widget.' to access the properties of ProfilePage
      User? loggedInUser = await userService.getLoggedInUser(widget.phone!);
      if (loggedInUser != null) {
        setState(() {
          user.firstName = loggedInUser.firstName;
          user.email = loggedInUser.email;
          user.location = loggedInUser.location;
          user.phoneNumber = widget.phone!;
          print(user.toJson());
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
      drawer: NavBar(userType: 'buyer', user: user),  
      backgroundColor: Colors.blueAccent,
      body: SafeArea(      
        child: Column(       
          children: [           
            _top(),
            _body(),
          ],
        ),
      ),
    );
  }

  Widget _top() {  
    return Container(    
      padding: const EdgeInsets.only(top: 30, left: 30),
      child: Column(      
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          const Text(     
            'Start Chatting',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black12,
                ),
                child: const Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  height: 100,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Avatar(
                        margin: const EdgeInsets.only(right: 15),
                        image: 'lib/assets/${index + 1}.jpg',
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          color: Colors.white,
        ),
        child: ListView(
          padding: const EdgeInsets.only(top: 35),
          physics: const BouncingScrollPhysics(),
          children: [
            _itemChats(
              avatar: 'lib/assets/2.jpg',
              name: 'Adam',
              chat:
                  'Hi John',
              time: '08.10',
            ),
            _itemChats(
              avatar: 'lib/assets/4.jpg',
              name: 'Adrian',
              chat: 'I am available on 6 pm',
              time: '03.19',
            ),
            _itemChats(
              avatar: 'lib/assets/5.jpg',
              name: 'Fiona',
              chat: 'Hi',
              time: '02.53',
            ),
            _itemChats(
              avatar: 'lib/assets/6.jpg',
              name: 'Emma',
              chat: 'Available in black and red color',
              time: '11.39',
            ),
            _itemChats(
              avatar: 'lib/assets/7.jpg',
              name: 'Alexander',
              chat:
                  'price Rs: 20,000',
              time: '00.09',
            ),
            _itemChats(
              avatar: 'lib/assets/8.jpg',
              name: 'Alsoher',
              chat:
                  'You can meet me at 4 pm',
              time: '00.09',
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemChats(
      {String avatar = '', name = '', chat = '', time = '00.00'}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ChatPage(),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20),
        elevation: 0,
        child: Row(
          children: [
            Avatar(
              margin: const EdgeInsets.only(right: 20),
              size: 60,
              image: avatar,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$name',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$time',
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$chat',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  final double size;
  final image;
  final EdgeInsets margin;
  Avatar({this.image, this.size = 50, this.margin = const EdgeInsets.all(0)});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}