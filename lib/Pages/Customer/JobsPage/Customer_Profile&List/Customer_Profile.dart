import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../widgets/TopBar.dart';
import '../../../Drawer.dart';
import '../Customer_JobCompletedBy/Customer_JobsDetails_CompletedBy.dart';
import 'Customer_ProfileList.dart';

class Customer_Profile extends StatelessWidget {
  const Customer_Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        toolbarHeight: height * 0.10,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.menu, color: Colors.black,),
        //   onPressed: () {
        //     Get.to(MyDrawer());
        //     // Scaffold.of(context).openDrawer();
        //   },
        // ),
        title: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Text(
            "Profile",
            style: TextStyle(
              color: Color(0xff000000),
              fontFamily: "Outfit",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              // letterSpacing: -0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
        Container(
          width: width * 0.9,
          height: height * 0.2,
          decoration: BoxDecoration(
              color: Color(0xff2B65EC),
              borderRadius: BorderRadius.circular(30)
          ),
          child:  Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset("assets/images/person2.png",),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Marvis Ighedosa",
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(Customer_JobsDetails_CompletedBy());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      // height: MediaQuery.of(context).size.height*0.07,
                      height: 48,
                      width: 118,
                      decoration: BoxDecoration(
                        // color: Color(0xff4DA0E6),
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 15,
                                offset: Offset(1 , 10),
                                color: Color.fromRGBO(7, 1, 87, 0.1)
                            ),
                          ]
                      ),
                      child:  Center(
                        child: Text("Chat",
                          style: TextStyle(
                              fontFamily: "Outfit",
                              fontSize: 14,
                              color: Color(0xff2B65EC),
                              fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                      ),

                    ),
                  ),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: 4.00,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Color(0xffFFDF00),
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                      Text(
                        "4.5",
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "Outfit",
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        ),
            Customer_ProfileLists(),
          ],
        ),
      ),
    );
  }
}
