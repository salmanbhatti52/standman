import 'dart:convert';

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
  bool IsLoading = false;
  List previousData = [];

  getPreviousJobs() async {
    setState(() {
      IsLoading = true;
    });
    // await Future.delayed(Duration(seconds: 2));
    http.Response response = await http.post(
      Uri.parse(getPreviousJobsModelApiUrl),
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
            previousData = jsonResponse['data'];
            print("ongoingData: $previousData");
            IsLoading = false;
          } else {
            // Handle the case when 'data' is null or not of type List<dynamic>
            print("Invalid 'data' value");
            IsLoading = false;
          }
        } else {
          print("Response Bode::${response.body}");
          IsLoading = false;
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreviousJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IsLoading ? Center(
        child: Lottie.asset(
          "assets/images/loading.json",
          height: 50,
        ),
      ) :

      previousData.isNotEmpty
          ? RefreshIndicator(
        onRefresh: () async {
          await getPreviousJobs();
        },
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: previousData.length,
                  itemBuilder: (BuildContext context, int i) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(  () =>
                            Customer_AddRating(
                              ratings: "${previousData[i]['jobs_ratings'] != null && previousData[i]['jobs_ratings']['rating'] != null ? previousData[i]['jobs_ratings']['rating'] : '--'}",
                              employeeId: "${previousData[i]['users_employee_data'] != null && previousData[i]['users_employee_data']['users_customers_id'] != null ? previousData[i]['users_employee_data']['users_customers_id'] : previousData[i]['users_employee_data']['users_customers_id']}",
                              customerId: "${previousData[i]['users_customers_data']['users_customers_id']}",
                              image: "$baseUrlImage${previousData[i]['image']}",
                              jobId: "${previousData[i]['jobs_id']}",
                              jobName:"${previousData[i]['name']}",
                              totalPrice: "${previousData[i]['total_price']}",
                              address: "${previousData[i]['location']}",
                              completeJobTime: "${previousData[i]['date_added']}",
                              description: "${previousData[i]['description'] != null ? {previousData[i]['description']} : ""}",
                              name: previousData[i]['users_employee_data'] != null && previousData[i]['users_employee_data']['first_name'] != null ? "${previousData[i]['users_employee_data']['first_name']} ${previousData[i]['users_employee_data']['last_name']}" : "${previousData[i]['users_employee_data']['first_name']} ${previousData[i]['users_employee_data']['last_name']}",
                              profilePic: "$baseUrlImage${previousData[i]['users_employee_data'] != null && previousData[i]['users_employee_data']['profile_pic'] != null ? previousData[i]['users_employee_data']['profile_pic'] : previousData[i]['users_employee_data']['profile_pic']}",
                              status: "${previousData[i]['status']}",
                            )
                        );
                      },
                      child: Container(
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
                                child: FadeInImage(
                                  placeholder: AssetImage(
                                    "assets/images/fade_in_image.jpeg",
                                  ),
                                  fit: BoxFit.fill,
                                  width: 115,
                                  height: 96,
                                  image: NetworkImage(
                                      "$baseUrlImage${previousData[i]['image']}"),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * 0.32,
                                    child: AutoSizeText(
                                      // 'Eleanor Pena',
                                      previousData[i]['name'],
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Text(
                                      // 'Mar 03, 2023',
                                      previousData[i]['date_added'],
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
                                          backgroundImage: previousData[i]
                                                          ['users_employee_data']
                                                      ['profile_pic'] ==
                                                  null
                                              ? Image.asset(
                                                      "assets/images/person2.png")
                                                  .image
                                              : NetworkImage(baseUrlImage +
                                                  previousData[i]['users_employee_data']
                                                      ['profile_pic'])
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
                                              "${previousData[i]['users_employee_data']['first_name']} ${previousData[i]['users_employee_data']['last_name']}",
                                              // "${previousJobsController.getPreviousJobsModel.data?[index].usersCustomersData?.firstName} ${previousJobsController.getPreviousJobsModel.data?[index].usersCustomersData?.lastName}",
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
                                                  "${previousData[i]['jobs_ratings'] != null && previousData[i]['jobs_ratings']['rating'] != null ? previousData[i]['jobs_ratings']['rating'] : '--'}",
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
                                    "${previousData[i]['status']}",
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
                        ),
                      ),
                    );
                  },
                ),
              ),
          )
          : Center(child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "No Previous Jobs Are Found",
            style: TextStyle(
              color: Color(0xff2B65EC),
              fontFamily: "Outfit",
              fontWeight: FontWeight.w500,
              fontSize: 32,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Get.height * 0.1,
          ),
          SvgPicture.asset(
            'assets/images/cartoon.svg',
          ),
        ],
      )),
    );
  }
}
