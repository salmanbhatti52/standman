import 'package:StandMan/Pages/Customer/HomePage/HomePage.dart';
import 'package:StandMan/widgets/MyButton.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../Models/get_OnGoing_jobs_Model.dart';
import '../../../../Models/users_profilet_model.dart';
import '../../../../Utils/api_urls.dart';
import 'package:http/http.dart' as http;

import '../../../Models/Customer_MyJobs_model.dart';
import '../HomePage/FindPlace.dart';
import 'Customer_MyJobs_Details.dart';

class CustomerMyJobList extends StatefulWidget {
  @override
  _CustomerMyJobListState createState() => _CustomerMyJobListState();
}

class _CustomerMyJobListState extends State<CustomerMyJobList> {

  CustomerMyJobModel customerMyJobModel = CustomerMyJobModel();

  bool loading = false;

  myJobs() async {
   
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    print("userId in Prefs is = $usersCustomersId");
    String apiUrl = CustomerMyJobModelApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": usersCustomersId,
      },
    );
    final responseString = response.body;
    print("myJObsModelApi: ${response.body}");
    print("status Code myJObs: ${response.statusCode}");
    print("in 200 myJObs");
    if (response.statusCode == 200) {
      customerMyJobModel = customerMyJobModelFromJson(responseString);
      // setState(() {});
      print('getJobsModelImage: $baseUrlImage${customerMyJobModel.data?[0].image}');
      print('getJobsModelLength: ${customerMyJobModel.data?.length}');
      setState(() {

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print("users_customers_id: ${usersCustomersId}");
    super.initState();
    myJobs();
    // getUserProfileWidget();
  }

  // UsersProfileModel usersProfileModel = UsersProfileModel();
  // bool progress = false;
  // bool isInAsyncCall = false;

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
      body: loading ?
      // ListView.separated(
      //   itemCount: 5,
      //   itemBuilder: (context, index) => const NewsCardSkelton(),
      //   separatorBuilder: (context, index) =>
      //   const SizedBox(height: defaultPadding),
      // )
      Center(child: CircularProgressIndicator(color: Colors.blueAccent,),)
          : customerMyJobModel.data?.length == null ?

      Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: const Text(
                "You did not created\nany job,",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Outfit",
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: const Text(
                "Please create your Job now..!",
                style: TextStyle(
                  color: Color(0xff2B65EC),
                  fontFamily: "Outfit",
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            GestureDetector(
                onTap: () {
                  Get.to(() => FindPlace());
                },
                child: mainButton(
                    "Create Job", Color.fromRGBO(43, 101, 236, 1), context)),
            SizedBox(
              height: height * 0.02,
            ),
            SvgPicture.asset(
              'assets/images/cartoon.svg',
            ),
          ],)
      // Center(child:  Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     const Text(
      //       "Jobs Are Not Accepted\nBy Employee,",
      //       style: TextStyle(
      //         color: Color(0xff2B65EC),
      //         fontFamily: "Outfit",
      //         fontWeight: FontWeight.w500,
      //         fontSize: 32,
      //       ),
      //       textAlign: TextAlign.center,
      //     ),
      //     SizedBox(
      //               height: height * 0.1,
      //             ),
      //           SvgPicture.asset(
      //             'assets/images/cartoon.svg',
      //           ),
      //   ],
      // ))
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal:20, vertical: 5),
        child: Container(
          // color: Color(0xff9D9FAD),
          // height: MediaQuery.of(context).size.height * 0.16,
          width: 350,
          // height: 150,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: customerMyJobModel.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(CustomerMyJobsDetails(
                      image: "$baseUrlImage${customerMyJobModel.data?[index].image}",
                      jobName: customerMyJobModel.data?[index].name,
                      totalPrice: customerMyJobModel.data?[index].totalPrice,
                      address: customerMyJobModel.data?[index].location,
                      completeJobTime: customerMyJobModel.data?[index].dateAdded.toString(),
                      description: customerMyJobModel.data?[index].description,
                      name: "${customerMyJobModel.data?[index].usersCustomersData?.firstName} ${customerMyJobModel.data?[index].usersCustomersData?.lastName}",
                      profilePic: "$baseUrlImage${customerMyJobModel.data?[index].usersCustomersData?.profilePic}",
                      status: customerMyJobModel.data![index].status,
                    ),);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all( 10),
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
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            image: NetworkImage("$baseUrlImage${customerMyJobModel.data?[index].image}"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // 'Eleanor Pena',
                                "${customerMyJobModel.data?[index].name.toString()}",
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0),
                                child: Text(
                                  // 'Mar 03, 2023',
                                  "${customerMyJobModel.data?[index].dateAdded}",
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
//                                 Text(
//                                   'Taken By',
//                                   style: TextStyle(
//                                     color: Color(0xff2B65EC),
//                                     fontFamily: "Outfit",
//                                     fontSize: 8,
//                                     fontWeight: FontWeight.w400,
// // letterSpacing: -0.3,
//                                   ),
//                                   textAlign: TextAlign.left,
//                                 ),
//                                 SizedBox(
//                                   height: 8,
//                                 ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image.asset("assets/images/g1.png"),
                                  // CircleAvatar(
                                  //   // radius: (screenWidth > 600) ? 90 : 70,
                                  //   //   radius: 50,
                                  //     backgroundColor: Colors.transparent,
                                  //     backgroundImage: getJobsModel.data![index].usersCustomersData!.profilePic == null
                                  //         ? Image.asset("assets/images/person2.png").image
                                  //         : NetworkImage(baseUrlImage+getJobsModel.data![index].usersCustomersData!.profilePic)
                                  //
                                  // ),
                                  SvgPicture.asset("assets/images/locationfill.svg", width: 20,),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    // width: 65,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
//                                         Text(
//                                          "${customerMyJobModel.data?[index].location}",
//                                           style: TextStyle(
//                                             color: Color(0xff000000),
//                                             fontFamily: "Outfit",
//                                             fontSize: 8,
//                                             fontWeight: FontWeight.w500,
// // letterSpacing: -0.3,
//                                           ),
//                                           textAlign: TextAlign.left,
//                                         ),
                                        Container(
                                          width: width * 0.37,
                                          child: AutoSizeText(
                                            "${customerMyJobModel.data?[index].location}",
                                      style: TextStyle(
                                              color: Color(0xff000000),
                                              fontFamily: "Outfit",
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                      ),
                                            maxLines: 2,
                                            minFontSize: 8,
                                            maxFontSize: 8,
                                            textAlign: TextAlign.left,
                                            presetFontSizes: [8],

                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                         "${customerMyJobModel.data?[index].dateModified}",
                                          style: TextStyle(
                                            color: Color(0xff000000),
                                            fontFamily: "Outfit",
                                            fontSize: 8,
                                            fontWeight: FontWeight.w500,
// letterSpacing: -0.3,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
//                           Container(
//                             margin: EdgeInsets.only(top: 40, left: 2),
//                             width: 67,
//                             height: 19,
//                             decoration: BoxDecoration(
//                               color: Color(0xffFFDACC),
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 // customerongoingjobstList[index].subTitle,
//                                 "${ getJobsModel.data?[index].status.toString()}",
//                                 style: TextStyle(
//                                   color: Color(0xffFF4700),
//                                   fontFamily: "Outfit",
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w400,
// // letterSpacing: -0.3,
//                                 ),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                           ),
                      ],
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


class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Skeleton(height: 120, width: 120),
        const SizedBox(width: defaultPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skeleton(width: 80),
              const SizedBox(height: defaultPadding / 2),
              const Skeleton(),
              const SizedBox(height: defaultPadding / 2),
              const Skeleton(),
              const SizedBox(height: defaultPadding / 2),
              Row(
                children:  [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding:  EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius:
           BorderRadius.all(Radius.circular(defaultPadding),),),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}

const Color primaryColor = Color(0xFF2967FF);
const Color grayColor = Color(0xFF8D8D8E);

const double defaultPadding = 16.0;