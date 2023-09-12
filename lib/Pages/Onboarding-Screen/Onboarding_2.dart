import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Authentication/Login_tab_class.dart';
import '../Authentication/SignUp_tab_class.dart';
import 'OnboardingPageWidget.dart';
import 'Onboarding_3.dart';

// ignore: camel_case_types
class Onboarding_2 extends StatelessWidget {
  const Onboarding_2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(
            //   height: height * 0.065,
            // ),
            Padding(
              padding: EdgeInsets.only(
                top: height * 0.060,
                // bottom: height * 0.020,
              ),
              child: OnboardingImage("assets/images/onboarding_2.svg", context),
            ),
            OnboardingIndicator(
                const Color.fromRGBO(167, 169, 183, 0.2),
                const Color(0xff2B65EC),
                const Color.fromRGBO(167, 169, 183, 0.2),
                8,
                16,
                8,
                context),
            Padding(
              padding: EdgeInsets.only(
                // top: height * 0.045,
                // bottom: height * 0.050,
              ),
              child: Onboardingheadingtext("Lorem Ipsum", context),
            ),
            Onboardingparatext(
                "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
                context),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: width * 0.040,
                // vertical: height* 0.033,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: OnboardingButton(
                        const Color.fromRGBO(43, 101, 236, 1),
                        const Color.fromRGBO(0, 0, 0, 0.1),
                        "assets/images/arrow-back.svg",
                        context),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offAll(  () => SignUpTabClass(signup: 0),
                        transition : Transition.downToUp,
                        duration: Duration(milliseconds: 350),);
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
                    onTap: (){Get.to( () => const  Onboarding_3(),
                      transition : Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 250),);},
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