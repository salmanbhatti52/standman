import 'package:flutter/material.dart';

Widget mainButton(
  text,
  color,
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              spreadRadius: 0,
              blurRadius: 15,
              offset: Offset(1, 10),
              color: Color.fromRGBO(7, 1, 87, 0.1),
            ),
          ]),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontFamily: "Outfit",
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget smallButton(
  text,
  color,
  BuildContext context,
) {
  return Container(
    height: 48,
    width: 118,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          spreadRadius: 0,
          blurRadius: 15,
          offset: Offset(1, 10),
          color: Color.fromRGBO(7, 1, 87, 0.1),
        ),
      ],
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
            fontFamily: "Outfit",
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget smallButton2(
  text,
  color,
  BuildContext context,
) {
  return Container(
    height: 31,
    width: 81,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
      boxShadow: [
        BoxShadow(
          spreadRadius: 0,
          blurRadius: 15,
          offset: Offset(1, 10),
          color: Color.fromRGBO(7, 1, 87, 0.1),
        ),
      ],
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
            fontFamily: "Outfit",
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w400),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget loadingBar(
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromRGBO(43, 101, 236, 1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(1, 10),
            color: Color.fromRGBO(7, 1, 87, 0.1),
          ),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Please Wait...",
              style: TextStyle(
                  fontFamily: "Outfit",
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
