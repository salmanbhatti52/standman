import 'dart:convert';

import 'package:StandMan/Pages/Customer/HomePage/HomePage.dart';
import 'package:StandMan/widgets/MyButton.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Models/get_OnGoing_jobs_Model.dart';
import '../../../../Models/jobs_action_employees_Model.dart';
import '../../../../Models/users_profilet_model.dart';
import '../../../../Utils/api_urls.dart';
import '../../HomePage/FindPlace.dart';
import '../Customer_AddRating/Customer_JobsDetails_AddRating.dart';
import '../Customer_Complete_with_QR/Customer_JobDetail_CompleteQR.dart';
import 'package:http/http.dart' as http;

class CustomerOnGoingJobList extends StatefulWidget {
  @override
  _CustomerOnGoingJobListState createState() => _CustomerOnGoingJobListState();
}

class _CustomerOnGoingJobListState extends State<CustomerOnGoingJobList> {


  bool isLoading = false;
  List ongoingData = [];

  getJobsCustomer() async {
    setState(() {
      isLoading = true;
    });
    // await Future.delayed(Duration(seconds: 2));
    http.Response response = await http.post(
      Uri.parse(getOngoingJobsModelApiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
      },
    );
    if (mounted) {
      setState(() {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);

          if (jsonResponse['data'] != null && jsonResponse['data'] is List<dynamic>) {
            ongoingData = jsonResponse['data'];
            print("ongoingData: $ongoingData");
            isLoading = false;
          } else {
            // Handle the case when 'data' is null or not of type List<dynamic>
            print("Invalid 'data' value");
            isLoading = false;
          }
        } else {
          print("Response Body ::${response.body}");
          isLoading = false;
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print("users_customers_id: ${usersCustomersId}");
    super.initState();
    getJobsCustomer();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isLoading ? Center(
        child: Lottie.asset(
          "assets/images/loading.json",
          height: 50,
        ),
      ) :

      ongoingData.isEmpty  ?


      // Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(left: 10.0),
      //         child: const Text(
      //           "You did not created\nany job,",
      //           style: TextStyle(
      //             color: Colors.black,
      //             fontFamily: "Outfit",
      //             fontWeight: FontWeight.w500,
      //             fontSize: 32,
      //           ),
      //           textAlign: TextAlign.left,
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(left: 10.0),
      //         child: const Text(
      //           "Please create your Job now..!",
      //           style: TextStyle(
      //             color: Color(0xff2B65EC),
      //             fontFamily: "Outfit",
      //             fontWeight: FontWeight.w500,
      //             fontSize: 24,
      //           ),
      //           textAlign: TextAlign.left,
      //         ),
      //       ),
      //       GestureDetector(
      //           onTap: () {
      //             Get.to(() => FindPlace());
      //           },
      //           child: mainButton(
      //               "Create Job", Color.fromRGBO(43, 101, 236, 1), context)),
      //       SizedBox(
      //         height: height * 0.02,
      //       ),
      //       SvgPicture.asset(
      //         'assets/images/cartoon.svg',
      //       ),
      //     ]) :
      Center(child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Jobs Are Not Accepted\nBy Employee,",
            style: TextStyle(
              color: Color(0xff2B65EC),
              fontFamily: "Outfit",
              fontWeight: FontWeight.w500,
              fontSize: 32,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: height * 0.1,
          ),
          SvgPicture.asset(
            'assets/images/cartoon.svg',
          ),
        ],
      )) :
           Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: RefreshIndicator(
          onRefresh: () async {
            await getJobsCustomer();
          },
          child: Container(
            // color: Color(0xff9D9FAD),
            // height: MediaQuery.of(context).size.height * 0.16,
            width: 350,
            // height: 150,
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: ongoingData.length,
                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                    onTap: () {
                      Get.toEnd(   () => Customer_JobsDetails_Completed_with_QR(
                        oneSignalId: "${ongoingData[i]["users_customers_data"]["one_signal_id"]}",
                        customerId: "${ongoingData[i]["users_customers_data"]["users_customers_id"]}",
                        employeeId: "${ongoingData[i]["users_employee_data"]["users_customers_id"]}",
                        employee_profilePic: "$baseUrlImage${ongoingData[i]['users_employee_data']['profile_pic']}",
                        employee_name:  "${ongoingData[i]['users_employee_data']['first_name']} ${ongoingData[i]['users_employee_data']['last_name']}",
                        image: "$baseUrlImage${ongoingData[i]['image']}",
                        jobName: ongoingData[i]['name'],
                        totalPrice: ongoingData[i]['total_price'],
                        address: ongoingData[i]['location'],
                        completeJobTime: ongoingData[i]['date_added'].toString(),
                        jobId: ongoingData[i]['jobs_id'].toString(),
                        description: ongoingData[i]['description'] == null ? "" :  ongoingData[i]['description'],
                        name: "${ongoingData[i]['users_employee_data']['first_name']} ${ongoingData[i]['users_employee_data']['last_name']}",
                        profilePic: "$baseUrlImage${ongoingData[i]['users_employee_data']['profile_pic']}",
                        status: ongoingData[i]['status'],
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
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
                                image: NetworkImage("$baseUrlImage${ongoingData[i]['image']}"),
                              ),
                            ),
                            SizedBox(width: Get.width * 0.02,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width * 0.32,
                                  child: AutoSizeText(
                                    // 'Eleanor Pena',
                                    "${ongoingData[i]['name']}",
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
                                    "${ongoingData[i]['date_added']}",
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
                                        backgroundImage: ongoingData[i]['users_employee_data']['profile_pic'] == null
                                            ? Image.asset("assets/images/person2.png").image
                                            : NetworkImage(baseUrlImage+ongoingData[i]['users_employee_data']['profile_pic'].toString())
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
                                            "${ongoingData[i]['users_employee_data']['first_name']} ${ongoingData[i]['users_employee_data']['last_name']}",
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
                            Container(
                              margin: EdgeInsets.only(top: 40),
                              width: Get.width * 0.18,
                              height: 19,
                              decoration: BoxDecoration(
                                color: Color(0xffFFDACC),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  // customerongoingjobstList[index].subTitle,
                                 "${ongoingData[i]['status']}",
                                  style: TextStyle(
                                    color: Color(0xffFF4700),
                                    fontFamily: "Outfit",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

List customerongoingjobstList = [
  _customerongoingjobstList(
      "assets/images/hosp1.png", "Dr. Prem Tiwari", 'On Going', "djf", "sad",
      "hjgh"),
  _customerongoingjobstList(
      "assets/images/hosp1.png", "Dr. Prem Tiwari", 'On Going', "djf", "sda",
      "dsc"),
  _customerongoingjobstList(
      "assets/images/hosp1.png", "Dr. Prem Tiwari", 'On Going', "djf", "sac",
      "cddc"),
];

class _customerongoingjobstList {
  final String image;
  final String title;
  final String subTitle;
  final String image2;
  final String text;
  final String button;

  _customerongoingjobstList(this.image, this.title, this.subTitle, this.image2,
      this.text, this.button);
}

//
//
//

// Column(
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
// child: Container(
// height: MediaQuery.of(context).size.height * 0.17,
// // height: 120,
// width: double.infinity,
// child: ListView.builder(
// shrinkWrap: true,
// scrollDirection: Axis.vertical,
// itemCount: 3,
// itemBuilder: (BuildContext context, int index) {
// return Container(
// // height: MediaQuery.of(context).size.height * 0.4,
// // height: 112,
// // width: 203,
// width: MediaQuery.of(context).size.width * 0.56,
// decoration: BoxDecoration(
// // color: Colors.green,
// boxShadow: [
// BoxShadow(
// spreadRadius: 0,
// blurRadius: 20,
// offset: Offset(0 , 2),
// color: Color.fromRGBO(167, 169, 183, 0.1)
// ),
// ]
// ),
// child: Card(
// elevation: 0,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10)),
// child: Padding(
// padding: const EdgeInsets.all(10.0),
// child: Row(
// children: [
// ClipRRect(
// borderRadius: BorderRadius.circular(10.0),
// child: Image.asset("assets/images/jobarea.png", width: 96, height: 96,)),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Eleanor Pena',
// style: TextStyle(
// color: Color(0xff000000),
// fontFamily: "Outfit",
// fontSize: 12,
// fontWeight: FontWeight.w500,
// // letterSpacing: -0.3,
// ),
// textAlign: TextAlign.left,
// ),
// Padding(
// padding: const EdgeInsets.symmetric(vertical: 5.0),
// child: Text(
// 'Mar 03, 2023',
// style: TextStyle(
// color: Color(0xff9D9FAD),
// fontFamily: "Outfit",
// fontSize: 8,
// fontWeight: FontWeight.w500,
// // letterSpacing: -0.3,
// ),
// textAlign: TextAlign.left,
// ),
// ),
// Text(
// 'Taken By',
// style: TextStyle(
// color: Color(0xff2B65EC),
// fontFamily: "Outfit",
// fontSize: 8,
// fontWeight: FontWeight.w400,
// // letterSpacing: -0.3,
// ),
// textAlign: TextAlign.left,
// ),
// SizedBox(height: 8,),
// Row(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Image.asset("assets/images/g1.png"),
// SizedBox(width: 5,),
// Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Wade Warren',
// style: TextStyle(
// color: Color(0xff000000),
// fontFamily: "Outfit",
// fontSize: 8,
// fontWeight: FontWeight.w500,
// // letterSpacing: -0.3,
// ),
// textAlign: TextAlign.left,
// ),
// Row(
// children: [
// Image.asset(
// "assets/images/star.png"),
// Text(
// '4.5',
// style: TextStyle(
// color: Color(0xff000000),
// fontFamily: "Outfit",
// fontSize: 8,
// fontWeight: FontWeight.w400,
// // letterSpacing: -0.3,
// ),
// textAlign: TextAlign.left,
// ),
// ],
// )
// ],
// )
// ],
// )
// ],
// ),
// ),
// ],
// ),
// ),
// ),
// );
// }),
// ),
// ),
// ],
// );
