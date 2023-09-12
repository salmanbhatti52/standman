import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Authentication/Login_tab_class.dart';
import '../Authentication/SignUp_tab_class.dart';
import 'OnboardingPageWidget.dart';
import 'Onboarding_2.dart';

// ignore: camel_case_types
class Onboarding_1 extends StatelessWidget {
  const Onboarding_1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                // bottom: height * 0.020,
              ),
              child: OnboardingImage("assets/images/onboarding_1.svg", context),
            ),
            OnboardingIndicator(
                const Color(0xff2B65EC),
                const Color.fromRGBO(167, 169, 183, 0.2),
                const Color.fromRGBO(167, 169, 183, 0.2),
                16,
                8,
                8,
                context),
            Padding(
              padding: EdgeInsets.symmetric(
               // vertical: height * 0.03,
              ),
              child: Onboardingheadingtext("Lorem Ipsum", context),
            ),
            Onboardingparatext(
                "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                context),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.040,
                // vertical: height * 0.033,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OnboardingButton(
                      const Color.fromRGBO(167, 169, 183, 1),
                      const Color.fromRGBO(0, 0, 0, 0.1),
                      "assets/images/arrow-left.svg",
                      context),
                  TextButton(
                    onPressed: () {
                      // Navigator.of(context).pushReplacementNamed('/home');
                      Get.offAll( () => SignUpTabClass(signup: 0),
                        transition : Transition.downToUp,
                        duration: Duration(milliseconds: 350),
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Color.fromRGBO(167, 169, 183, 1),
                        fontFamily: "Outfit",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(  () =>
                        const Onboarding_2(),
                        transition : Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 250),
                      );
                    },
                    child: OnboardingButton(
                        const Color.fromRGBO(43, 101, 236, 1),
                        const Color.fromRGBO(7, 1, 87, 0.1),
                        "assets/images/arrow-right.svg",
                        context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
