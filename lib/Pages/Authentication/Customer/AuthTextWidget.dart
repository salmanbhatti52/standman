import 'package:flutter/cupertino.dart';

Widget Authheadingtext(text, BuildContext context){
  return Text(
    text,
    style: TextStyle(
      fontFamily: "Outfit",
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(34, 34, 34, 1),
    ),
    textAlign: TextAlign.center,
  );
}

Widget Authparatext(text, BuildContext context){
  return Text(
   text,
    style: TextStyle(
      color: Color.fromRGBO(0, 0, 0, 0.5),
      fontFamily: "Outfit",
      fontSize: 16,
      fontWeight: FontWeight.w300,
    ),
    textAlign: TextAlign.center,
  );
}