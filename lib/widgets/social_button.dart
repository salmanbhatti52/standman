import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:StandMan/Pages/Authentication/Customer/google_signin.dart';

Widget socialButtons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          margin: const EdgeInsets.only(left: 30, right: 0, bottom: 20),
          width: 160,
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.06),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  "assets/images/google.png",
                ),
              ),
              Text(
                "Google",
                style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 16,
                    color: Color(0xff8C8C8C),
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 10, right: 30, bottom: 20),
        width: 160,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.06),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                "assets/images/fb.png",
              ),
            ),
            Text(
              "Facebook",
              style: TextStyle(
                  fontFamily: "Rubik",
                  fontSize: 16,
                  color: Color(0xff8C8C8C),
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget socialButton(BuildContext context) {
  return Column(
    children: [
      GestureDetector(
        onTap: (){
          final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
         provider.googleLogin();
        },
        child: Container(
          width: 254,
          height: 48,
          decoration: BoxDecoration(
            color: Color(0xffEA4335),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(167, 169, 183, 0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/google.svg",
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Sign In with Google",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Outfit",
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  // letterSpacing: -0.3,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    ],
  );
}
