import 'package:StandMan/Pages/Onboarding-Screen/OnboardingPageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(width: width * 0.07),
                        SizedBox(width: width * 0.12,),
                        SvgPicture.asset("assets/images/logo.svg"),
                        // SizedBox(width: width * 0.5),
                        GestureDetector(
                          onTap: (){
                            Get.to( () => OnboardingPageView());
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 15, bottom: 70),
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            // width: width * 0.12,
                            //   height: height * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0xff2B65EC),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(2, 10),
                                    spreadRadius: -5,
                                    blurRadius: 17,
                                    color: Color.fromRGBO(232, 231, 231, 1),),
                                ]
                            ),
                            child: Image.asset("assets/images/i.png", width: 20, height: 20, color: Colors.white,),
                          ),
                        ),
                      ],
                    ),
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
              SizedBox(height: height * 0.03),
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
