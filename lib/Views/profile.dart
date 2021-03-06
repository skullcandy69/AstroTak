import 'package:astrotak/Constants/colors.dart';
import 'package:astrotak/Views/my_profile.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: Image.asset(
            'assets/Images/icon.png',
            scale: 10,
          ),
          bottom: const TabBar(
            indicatorColor: Colors.orange,
            unselectedLabelColor:Colors.black,
      
            tabs: [Tab(text: "My Profile"), Tab(text: "Order History")],
          ),
          actions: [
            ButtonTheme(
              height: 30,
              child: TextButton(
                onPressed: () {},
                child: const Text("LOGOUT"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
            )
          ],
        ),
        body:  TabBarView(
          children: [const MyProfile(), Container()],
        ),
      ),
    );
  }
}
