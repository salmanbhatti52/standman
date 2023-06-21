import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:StandMan/Pages/Customer/HomePage/HomePage.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Controllers/PreviousJobsController.dart';
import '../../../../Models/get_previous_jobs_Model.dart';
import '../../../../Models/users_profilet_model.dart';
import '../../../../Utils/api_urls.dart';
import 'package:http/http.dart' as http;

import '../Customer_AddRating/Customer_JobsDetails_AddRating.dart';

class Customer_PreviousJobs extends StatefulWidget {
  const Customer_PreviousJobs({Key? key}) : super(key: key);

  @override
  State<Customer_PreviousJobs> createState() => _Customer_PreviousJobsState();
}

class _Customer_PreviousJobsState extends State<Customer_PreviousJobs> {


  PreviousJobsController previousJobsController = Get.put(PreviousJobsController());

  // GetPreviousJobsModel getPreviousJobsModel = GetPreviousJobsModel();

  // bool loading = false;
  // getPreviousJobs() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   String apiUrl = getPreviousJobsModelApiUrl;
  //   print("working");
  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: {"Accept": "application/json"},
  //     body: {
  //       "users_customers_id": usersCustomersId,
  //     },
  //   );
  //   final responseString = response.body;
  //   print("getPreviousJobsModelApi: ${response.body}");
  //   if (response.statusCode == 200) {
  //     getPreviousJobsModel = getPreviousJobsModelFromJson(responseString);
  //     print('getPreviousJobsModel status: ${getPreviousJobsModel.status}');
  //     print('getPreviousJobsModelLength: ${getPreviousJobsModel.data?.length}');
  //     // setState(() {});
  //   }
  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    previousJobsController.fetchPreviousJobs();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: previousJobsController.isLoading.value  ? Center(
        child: Lottie.asset(
          "assets/images/loading.json",
          height: 100,
        ),
      ):
      Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Container(
                // height: height * 0.6,
                // width: dou,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: previousJobsController.getPreviousJobsModel.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          Get.to(
                              Customer_AddRating(
                                ratings: "${previousJobsController.getPreviousJobsModel.data?[index].jobsRatings?.rating == null ? 0.0 : previousJobsController.getPreviousJobsModel.data?[index].jobsRatings?.rating}",
                                employeeId: "${previousJobsController.getPreviousJobsModel.data?[index].usersEmployeeData?.usersCustomersId}",
                                customerId: "${previousJobsController.getPreviousJobsModel.data?[index].usersCustomersData?.usersCustomersId}",
                                image: "$baseUrlImage${previousJobsController.getPreviousJobsModel.data?[index].image}",
                                jobId: "${previousJobsController.getPreviousJobsModel.data?[index].jobsId}",
                                jobName: previousJobsController.getPreviousJobsModel.data?[index].name,
                                totalPrice: previousJobsController.getPreviousJobsModel.data?[index].totalPrice,
                                address: previousJobsController.getPreviousJobsModel.data?[index].location,
                                completeJobTime: previousJobsController.getPreviousJobsModel.data?[index].dateAdded.toString(),
                                description: previousJobsController.getPreviousJobsModel.data?[index].description,
                                name: "${previousJobsController.getPreviousJobsModel.data?[index].usersEmployeeData?.firstName} ${previousJobsController.getPreviousJobsModel.data?[index].usersEmployeeData?.lastName}",
                                profilePic: "$baseUrlImage${previousJobsController.getPreviousJobsModel.data?[index].usersEmployeeData?.profilePic}",
                                status: previousJobsController.getPreviousJobsModel.data?[index].status,
                              )
                          );
                        },
                        child:  Container(
                          margin: EdgeInsets.only(top: 5),
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
                                  FadeInImage(
                                    placeholder:  AssetImage("assets/images/fade_in_image.jpeg",),
                                    fit: BoxFit.fill,
                                    width: 115,
                                    height: 96,
                                    image: NetworkImage("$baseUrlImage${previousJobsController.getPreviousJobsModel.data?[index].image}"),
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
                                        "${previousJobsController.getPreviousJobsModel.data?[index].name.toString()}",
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: "Outfit",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
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
                                        "${previousJobsController.getPreviousJobsModel.data?[index].dateAdded}",
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
                                            backgroundImage: previousJobsController.getPreviousJobsModel.data![index].usersCustomersData!.profilePic == null
                                                ? Image.asset("assets/images/person2.png").image
                                                : NetworkImage(baseUrlImage+previousJobsController.getPreviousJobsModel.data![index].usersCustomersData!.profilePic.toString())
                                          // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)

                                        ),
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
                                                "${previousJobsController.getPreviousJobsModel.data?[index].usersCustomersData?.firstName} ${previousJobsController.getPreviousJobsModel.data?[index].usersCustomersData?.lastName}",
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
                                                    "${previousJobsController.getPreviousJobsModel.data?[index].jobsRatings?.rating == null ? '--' : previousJobsController.getPreviousJobsModel.data?[index].jobsRatings?.rating }",
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
                                      "${previousJobsController.getPreviousJobsModel.data?[index].status.toString()}",
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
            );
      }),
      // Customer_PreviousJobList(),
    );
  }
}
