import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../widgets/AppBar.dart';
import '../../Bottombar.dart';
import '../../EmpDrawer.dart';
import 'Emp_OnGoing_Jobs/Emp_ONGing.dart';
import 'Emp_Previous_Jobs/Emp_PrevoiusJobs.dart';
import 'Emp_Search_Jobs.dart';
import 'Employee_Create_OR_FindJobs/Employee_Create_OR_FindJobs.dart';
class EmpJobTabClass extends StatefulWidget {
  const EmpJobTabClass({Key? key}) : super(key: key);

  @override
  State<EmpJobTabClass> createState() => _EmpJobTabClassState();
}

class _EmpJobTabClassState extends State<EmpJobTabClass>
    with SingleTickerProviderStateMixin  {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      drawer: EmpDrawer(),
      backgroundColor: Color(0xff2B65EC),
      appBar: AppBar(
        toolbarHeight: height * 0.10,
        backgroundColor: Color(0xff2B65EC),
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Text(
            "My Jobs",
            style: TextStyle(
              color: Color(0xffffffff),
              fontFamily: "Outfit",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              // letterSpacing: -0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
            Get.to(EmpSearchJobs());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 0.0),
              child: SvgPicture.asset(
                'assets/images/search.svg',
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(height: height * 0.04),
            // AppBarr(text: "My Jobs", imagePath: "assets/images/search.svg"),
            // SizedBox(height: height * 0.04),
            Container(
              width: width,
              height: height * 0.14,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: height * 0.04),
                  Container(
                    width: width * 0.85, // 327,
                    // height: height * 0.075,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color.fromRGBO(248, 249, 251, 1),
                    ),
                    child: TabBar(
                      controller: _tabController,
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
                          text :
                            "Find Jobs",
                        ),Tab(
                          text :
                            "On Going",
                        ),
                        Tab(
                         text :
                            "Previous ",
                          ),
                      ],
                    ),
                  ),
                  // SizedBox(height: height * 0.04),
                ],
              ),
            ),
            // SizedBox(height: height * 0.04),
            Expanded(
              child: Container(
                // height: height * 0.1,
                // width: 300,
                child: TabBarView(controller: _tabController, children:  [
                  Emp_ceate_Or_findJobs(),
                  Emp_ONGoing(),
                  EmpPreviousJobs(),
                ]),
              ),
            ),
            // SizedBox(height: height * 0.04),
          ],
        ),
      ),
    );
  }
}
