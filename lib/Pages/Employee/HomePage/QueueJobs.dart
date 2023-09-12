import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'EmpJobComplete.dart';

class QueueJobs extends StatefulWidget {
  @override
  _QueueJobsState createState() => _QueueJobsState();
}

class _QueueJobsState extends State<QueueJobs> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: 112,
          width: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: menuList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: GestureDetector(
                    onTap: (){
                      Get.to(  () => EmpJobComplete());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Colors.green,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 20,
                                offset: Offset(0 , 2),
                                color: Color.fromRGBO(167, 169, 183, 0.1)
                            ),
                          ]
                      ),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                                child: Image.asset("assets/images/area.png",)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Job name comes here',
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontFamily: "Outfit",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      // letterSpacing: -0.3,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Text(
                                      'Mar 03, 2023',
                                      style: TextStyle(
                                        color: Color(0xff9D9FAD),
                                        fontFamily: "Outfit",
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500,
                                        // letterSpacing: -0.3,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/locationfill.svg',
                                      ),
                                      Text(
                                        "No 15 uti street off ovie palace road effurun ..",
                                        style: const TextStyle(
                                          color: Color(0xff9D9FAD),
                                          fontFamily: "Outfit",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    "\$22",
                                    style: TextStyle(
                                      color: Color(0xff2B65EC),
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Container(
                                    width: 67,
                                    height: 19,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFFDACC),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "On Going",
                                        style: TextStyle(
                                          color: Color(0xffFF4700),
                                          fontFamily: "Outfit",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}

List menuList = [
  _MenuItemList("assets/images/jobarea.svg", "Heart Beat", 'N/A', Colors.grey),
  _MenuItemList("assets/images/jobarea.svg", "Heart Beat", 'N/A', Colors.grey),
  _MenuItemList(
      "assets/images/jobarea.svg", "Blood Prure", 'N/A', Colors.black12),
  _MenuItemList(
      "assets/images/jobarea.svg", "Blood Pressure", 'N/A', Colors.black12),
];

class _MenuItemList {
  final String image;
  final String title;
  final String subTitle;
  final Color color;

  _MenuItemList(this.image, this.title, this.subTitle, this.color);
}
