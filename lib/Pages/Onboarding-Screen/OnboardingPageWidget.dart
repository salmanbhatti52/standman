import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

Widget OnboardingImage(image, BuildContext context) {
  return SvgPicture.asset(
    image,
  );
}

Widget OnboardingIndicator(color1, color2, color3, double? width, double? width2, double? width3, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: width,
        height: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // color: Color(0xff025188),
          color: color1,
        ),
      ),
      SizedBox(
        width: 2,
      ),
      Container(
        width: width2,
        height: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          // color: Color(0xffF2F2F2),
          color: color2,
        ),
      ),
      SizedBox(
        width: 2,
      ),
      Container(
        width: width3,
        height: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          // color: Color(0xffF2F2F2),
          color: color3,
        ),
      ),
    ],
  );
}

Widget Onboardingheadingtext(text, BuildContext context) {
  return Text(
    text,
    style: TextStyle(
      color: Color.fromRGBO(0, 0, 0, 1),
      fontFamily: "Outfit",
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    textAlign: TextAlign.center,
  );
}

Widget Onboardingparatext(text, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: "Outfit",
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Color.fromRGBO(0, 0, 0, 0.5),
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget OnboardingButton(color, color2, image, BuildContext context,) {
  return Container(
    width: 46,
    height: 46,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(46),
      boxShadow: [
        BoxShadow(
          color: color2, //Color.fromRGBO(0, 0, 0, 0.1),
          spreadRadius: 0,
          blurRadius: 15,
          offset: Offset(1, 10), // changes position of shadow
        ),
      ],
    ),
    child: Center(child: SvgPicture.asset(image)),
  );
}
