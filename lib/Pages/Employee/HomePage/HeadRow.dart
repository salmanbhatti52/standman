import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Heading (text1, text2,  BuildContext context){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
          text1, //"Popular Doctor",
          style: TextStyle(
            color: Color(0xff000000),
            fontFamily: "Outfit",
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        TextButton(
          onPressed: () {},
          child:  Text(
           text2, // "See all",
            style: TextStyle(
              color: Color(0xff8C8C8C),
              fontFamily: "Rubik",
              fontWeight: FontWeight.w300,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}
