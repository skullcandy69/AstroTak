import 'package:astrotak/Constants/colors.dart';
import 'package:astrotak/Models/askQuestionsModel.dart';
import 'package:astrotak/Provider/questionProvider.dart';
import 'package:astrotak/Widgets/wallet_lable.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class AskQuestion extends StatefulWidget {
  const AskQuestion({Key? key}) : super(key: key);

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  @override
  void initState() {
    super.initState();
    final queProv = Provider.of<QuestionDataProvider>(context, listen: false);
    queProv.getQuestionData();

    controller = TextEditingController(text: '');
  }

  late TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionDataProvider>(builder: (context, questions, child) {
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
                          "₹ 150 (1 Question on ${questions.isSelected.name})",
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
        body: questions.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
              onRefresh: ()=>questions.getQuestionData(),
              child: SizedBox(
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
                          child: questions.questions.data!.length == 0
                              ? const CircularProgressIndicator()
                              : DropdownButton(
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(10),
                                  value: questions.isSelected,
                                  items: questions.questions.data!
                                      .map(
                                          (AskModelData data) => DropdownMenuItem(
                                                child: Text(data.name),
                                                value: data,
                                              ))
                                      .toList(),
                                  onChanged: questions.selectQuestion),
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
                            itemCount: questions.isSelected.suggestions!.length,
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
                                  title: Text(
                                      questions.isSelected.suggestions![index]));
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
                            decoration:
                                BoxDecoration(color: Colors.orange.shade100),
                            child: const Text(
                              """* Personalized responses provided by our team of Vedic astrologers within 24 hours.\n* Qualified and experienced astrologers will look into your birth chart and provide the right guidance.\n* You can seek answers to any part of your life and for most pressing issues.\n* Our team of Vedic astrologers will not just provide answers but also suggest the solutions""",
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
            ),
      );
    });
  }
}
