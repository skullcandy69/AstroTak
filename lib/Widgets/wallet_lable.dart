import 'package:astrotak/Constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget walletBalance() {
  return Container(
    height: 50,
    color: blue,
    padding:const EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children: [
        const Text("Wallet Balance: ₹ 0",style: TextStyle(color: white,fontWeight:FontWeight.bold)),
        TextButton(
          onPressed: () {},
          
          child: const Text("Add Money"),
          style: TextButton.styleFrom(
            
              primary: blue,
              textStyle: const TextStyle(color: black),
              backgroundColor: white),
        )
      ],
    ),
  );
}
