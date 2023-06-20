import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:StandMan/Pages/Customer/HomePage/HomePage.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  GetPreviousJobsModel getPreviousJobsModel = GetPreviousJobsModel();

  bool loading = false;
  getPreviousJobs() async {
    String apiUrl = getPreviousJobsModelApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
      },
    );
    final responseString = response.body;
    print("getPreviousJobsModelApi: ${response.body}");
    print("status Code getPreviousJobsModel: ${response.statusCode}");
    print("in 200 getPreviousJobs");
    if (response.statusCode == 200) {
      getPreviousJobsModel = getPreviousJobsModelFromJson(responseString);
      // setState(() {});
      print('getPreviousJobsModel status: ${getPreviousJobsModel.status}');
      print('getPreviousJobsModelLength: ${getPreviousJobsModel.data?.length}');
      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print("users_customers_id: ${usersCustomersId}");
    super.initState();
    // getUserProfileWidget();
    getPreviousJobs();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: loading? Center(child: CircularProgressIndicator()):

      getPreviousJobsModel.data?.length == null ?
      Center(child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "No Previous Jobs",
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
      ))
      // : Center(child: Text("No Previous1 Jobs"));
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Container(
          // height: height * 0.6,
          // width: dou,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: getPreviousJobsModel.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    Get.to(
                        Customer_AddRating(
                          ratings: "${getPreviousJobsModel.data?[index].jobsRatings?.rating == null ? 0.0 : getPreviousJobsModel.data?[index].jobsRatings?.rating}",
                          employeeId: "${getPreviousJobsModel.data?[index].usersEmployeeData?.usersCustomersId}",
                          customerId: "${getPreviousJobsModel.data?[index].usersCustomersData?.usersCustomersId}",
                          image: "$baseUrlImage${getPreviousJobsModel.data?[index].image}",
                          jobId: "${getPreviousJobsModel.data?[index].jobsId}",
                          jobName: getPreviousJobsModel.data?[index].name,
                          totalPrice: getPreviousJobsModel.data?[index].totalPrice,
                          address: getPreviousJobsModel.data?[index].location,
                          completeJobTime: getPreviousJobsModel.data?[index].dateAdded.toString(),
                          description: getPreviousJobsModel.data?[index].description,
                          name: "${getPreviousJobsModel.data?[index].usersEmployeeData?.firstName} ${getPreviousJobsModel.data?[index].usersEmployeeData?.lastName}",
                          profilePic: "$baseUrlImage${getPreviousJobsModel.data?[index].usersEmployeeData?.profilePic}",
                          status: getPreviousJobsModel.data?[index].status,
                        )
                    );
                  },
                  child:  Container(
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
                              image: NetworkImage("$baseUrlImage${getPreviousJobsModel.data?[index].image}"),
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
                                  "${getPreviousJobsModel.data?[index].name.toString()}",
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
                                  "${getPreviousJobsModel.data?[index].dateAdded}",
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
                                      backgroundImage: getPreviousJobsModel.data![index].usersCustomersData!.profilePic == null
                                          ? Image.asset("assets/images/person2.png").image
                                          : NetworkImage(baseUrlImage+getPreviousJobsModel.data![index].usersCustomersData!.profilePic.toString())
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
                                          "${getPreviousJobsModel.data?[index].usersCustomersData?.firstName} ${getPreviousJobsModel.data?[index].usersCustomersData?.lastName}",
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
                                              "${getPreviousJobsModel.data?[index].jobsRatings?.rating == null ? '--' : getPreviousJobsModel.data?[index].jobsRatings?.rating }",
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
                                "${ getPreviousJobsModel.data?[index].status.toString()}",
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
      // Customer_PreviousJobList(),
    );
  }
}
