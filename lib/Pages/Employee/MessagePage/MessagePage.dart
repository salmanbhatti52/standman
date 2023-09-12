import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../widgets/AppBar.dart';
import '../../Drawer.dart';
import '../../EmpDrawer.dart';
import '../../Emp_notification.dart';
import 'MessageList.dart';

class EmpMessagePage extends StatefulWidget {
  const EmpMessagePage({Key? key}) : super(key: key);

  @override
  State<EmpMessagePage> createState() => _EmpMessagePageState();
}

class _EmpMessagePageState extends State<EmpMessagePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff2B65EC),
      drawer: EmpDrawer(),
      appBar: AppBar(
        toolbarHeight: height * 0.10,
        backgroundColor: Color(0xff2B65EC),
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Text(
            "Chat",
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
              Get.to(  () => EmpNotificationPage());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 0.0),
              child: SvgPicture.asset(
                'assets/images/notificationalert.svg',
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: EmpMessagesLists(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
