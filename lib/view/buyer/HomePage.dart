import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lead_gen/model/UserDto.dart';
import 'package:lead_gen/services/UserService.dart';
import 'package:lead_gen/view/customWidgets/customToast.dart';
import 'package:lead_gen/view/drawer/drawer.dart';

class MyHomePage extends StatefulWidget {
   final String phoneNumber;

   const MyHomePage({Key? key,required this.phoneNumber})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {
  late UserService userService;
  
 late User user;
  @override
  void initState() {
    user=User();
    userService = UserService();
   
    super.initState();
    fetchUser();
    
  }

  @override
  void dispose() {
   
  }


  
 Future<void> fetchUser() async {
    try {
      User? loggedInUser = await userService.getLoggedInUser(widget.phoneNumber);
   
      if (loggedInUser!=null) {
        setState(() {
          user.firstName=loggedInUser.firstName;
          user.email=loggedInUser.email;
          user.location=loggedInUser.location;
          user.phoneNumber=widget.phoneNumber;
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
       drawer:  NavBar(userType: 'buyer', user: user),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(90),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text("Hello ${user!.firstName} !!", style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white
                  )),
                  subtitle: Text('Good Morning', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white54
                  )),
                  trailing: const CircleAvatar(
                    radius: 30,
                   backgroundImage: NetworkImage("https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/2023/10/free-images.jpg"),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200)
                )
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard('Videos', CupertinoIcons.car, Colors.deepOrange),
                  itemDashboard('Analytics', CupertinoIcons.add_circled, Colors.green),
                  itemDashboard('Audience', CupertinoIcons.person_2, Colors.purple),
                  itemDashboard('Comments', CupertinoIcons.chat_bubble_2, Colors.brown),
                  itemDashboard('Revenue', CupertinoIcons.money_dollar_circle, Colors.indigo),
                  itemDashboard('Upload', CupertinoIcons.add_circled, Colors.teal),
                  itemDashboard('About', CupertinoIcons.question_circle, Colors.blue),
                  itemDashboard('Contact', CupertinoIcons.phone, Colors.pinkAccent),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 5),
          color: Theme.of(context).primaryColor.withOpacity(.2),
          spreadRadius: 2,
          blurRadius: 5
        )
      ]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
          ),
          child: Icon(iconData, color: Colors.white)
        ),
        const SizedBox(height: 8),
        Text(title.toUpperCase(), style: Theme.of(context).textTheme.titleMedium)
      ],
    ),
  );
}