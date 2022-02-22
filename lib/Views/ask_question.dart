import 'package:astrotak/Constants/colors.dart';
import 'package:astrotak/Widgets/wallet_lable.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AskQuestion extends StatefulWidget {
  const AskQuestion({Key? key}) : super(key: key);

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  var _isSelected = "Love";
  onchanged(value) {
    setState(() {
      _isSelected = value;
    });
  }

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '');
  }

  List<String> ques = [
    "cczxzxzcx",
    "jkczxbnbmnxbm??",
    "ajhckkjxnznznmzbncxbm",
    "ajksckjabnczbm"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BottomSheet(
          onClosing: () {},
          builder: (_) {
            return Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: blue,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹ 150 (1 Question on $_isSelected)",
                        style: const TextStyle(color: white),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Add Money"),
                        style: TextButton.styleFrom(
                            primary: blue,
                            textStyle: const TextStyle(color: black),
                            backgroundColor: white),
                      )
                    ]));
          }),
      body: SizedBox(
        height: MediaQuery.of(context).size.height -
            kToolbarHeight -
            kBottomNavigationBarHeight,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              walletBalance(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: "Ask a Question \n\n",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: black,
                            )),
                        TextSpan(
                            text:
                                "Seek accurate answers to your life problems and get guidance towards the right path. Whether the problem is related to love, self, life, business, money, education or work, our astrologers will do an in depth, study of your birth chart to provide personalized responses along with remedies.")
                      ],
                      style: TextStyle(
                        fontSize: 15,
                        color: black,
                      )),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Choose Category",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: black,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButton(
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                    value: _isSelected,
                    items: const <DropdownMenuItem>[
                      DropdownMenuItem(
                        child: Text("Love"),
                        value: "Love",
                      ),
                      DropdownMenuItem(
                        child: Text("Job"),
                        value: "job",
                      ),
                      DropdownMenuItem(
                        child: Text("Life"),
                        value: "Life",
                      ),
                    ],
                    onChanged: onchanged),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  maxLength: 150,
                  maxLines: 3,
                  decoration: InputDecoration(
                      hintText: "Type a question here",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  controller: controller,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Ideas what to ask (Select Any)",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: black,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.separated(
                  itemCount: ques.length,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Transform.rotate(
                        angle: -math.pi / 4,
                        child: Container(
                          color: orange,
                          height: 20,
                          width: 20,
                          child: Center(
                            child: Transform.rotate(
                              angle: math.pi / 4,
                              child: const Text(
                                "?",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(ques[index]),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                    "Seeking accurate answers to difficult questions troubling your mind? Ask credible astrologers to know what future has in store for you."),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(color: Colors.orange.shade100),
                  child: const Text(
                    """* Personalized responses provided by our team of Vedic astrologers within 24 hours.\n* Qualified and experienced astrologers will look into your birth chart and provide the right guidance.\n*You can seek answers to any part of your life and for most pressing issues.\n* Our team of Vedic astrologers will not just provide answers but also suggest the solutions""",
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
