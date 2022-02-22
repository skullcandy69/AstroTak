import 'package:astrotak/Constants/colors.dart';
import 'package:astrotak/Views/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Astro Tak',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold,color: black),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind',color: black),
            bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Hind',color: black)
          ),
          appBarTheme: const AppBarTheme(
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(
                  color: Colors.orangeAccent, opacity: 2, size: 20)),
          iconTheme: const IconThemeData(
              color: Colors.orangeAccent, opacity: 2, size: 20)),
      home: const HomePage(),
    );
  }
}
