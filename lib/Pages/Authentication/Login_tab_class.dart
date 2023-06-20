import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Customer/AuthTextWidget.dart';
import 'Customer/login_page.dart';
import 'Emplyee/Emplogin_page.dart';

class LoginTabClass extends StatefulWidget {
  int login;

  LoginTabClass({Key? key, required this.login}) : super(key: key);

  @override
  State<LoginTabClass> createState() => _LoginTabClassState();
}

class _LoginTabClassState extends State<LoginTabClass>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      initialIndex: widget.login,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.03),
                    SvgPicture.asset("assets/images/logo.svg"),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 5.0),
                      child: Authheadingtext("Welcome Back", context),
                    ),
                    Authparatext("Please Login to your account", context),
                    SizedBox(height: height * 0.02),
                    Container(
                      width: width * 0.85, // 327,
                      // height: height * 0.075,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromRGBO(248, 249, 251, 1),
                      ),
                      child: TabBar(
                        // controller: _tabController,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        labelColor: Colors.black,
                        unselectedLabelColor: Color(0xffA7A9B7),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        indicatorColor: Colors.pink,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        tabs: [
                          Tab(
                            text: "Customer",
                          ),
                          Tab(
                            text: "StandMan ",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Expanded(
                child: Container(
                  child: TabBarView(
                      // controller: _tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CustomerLoginPage(),
                        EmpLoginPage(),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
