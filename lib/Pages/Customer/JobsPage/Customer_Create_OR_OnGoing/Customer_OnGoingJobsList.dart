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

  GetJobsModel getJobsModel = GetJobsModel();
  bool loading = false;

  getJobs() async {
    setState(() {
      loading = true;
    });
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    print("userId in Prefs is = $usersCustomersId");
    String apiUrl = getOngoingJobsModelApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
      },
    );
    final responseString = response.body;
    print("getJobsModelApi: ${response.body}");
    print("status Code getJobsModel: ${response.statusCode}");
    print("in 200 getJobs");
    if (response.statusCode == 200) {
      getJobsModel = getJobsModelFromJson(responseString);
      // setState(() {});
      print('getJobsModelImage: $baseUrlImage${getJobsModel.data?[0].image}');
      print('getJobsModelLength: ${getJobsModel.data?.length}');
      print('getJobsModelemployeeusersCustomersType: ${ getJobsModel.data?[0].usersEmployeeData?.usersCustomersId}');
      setState(() {
        loading = false;
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    print("users_customers_id: ${usersCustomersId}");
    super.initState();
    getJobs();
    // getUserProfileWidget();
  }

  UsersProfileModel usersProfileModel = UsersProfileModel();
  bool progress = false;
  bool isInAsyncCall = false;

  // getUserProfileWidget() async {
  //   progress = true;
  //   setState(() {});
  //
  //   prefs = await SharedPreferences.getInstance();
  //   usersCustomersId = prefs!.getString('usersCustomersId');
  //   print("userId in Prefs is = $usersCustomersId");
  //
  //   try {
  //     String apiUrl = usersProfileApiUrl;
  //     print("getUserProfileApi: $apiUrl");
  //     final response = await http.post(Uri.parse(apiUrl),
  //         body: {
  //           "users_customers_id": usersCustomersId.toString(),
  //         }, headers: {
  //           'Accept': 'application/json'
  //         });
  //     print('${response.statusCode}');
  //     print(response);
  //     if (response.statusCode == 200) {
  //       final responseString = response.body;
  //       print("getUserProfileResponse: ${responseString.toString()}");
  //       usersProfileModel = usersProfileModelFromJson(responseString);
  //       progress = false;
  //       setState(() {});
  //       print("getUserName: ${usersProfileModel.data!.fullName}");
  //       print("getUserEmail: ${usersProfileModel.data!.email}");
  //       print("getUserNumber: ${usersProfileModel.data!.phone}");
  //       print("usersCustomersId: ${usersProfileModel.data!.usersCustomersId}");
  //       print(
  //           "getUserProfileImage: $baseUrlImage${usersProfileModel.data!.profilePic}");
  //     }
  //   } catch (e) {
  //     print('Error in getUserProfileWidget: ${e.toString()}');
  //   }
  //   progress = false;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: loading ? Center(
        child: Lottie.asset(
          "assets/images/loading.json",
          height: 50,
        ),
      ) :

      getJobsModel.data?.length == null ?


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
        child: Container(
          // color: Color(0xff9D9FAD),
          // height: MediaQuery.of(context).size.height * 0.16,
          width: 350,
          // height: 150,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: getJobsModel.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(Customer_JobsDetails_Completed_with_QR(
                      customerId: "${getJobsModel.data?[index].usersCustomersData?.usersCustomersId}",
                      employeeId: "${getJobsModel.data?[index].usersEmployeeData?.usersCustomersId}",
                      employee_profilePic: "$baseUrlImage${getJobsModel.data?[index].usersEmployeeData?.profilePic}",
                      employee_name: "${getJobsModel.data?[index].usersEmployeeData?.firstName} ${getJobsModel.data?[index].usersEmployeeData?.lastName}",
                      image: "$baseUrlImage${getJobsModel.data?[index].image}",
                      jobName: getJobsModel
                          .data?[index].name,
                      totalPrice: getJobsModel
                          .data?[index].totalPrice,
                      address: getJobsModel
                          .data?[index].location,
                      completeJobTime: getJobsModel
                          .data?[index].dateAdded
                          .toString(),
                      jobId: "${getJobsModel.data?[index].jobsId}",
                      description: getJobsModel
                          .data?[index].description == null ? "" : getJobsModel
                          .data?[index].description,
                      name: "${getJobsModel.data?[index].usersEmployeeData?.firstName} ${getJobsModel.data?[index].usersEmployeeData?.lastName}",
                      profilePic: "$baseUrlImage${getJobsModel.data?[index].usersEmployeeData?.profilePic}",
                      status: getJobsModel.data![index].status,
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
                              image: NetworkImage("$baseUrlImage${getJobsModel.data?[index].image}"),
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
                                  "${getJobsModel.data?[index].name.toString()}",
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
                                  "${getJobsModel.data?[index].dateAdded}",
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
                                      backgroundImage: getJobsModel.data![index].usersCustomersData!.profilePic == null
                                          ? Image.asset("assets/images/person2.png").image
                                          : NetworkImage(baseUrlImage+getJobsModel.data![index].usersEmployeeData!.profilePic.toString())
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
                                          "${getJobsModel.data?[index].usersEmployeeData?.firstName} ${getJobsModel.data?[index].usersEmployeeData?.lastName}",
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
                               "${ getJobsModel.data?[index].status.toString()}",
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
