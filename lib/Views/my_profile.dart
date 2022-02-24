import 'package:astrotak/Constants/colors.dart';
import 'package:astrotak/Views/friends_and_family.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            TabBar(
              unselectedLabelStyle: const TextStyle(color: white),
              indicator: BoxDecoration(
                  color: Colors.orange, borderRadius: BorderRadius.circular(5)),
              labelColor: white,
              unselectedLabelColor: black,
              padding: const EdgeInsets.all(20),
              indicatorPadding: const EdgeInsets.all(5),
              
                tabs: const [
                Tab(text: "Basic Profile"),
                Tab(text: "Friends and Family")
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height-kToolbarHeight-100,
              child: TabBarView(
                
                children: [
                Container(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: FriendsAndFamily(),
                )
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
