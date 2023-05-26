// ignore: camel_case_types
import 'package:StandMan/Pages/Authentication/Login_tab_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Drawer.dart';
import 'Employee/HomePage/EmpHomePage.dart';
import 'Employee/JobsPage/Jobs_TabBar.dart';
import 'Employee/MessagePage/MessagePage.dart';
import 'Employee/ProfilePage/EmpProfile_TabBar.dart';
import 'Employee/WalletPage/EmpWalletPage.dart';

class Empbottom_bar extends StatefulWidget {
  int currentIndex;
   Empbottom_bar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<Empbottom_bar> createState() => _Empbottom_barState();
}

// ignore: camel_case_types
class _Empbottom_barState extends State<Empbottom_bar> {
  // int currentIndex = 0;
  static final List<Widget> _widgetOption = <Widget>[
    EmpHomePage(),
    EmpMessagePage(),
    EmpWalletPage(),
    EmpJobTabClass(),
    ProfileTabBar(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: MyDrawer(),
          extendBody: true,
          body: Container(
            child: _widgetOption[widget.currentIndex],
          ),
          bottomNavigationBar: Container(
            height: height * 0.11, //90,
            width: width, //390,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.02),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: ClipRRect(
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(24.0),
              //   topRight: Radius.circular(24.0),
              // ),
              child: BottomNavigationBar(
                  onTap: _onItemTapped,
                  currentIndex: widget.currentIndex,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: Color(0xffA7A9B7),
                  selectedItemColor: Color(0xff000000),
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        widget.currentIndex == 0
                       ? 'assets/images/home-2.svg'
                       : 'assets/images/home.svg',
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          widget.currentIndex == 1
                         ? 'assets/images/messages-2.svg'
                         : 'assets/images/messages.svg',
                        ),
                        label: 'Messages'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          widget.currentIndex == 2
                         ? 'assets/images/wallet-2.svg'
                         : 'assets/images/wallet.svg',
                        ),
                        label: 'Wallet'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          widget.currentIndex == 3
                         ? 'assets/images/job-2.svg'
                         : 'assets/images/job.svg',
                        ),
                        label: 'My Jobs'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          widget.currentIndex == 4
                         ? 'assets/images/profile-2.svg'
                         : 'assets/images/profile.svg',
                        ),
                        label: 'Profile'),
                  ]),
            ),
          )),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new TextButton(
            onPressed: () => Navigator.pop(context),
            child: new Text('No'),
          ),
          new TextButton(
            onPressed: () => Get.offAll(LoginTabClass(login: 1,)),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
}
