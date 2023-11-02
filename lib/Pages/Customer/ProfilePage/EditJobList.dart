import 'dart:convert';
import 'package:StandMan/Models/jobeditListModels.dart';
import 'package:StandMan/Pages/Customer/ProfilePage/EditJobs.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/TopBar.dart';
import 'package:http/http.dart' as http;
import '../HomePage/HomePage.dart';

class EditJobList extends StatefulWidget {
  const EditJobList({Key? key}) : super(key: key);

  @override
  State<EditJobList> createState() => _EditJobListState();
}

class _EditJobListState extends State<EditJobList> {
  bool isLoading = false;

  JobEditListModels jobEditListModels = JobEditListModels();
  Editjoblist() async {
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    print("userId in Prefs is = $usersCustomersId");
    String apiUrl = "https://admin.standman.ca/api/customer_editable_jobs";
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
      },
    );
    final responseString = response.body;
    print("jobEditListModels: ${response.body}");
    print("status Code jobEditListModels: ${response.statusCode}");
    print("in 200 jobEditListModels");
    if (response.statusCode == 200) {
      jobEditListModels = jobEditListModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('jobEditListModels status: ${jobEditListModels.status}');
      // print('jobEditListModels status: ${jobEditListModels}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Editjoblist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandManAppBar1(
        title: "Edit Jobs",
        bgcolor: Color(0xff2B65EC),
        titlecolor: Colors.white,
        iconcolor: Colors.white,
      ),
      body: isLoading
          ? Center(
              child: Lottie.asset(
                "assets/images/loading.json",
                height: 50,
              ),
            )
          : jobEditListModels.data != null && jobEditListModels.data!.isEmpty
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Jobs Are Not Available",
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
                ))
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Container(
                    // color: Color(0xff9D9FAD),
                    // height: MediaQuery.of(context).size.height * 0.16,
                    width: 350,
                    // height: 150,
                    child: jobEditListModels.data != null
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: jobEditListModels.data!.length,
                            itemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => EditJob(
                                      jobDate: jobEditListModels
                                          .data![index].startDate
                                          .toString(),
                                      startTime: jobEditListModels
                                          .data![index].startTime
                                          .toString(),
                                      endTime: jobEditListModels
                                          .data![index].endTime
                                          .toString(),
                                      jobid: jobEditListModels
                                          .data![index].jobsId
                                          .toString()));
                                  // Get.to(Customer_JobsDetails_Completed_with_QR(
                                  //   oneSignalId: "${ongoingData[i]["users_customers_data"]["one_signal_id"]}",
                                  //   customerId: "${ongoingData[i]["users_customers_data"]["users_customers_id"]}",
                                  //   employeeId: "${ongoingData[i]["users_employee_data"]["users_customers_id"]}",
                                  //   employee_profilePic: "$baseUrlImage${ongoingData[i]['users_employee_data']['profile_pic']}",
                                  //   employee_name:  "${ongoingData[i]['users_employee_data']['first_name']} ${ongoingData[i]['users_employee_data']['last_name']}",
                                  //   image: "$baseUrlImage${ongoingData[i]['image']}",
                                  //   jobName: ongoingData[i]['name'],
                                  //   totalPrice: ongoingData[i]['total_price'],
                                  //   address: ongoingData[i]['location'],
                                  //   completeJobTime: ongoingData[i]['date_added'].toString(),
                                  //   jobId: ongoingData[i]['jobs_id'].toString(),
                                  //   description: ongoingData[i]['description'] == null ? "" :  ongoingData[i]['description'],
                                  //   name: "${ongoingData[i]['users_employee_data']['first_name']} ${ongoingData[i]['users_employee_data']['last_name']}",
                                  //   profilePic: "$baseUrlImage${ongoingData[i]['users_employee_data']['profile_pic']}",
                                  //   status: ongoingData[i]['status'],
                                  // ));
                                },
                                child: Card(
                                  color: Colors.white,
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5),
                                    // padding: EdgeInsets.all( 10),
                                    // width: MediaQuery.of(context).size.width * 0.51,
                                    decoration: BoxDecoration(
                                        color: Colors.white30,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 0,
                                              blurRadius: 20,
                                              offset: Offset(0, 2),
                                              color: Color.fromRGBO(
                                                  167, 169, 183, 0.1)),
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        left: 8,
                                        bottom: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child:
                                                // Image.asset("assets/images/jobarea.png", width: 96, height: 96,),
                                                FadeInImage(
                                              placeholder: AssetImage(
                                                "assets/images/fade_in_image.jpeg",
                                              ),
                                              fit: BoxFit.fill,
                                              width: 115,
                                              height: 96,
                                              image: NetworkImage(
                                                  "$baseUrlImage${jobEditListModels.data![index].image}"),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: Get.width * 0.32,
                                                child: AutoSizeText(
                                                  // 'Eleanor Pena',
                                                  "${jobEditListModels.data![index].name}",
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0),
                                                child: Text(
                                                  // 'Mar 03, 2023',
                                                  "${jobEditListModels.data![index].startDate}",
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  // Image.asset("assets/images/g1.png"),
                                                  CircleAvatar(
                                                    // radius: (screenWidth > 600) ? 90 : 70,
                                                    //   radius: 50,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    backgroundImage:
                                                        (jobEditListModels
                                                                        .data![
                                                                            index]
                                                                        .userData !=
                                                                    null &&
                                                                jobEditListModels
                                                                        .data![
                                                                            index]
                                                                        .userData!
                                                                        .profilePic !=
                                                                    null)
                                                            ? NetworkImage(baseUrlImage +
                                                                jobEditListModels
                                                                    .data![
                                                                        index]
                                                                    .userData!
                                                                    .profilePic
                                                                    .toString())
                                                            : Image.asset(
                                                                    "assets/images/person2.png")
                                                                .image,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: 65,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          child: (jobEditListModels
                                                                          .data![
                                                                              index]
                                                                          .userData !=
                                                                      null &&
                                                                  jobEditListModels
                                                                          .data![
                                                                              index]
                                                                          .userData!
                                                                          .firstName !=
                                                                      null &&
                                                                  jobEditListModels
                                                                          .data![
                                                                              index]
                                                                          .userData!
                                                                          .lastName !=
                                                                      null)
                                                              ? Text(
                                                                  // 'Wade Warren',
                                                                  "${jobEditListModels.data![index].userData!.firstName.toString()} ${jobEditListModels.data![index].userData!.lastName}",
                                                                  // "${usersProfileModel.data?.firstName} ${usersProfileModel.data?.lastName}",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xff000000),
                                                                    fontFamily:
                                                                        "Outfit",
                                                                    fontSize: 8,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    // letterSpacing: -0.3,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                )
                                                              : Text("data"),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                                "assets/images/star.png"),
                                                            Text(
                                                              '--',
                                                              // getJobsModel.data?[index].rating,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    "Outfit",
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                // letterSpacing: -0.3,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
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
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Center(
                                              child: Text(
                                                // customerongoingjobstList[index].subTitle,
                                                "${jobEditListModels.data![index].status}",
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
                                ),
                              );
                            })
                        : SizedBox(),
                  ),
                ),
    );
  }
}
