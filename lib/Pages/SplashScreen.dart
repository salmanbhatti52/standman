import 'Bottombar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'Customer/HomePage/HomePage.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:StandMan/Pages/EmpBottombar.dart';
import 'Onboarding-Screen/OnboardingPageView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:StandMan/Pages/Employee/HomePage/EmpHomePage.dart';
import 'package:StandMan/Pages/Authentication/SignUp_tab_class.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  sharedPrefs() async {
    print('usersCustomersId ');
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    empUsersCustomersId = prefs!.getString('empUsersCustomersId');
    print('usersCustomersId123 $usersCustomersId');
    print('empUsersCustomersId $empUsersCustomersId');

    if (usersCustomersId != null || empUsersCustomersId != null) {
      // User or employee is logged in
      if (usersCustomersId != null) {
        print("Customer");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => bottom_bar(currentIndex: 0),
          ),
        );
        print("Login Is usersCustomersId = $usersCustomersId");
      } else if (empUsersCustomersId != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Empbottom_bar(currentIndex: 0),
          ),
        );
        print("Login Is empUsersCustomersId = $empUsersCustomersId");
      }
    } else {
      // No user or employee is logged in
      bool firstRun = await IsFirstRun.isFirstRun();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              firstRun ? OnboardingPageView() : SignUpTabClass(signup: 0),
        ),
      );
      print("else condition running");
    }
  }

  onInit() async {
    await sharedPrefs();
  }

  @override
  void initState() {
    onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B65EC),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SvgPicture.asset(
          "assets/images/welcome.svg",
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
