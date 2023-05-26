import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../widgets/MyButton.dart';
import '../../../../widgets/TopBar.dart';
import '../Customer_Profile&List/Customer_Profile.dart';

class Customer_Rating extends StatelessWidget {
  const Customer_Rating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff2B65EC),
      appBar: StandManAppBar1(title: "Job Details", bgcolor: Color(0xff2B65EC), titlecolor: Colors.white, iconcolor: Colors.white,),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding:  EdgeInsets.symmetric(vertical: height * 0.02),
              //   child: Bar(
              //     "Job Details",
              //     'assets/images/arrow-back.svg',
              //     Colors.white,
              //     Colors.white,
              //         () {
              //       Get.back();
              //     },
              //   ),
              // ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Eleanor Pena",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: "Outfit",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              // letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const Text(
                            "\$22",
                            style: TextStyle(
                              color: Color(0xff2B65EC),
                              fontFamily: "Outfit",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              // letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/locationfill.svg',
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "No 15 uti street off ovie palace road effurun delta state",
                                style: const TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Complete job time 03 March - 4:40 PM",
                                style: const TextStyle(
                                  color: Color.fromRGBO(167, 169, 183, 1),
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      const Text(
                        "Donec dictum tristique porta. Etiam convallis lorem lobortis nulla molestie, nec tincidunt ex ullamcorper. Quisque ultrices lobortis elit sed euismod. Duis in ultrices dolor, ac rhoncus odio. Suspendisse tempor sollicitudin dui sed lacinia. Nulla quis enim posuere, congue libero quis, commodo purus. Cras iaculis massa ut elit.",
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: "Outfit",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          // letterSpacing: -0.3,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: 73,
                        height: 19,
                        decoration: BoxDecoration(
                          color: Color(0xffE9FFE7),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Completed",
                            style: TextStyle(
                              color: Color(0xff10C900),
                              fontFamily: "Outfit",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Give Ratings",
                            style: TextStyle(
                              color: Color.fromRGBO(25, 29, 49, 1),
                              fontFamily: "Outfit",
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              // letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          RatingBarIndicator(
                            rating: 0.00,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Color(0xffA7A9B7),
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Add Comment",
                            style: TextStyle(
                              color: Color.fromRGBO(25, 29, 49, 1),
                              fontFamily: "Outfit",
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              // letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color.fromRGBO(243, 243, 243, 1),
                              width: 1.0,
                            )),
                        height: height * 0.12, // 97,
                        child: TextField(
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Color.fromRGBO(167, 169, 183, 1),
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.only(top: 0.0, left: 12),
                            hintText: "Type here....",
                            hintStyle: const TextStyle(
                              color: Color.fromRGBO(167, 169, 183, 1),
                              fontFamily: "Outfit",
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(Customer_Profile());
                        },
                          child: mainButton("Submit", Color.fromRGBO(43, 101, 236, 1), context))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
