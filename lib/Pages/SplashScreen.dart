import 'package:StandMan/Pages/EmpBottombar.dart';
import 'package:StandMan/Pages/Employee/HomePage/EmpHomePage.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  bool loading = true;
  bool loading2 = true;

  sharedPrefs() async {
    loading = true;
    setState(() {});
    print('usersCustomersId ');
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = (prefs!.getString('usersCustomersId'));
    print('usersCustomersId123 $usersCustomersId');

    if (usersCustomersId != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => bottom_bar(
                    currentIndex: 0,
                  )));
      print("Login Is usersCustomersId  = $usersCustomersId");
      // Get.to(bottom_bar(currentIndex: 0));
    } else {
      loading = false;
      setState(() {});
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoginTabClass(login: 0)));
      // Get.to(LoginTabClass(login: 0));
      print("Login not usersCustomersId = $usersCustomersId");
    }
  }

  sharedPrefsEmp() async {
    loading2 = true;
    setState(() {});
    print('Login Is or not');
    empPrefs = await SharedPreferences.getInstance();
    empUsersCustomersId = (empPrefs!.getString('empUsersCustomersId'));
    print('empUsersCustomersId $empUsersCustomersId');

    if (empUsersCustomersId != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Empbottom_bar(
                    currentIndex: 0,
                  )));
      print("Login Is empUsersCustomersId  = $empUsersCustomersId");
      // Get.to(bottom_bar(currentIndex: 0));
    } else {
      loading2 = false;
      setState(() {});
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoginTabClass(login: 1)));
      // Get.to(LoginTabClass(login: 0));
      print("Login not empUsersCustomersId = $empUsersCustomersId");
    }
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    Future.delayed(Duration(seconds: 1), () async {
      if (_seen) {
        if (usersCustomersId == null) {
          sharedPrefs();
        } else if (empUsersCustomersId == null) {
          sharedPrefsEmp();
        }
      } else {
        await prefs.setBool('seen', true);
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (context) => new OnboardingPageView()));
      }
    });
  }

  void afterFirstLayout(BuildContext context) => checkFirstSeen();

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
