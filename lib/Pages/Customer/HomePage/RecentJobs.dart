import 'package:StandMan/Pages/Bottombar.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/get_OnGoing_jobs_Model.dart';
import '../../../Models/users_profilet_model.dart';
import '../../../Utils/api_urls.dart';
import 'package:http/http.dart' as http;
import 'HomePage.dart';

class RecentJobs extends StatefulWidget {
  dynamic getJobModel;
  RecentJobs({Key? key, this.getJobModel}) : super(key: key);
  @override
  _RecentJobsState createState() => _RecentJobsState();
}

class _RecentJobsState extends State<RecentJobs> {
  @override
  Widget build(BuildContext context) {
    return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            margin: EdgeInsets.only( left: 5),
            // padding: EdgeInsets.all( 10),
            // width: MediaQuery.of(context).size.width * 0.51,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, 2),
                      color: Color.fromRGBO(167, 169, 183, 0.1)),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child:
                    // Image.asset("assets/images/jobarea.png", width: 96, height: 96,),
                    FadeInImage(
                      placeholder:  AssetImage("assets/images/fade_in_image.jpeg",),
                      fit: BoxFit.fill,
                      width: 115,
                      height: 96,
                      image: NetworkImage(baseUrlImage+"${widget.getJobModel['image']}"),
                    ),
                  ),
                  SizedBox(width: Get.width * 0.02,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width * 0.32,
                        child: AutoSizeText(
                          // 'Eleanor Pena',
                          "${widget.getJobModel['name'].toString()}",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: "Outfit",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
// letterSpacing: -0.3,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          presetFontSizes: [11],
                          maxFontSize: 11,
                          minFontSize: 11,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0),
                        child: Text(
                          // 'Mar 03, 2023',
                          "${widget.getJobModel['date_added']}",
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
                      Text(
                        'Taken By',
                        style: TextStyle(
                          color: Color(0xff2B65EC),
                          fontFamily: "Outfit",
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Image.asset("assets/images/g1.png"),
                          CircleAvatar(
                            // radius: (screenWidth > 600) ? 90 : 70,
                            //   radius: 50,
                              backgroundColor: Colors.transparent,
                              backgroundImage: widget.getJobModel['users_employee_data']['profile_pic'] == null
                                  ? Image.asset("assets/images/person2.png").image
                                  : NetworkImage(baseUrlImage+"${widget.getJobModel['users_employee_data']['profile_pic'].toString()}")
                            // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)

                          ),
                          // CircleAvatar(
                          //     backgroundColor: Colors.transparent,
                          //     backgroundImage: profilePic1 == null
                          //         ? Image.asset("assets/images/g1.png").image
                          //         : NetworkImage(baseUrlImage+getJobsModel.data!.profilePic.toString())
                          // ),
                          // CircleAvatar(
                          //   backgroundColor: Colors.transparent,
                          //   backgroundImage: NetworkImage(
                          //       "$baseUrlImage${getJobsModel.data?[index].}"),),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 65,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // 'Wade Warren',
                                  "${widget.getJobModel['users_employee_data']['first_name']} ${widget.getJobModel['users_employee_data']['last_name']}",
                                  // "${usersProfileModel.data?.firstName} ${usersProfileModel.data?.lastName}",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontFamily: "Outfit",
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
// letterSpacing: -0.3,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                        "assets/images/star.png"),
                                    Text(
                                      '--',
                                      // getJobsModel.data?[index].rating,
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontFamily: "Outfit",
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),),
        ],
      ),
    );
  }
}

List menuList = [
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
