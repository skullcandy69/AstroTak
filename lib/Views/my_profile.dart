import 'package:astrotak/Constants/colors.dart';
import 'package:astrotak/Views/friends_and_family.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  ScrollController controller = ScrollController();
  ScrollPhysics scrollPhysics = const ScrollPhysics();
  final GlobalKey _key =GlobalKey();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        child: SingleChildScrollView(
          // controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TabBar(
              key: _key,
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
                 Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 20.0),
                  child:  FriendsAndFamily(scontroller:controller ,sphysics:scrollPhysics),
                )
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
