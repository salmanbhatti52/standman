import 'dart:convert';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/TopBar.dart';
import 'package:http/http.dart' as http;
import '../HomePage/HomePage.dart';
import 'EditJobs.dart';

class EditJobList extends StatefulWidget {
  const EditJobList({Key? key}) : super(key: key);

  @override
  State<EditJobList> createState() => _EditJobListState();
}

class _EditJobListState extends State<EditJobList> {

  bool isLoading = false;
  dynamic EditableJobs = [];

  EditableJobsList() async {
    setState(() {
      isLoading = true;
    });
    // await Future.delayed(Duration(seconds: 2));
    http.Response response = await http.post(
      Uri.parse(customerEditableJobs),
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
            EditableJobs = jsonResponse['data'];
            print("EditableJobs: $EditableJobs");
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
    super.initState();
    EditableJobsList();
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
      body: isLoading ? Center(
        child: Lottie.asset(
          "assets/images/loading.json",
          height: 50,
        ),
      ) :
      EditableJobs.isEmpty  ?
      Center(child:  Column(
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
      )) :
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Container(
          // color: Color(0xff9D9FAD),
          // height: MediaQuery.of(context).size.height * 0.16,
          width: 350,
          // height: 150,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: EditableJobs.length,
              itemBuilder: (BuildContext context, int i) {
                return GestureDetector(
                  onTap: () {
                    Get.to(  () => EditJob(
                      jobDate: EditableJobs[i]["start_date"],
                      startTime: EditableJobs[i]["start_time"],
                      endTime: EditableJobs[i]["end_time"],
                    ));
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
                                image: NetworkImage("$baseUrlImage${EditableJobs[i]['image']}"),
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
                                    "${EditableJobs[i]['name']}",
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
                                    "${EditableJobs[i]['start_date']}",
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
                                      backgroundImage: (EditableJobs[i]['user_data'] != null  && EditableJobs[i]['user_data']['profile_pic'] != null )
                                          ? NetworkImage(baseUrlImage + EditableJobs[i]['user_data']['profile_pic'].toString())
                                          : Image.asset("assets/images/person2.png").image,
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
                                          Container(
                                            child: (EditableJobs[i]['user_data'] != null && EditableJobs[i]['user_data']['first_name'] != null&& EditableJobs[i]['user_data']['last_name'] != null) ? Text(
                                              // 'Wade Warren',
                                              "${EditableJobs[i]['user_data']['first_name']} ${EditableJobs[i]['user_data']['last_name']}",
                                              // "${usersProfileModel.data?.firstName} ${usersProfileModel.data?.lastName}",
                                              style: TextStyle(
                                                color: Color(0xff000000),
                                                fontFamily: "Outfit",
                                                fontSize: 8,
                                                fontWeight: FontWeight.w500,
// letterSpacing: -0.3,
                                              ),
                                              textAlign: TextAlign.left,
                                            ): Text("data"),
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
                                  "${EditableJobs[i]['status']}",
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
                  ),
                );
              }),
        ),
      ),
    );
  }
}
