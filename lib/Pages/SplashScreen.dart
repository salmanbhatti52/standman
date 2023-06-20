import 'package:StandMan/Pages/EmpBottombar.dart';
import 'package:StandMan/Pages/Employee/HomePage/EmpHomePage.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/Login_tab_class.dart';
import 'Bottombar.dart';
import 'Customer/HomePage/HomePage.dart';
import 'Onboarding-Screen/OnboardingPageView.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  // Future checkFirstSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool _seen = (prefs.getBool('seen') ?? false);
  //
  //   if (_seen) {
  //     Navigator.of(context).pushReplacement(
  //         new MaterialPageRoute(builder: (context) => new LoginTabClass(login: 0)));
  //   } else {
  //     await prefs.setBool('seen', true);
  //     Navigator.of(context).pushReplacement(
  //         new MaterialPageRoute(builder: (context) => new OnboardingPageView()));
  //   }
  // }

  @override
  // void afterFirstLayout(BuildContext context) => checkFirstSeen();

  sharedPrefs() async {
    print('usersCustomersId ');
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    empUsersCustomersId = prefs!.getString('empUsersCustomersId');
    print('usersCustomersId123 $usersCustomersId');
    print('empUsersCustomersId $empUsersCustomersId');

    if (usersCustomersId != null) {
      print("dddn");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => bottom_bar(currentIndex: 0),
        ),
      );
      print("Login Is usersCustomersId = $usersCustomersId");
    }
  else  if (empUsersCustomersId != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Empbottom_bar(currentIndex: 0),
        ),
      );
      print("Login Is usersCustomersId = $usersCustomersId");
    }
     else  if (usersCustomersId == null && empUsersCustomersId == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginTabClass(login: 0),
        ),
      );
      print("Login Is usersCustomersId = $usersCustomersId");
    }
    else {
      bool firstRun = await IsFirstRun.isFirstRun();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => firstRun ? OnboardingPageView() : LoginTabClass(login: 0),
        ),
      );
      print("Login not usersCustomersId = $usersCustomersId");
    }
  }

  oninit() async {
    await sharedPrefs();

  }

  @override
  void initState() {
    oninit();
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
