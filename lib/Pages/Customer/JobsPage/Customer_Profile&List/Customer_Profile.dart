import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Models/all_ratings_Model.dart';
import '../../../../Models/chat_start_user_Model.dart';
import '../../../../Utils/api_urls.dart';
import '../../../../widgets/TopBar.dart';
import '../../../Drawer.dart';
import '../../../Employee/HomePage/EmpHomePage.dart';
import '../../HomePage/HomePage.dart';
import '../../MessagePage/MessageDetails.dart';
import '../Customer_JobCompletedBy/Customer_JobsDetails_CompletedBy.dart';
import 'Customer_ProfileList.dart';
import 'package:http/http.dart' as http;

class Customer_Profile extends StatefulWidget {
  String? customerId;
  String? employeeId;
  String? name;
  String? rating;
  String? profilePic;
   Customer_Profile({Key? key, this.customerId, this.employeeId, this.profilePic, this.name, this.rating}) : super(key: key);

  @override
  State<Customer_Profile> createState() => _Customer_ProfileState();
}

class _Customer_ProfileState extends State<Customer_Profile> {


  AllRatingsModel allRatingsModel = AllRatingsModel();
  bool loading = false;

  allJobRating() async {
    // prefs = await SharedPreferences.getInstance();
    // usersCustomersId = prefs!.getString('usersCustomersId');
    // print("userId in Prefs is = $usersCustomersId");
    String apiUrl = allJobRatingModelApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": widget.customerId.toString(),
      },
    );
    final responseString = response.body;
    print("allJobRatingModelApi: ${response.body}");
    print("status Code allJobRatingModel: ${response.statusCode}");
    print("in 200 allJobRatingModel");
    if (response.statusCode == 200) {
      allRatingsModel = allRatingsModelFromJson(responseString);
      setState(() {});
      // print('getJobsModelImage: $baseUrlImage${al.data?[0].image}');
      // print('getJobsModelLength: ${getJobsModel.data?.length}');
      // print('getJobsModelemployeeusersCustomersType: ${ getJobsModel.data?[0].usersEmployeeData?.usersCustomersId}');
      // print('getJobsModelImage: $baseUrlImage${getJobsModel.data![0].image}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allJobRating();
    print("rating ${widget.rating}");
  }

  ChatStartUserModel chatStartUserModel = ChatStartUserModel();

  bool progress = false;

  chatStartUser() async {


    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    empUsersCustomersId = empPrefs?.getString('empUsersCustomersId');
    print("usersCustomersId = $usersCustomersId");
    print("empUsersCustomersId = ${widget.customerId}");

    // try {
    String apiUrl = userChatApiUrl;
    print("userChatApiUrl: $apiUrl");
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "requestType": "startChat",
        "users_customers_id": usersCustomersId,
        "other_users_customers_id": widget.employeeId,
      },
      headers: {'Accept': 'application/json'},
    );
    print('${response.statusCode}');
    print(response);
    print("responseStartChat: $response");
    print("status Code chat: ${response.statusCode}");
    print("in 200 chat");
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("userChatResponse: ${responseString.toString()}");
      chatStartUserModel = chatStartUserModelFromJson(responseString);
      setState(() {});
    }
    // } catch (e) {
    //   print('Error in userChatApiUrl: ${e.toString()}');
    // }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        toolbarHeight: height * 0.10,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.menu, color: Colors.black,),
        //   onPressed: () {
        //     Get.to(MyDrawer());
        //     // Scaffold.of(context).openDrawer();
        //   },
        // ),
        title: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Text(
            "Profile",
            style: TextStyle(
              color: Color(0xff000000),
              fontFamily: "Outfit",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              // letterSpacing: -0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
        Container(
          width: width * 0.9,
          height: height * 0.2,
          decoration: BoxDecoration(
              color: Color(0xff2B65EC),
              borderRadius: BorderRadius.circular(30)
          ),
          child:  Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child:  CircleAvatar(
                  radius: 60,
                    backgroundColor: Colors.transparent,
                    backgroundImage: "${widget.profilePic}" == null
                        ? Image.asset("assets/images/person2.png").image
                        : NetworkImage("${widget.profilePic}"),
                  // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)

                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                   "${widget.name}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Outfit",
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await chatStartUser();
                      Get.to(MessagesDetails(
                        usersCustomersId: widget.customerId,
                        other_users_customers_id: widget.employeeId,
                        img: widget.profilePic.toString(),
                        name: widget.name.toString(),
                      ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      // height: MediaQuery.of(context).size.height*0.07,
                      height: 48,
                      width: 118,
                      decoration: BoxDecoration(
                        // color: Color(0xff4DA0E6),
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0,
                                blurRadius: 15,
                                offset: Offset(1 , 10),
                                color: Color.fromRGBO(7, 1, 87, 0.1)
                            ),
                          ]
                      ),
                      child:  Center(
                        child: Text("Chat",
                          style: TextStyle(
                              fontFamily: "Outfit",
                              fontSize: 14,
                              color: Color(0xff2B65EC),
                              fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                      ),

                    ),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // RatingBarIndicator(
                      //   rating: 4.00,
                      //   itemBuilder: (context, index) => Icon(
                      //     Icons.star,
                      //     color: Color(0xffFFDF00),
                      //   ),
                      //   itemCount: 5,
                      //   itemSize: 20.0,
                      //   direction: Axis.horizontal,
                      // ),
                      RatingBar(
                          initialRating: double.parse(widget.rating.toString()),
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemSize: 20,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                              full: const Icon(Icons.star, color: Color(0xffFFDF00),),
                              half: const Icon(
                                Icons.star_half,
                                color: Color(0xffFFDF00),
                              ),
                              empty: const Icon(
                                Icons.star_outline,
                                color: Color(0xffA7A9B7),
                              )), onRatingUpdate: (double value) { },
                          // onRatingUpdate: (value) {
                          //   setState(() {
                          //     _ratingValue = value;
                          //   });
                          // }
                          ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "${widget.rating}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        ),
            // Customer_ProfileLists(),
        Container(
          child: loading ? Center(child: CircularProgressIndicator()) :

          allRatingsModel.data?.length == null ?


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
          Center(child:  Text("No Ratings")): Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.16,
                  width: width,
                  height: height * 0.62, //88,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: allRatingsModel.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.only(top: 20, left: 15),
                          // width: 150,
                          // height: height * 0.1,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: allRatingsModel.data![index].customerData?.profilePic== null
                                      ? Image.asset("assets/images/person2.png").image
                                      : NetworkImage(baseUrlImage+"${allRatingsModel.data![index].customerData?.profilePic.toString()}")
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${allRatingsModel.data?[index].customerData?.firstName} ${allRatingsModel.data?[index].customerData?.lastName}",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Container(
                                      width: Get.width * 0.7,
                                      child: AutoSizeText(
                                        "${allRatingsModel.data?[index].comment}",
                                        style: const TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontFamily: "Outfit",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                        maxLines: 2,
                                        minFontSize: 10,
                                        maxFontSize: 10,
                                        presetFontSizes: [10],
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Color(0xffFFDF00), size: 15,),
                                      Text(
                                        "${allRatingsModel.data?[index].rating}",
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: "Outfit",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
          ],
        ),
      ),
    );
  }
}
