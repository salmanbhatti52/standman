import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Customer/AuthTextWidget.dart';
import 'Customer/SignUpPage.dart';
import 'Customer/login_page.dart';
import 'Emplyee/EmpSignUpPage.dart';

class SignUpTabClass extends StatefulWidget {
  int signup;
   SignUpTabClass({Key? key, required this.signup}) : super(key: key);

  @override
  State<SignUpTabClass> createState() => _SignUpTabClassState();
}

class _SignUpTabClassState extends State<SignUpTabClass>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      initialIndex: widget.signup,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: height * 0.04),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Authheadingtext("Register your account", context),
                    SizedBox(height: height * 0.03),
                    Container(
                      width: width * 0.85, // 327,
                      // height: height * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromRGBO(248, 249, 251, 1),
                      ),
                      child: TabBar(
                        // controller: _tabController,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        indicatorColor: Colors.pink,
                        unselectedLabelColor: Color.fromRGBO(167, 169, 183, 1),
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: "Outfit",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        labelColor: Color.fromRGBO(0, 0, 0, 1),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        tabs: [
                          Tab(
                            text: "Customer",
                          ),
                          Tab(
                            text: "StandMan",
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
                  // height: height * 0.61,
                  // width: 300,
                  child: TabBarView(
                      // controller: _tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CustomerSignUpPage(),
                        EmployeeSignUpPage(),
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
