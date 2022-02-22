import 'package:astrotak/Constants/colors.dart';
import 'package:astrotak/Constants/navigation_helper.dart';
import 'package:astrotak/Views/ask_question.dart';
import 'package:astrotak/Views/my_profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Talk Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    AskQuestion(),
    Text('Reports Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Chat Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: Image.asset(
          'assets/Images/hamburger.png',
          scale: 1.5,
        ),
        title: Image.asset(
          'assets/Images/icon.png',
          scale: 10,
        ),
        actions: [
          IconButton(
              onPressed: () => changeScreen(context, const Profile()),
              icon: Image.asset(
                'assets/Images/profile.png',
                scale: 4,
              ))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        isExtended: true,
        child: const Icon(
          Icons.menu,
          color: white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: orange,
        // selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        elevation: 5,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/Images/home.png',
              width: 25,
              height: 25,
              fit: BoxFit.contain,
              color: _selectedIndex == 0 ? orange : grey,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/Images/talk.png',
                width: 25,
                height: 25,
                fit: BoxFit.contain,
                color: _selectedIndex == 1 ? orange : grey,
              ),
              label: "Talk"),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/Images/ask.png',
              width: 25,
              height: 25,
              fit: BoxFit.contain,
              color: _selectedIndex == 2 ? orange : grey,
            ),
            label: "AskQuestion",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/Images/reports.png',
              alignment: Alignment.center,
              width: 25,
              height: 25,
              fit: BoxFit.fitHeight,
              color: _selectedIndex == 3 ? orange : grey,
            ),
            label: "Reports",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/Images/chat.png',
              width: 25,
              height: 25,
              fit: BoxFit.contain,
              color: _selectedIndex == 4 ? orange : grey,
            ),
            label: "Chat",
          ),
        ],
      ),
    );
  }
}
