import 'package:astrotak/Constants/colors.dart';
import 'package:astrotak/Provider/question_provider.dart';
import 'package:astrotak/Provider/relative_provider.dart';
import 'package:astrotak/Views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp( MultiProvider(
      providers: providers,child:const MyApp()));
}
List<SingleChildWidget> providers = [
  ChangeNotifierProvider<QuestionDataProvider>(create: (_) => QuestionDataProvider()),
    ChangeNotifierProvider<RelativesDataProvider>(create: (_) => RelativesDataProvider()),

];
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    
  }

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
