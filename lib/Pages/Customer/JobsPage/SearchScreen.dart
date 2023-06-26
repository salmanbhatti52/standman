import 'dart:convert';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/search_customerJobs_Model.dart';
import '../../../Utils/api_urls.dart';
import '../../Drawer.dart';
import '../HomePage/HomePage.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  SearchCustomerJobsModel searchCustomerJobsModel = SearchCustomerJobsModel();
  bool loading = false;

  searchJobsWidget() async {

    String apiUrl = searchJobsCustomersApiUrl;
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    print("usersCustomersId: ${usersCustomersId}");
    if (searchController.text.isNotEmpty) {
      print("searchControllerValue ${searchController.text}");
      searchCustomerJobsModel.data?.clear();
      print("searchApiUrl $apiUrl");
      print("userId $usersCustomersId");
      final response = await http.post(Uri.parse(apiUrl), body: {
        "users_customers_id": usersCustomersId,
        "job_name": searchController.text
      }, headers: {
        'Accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("responseString $responseString");
        searchCustomerJobsModel =
            searchCustomerJobsModelFromJson(responseString);
        setState(() {});
        print("searchItemsLength: ${searchCustomerJobsModel.data?.length}");
      }
    }

    // } catch (e) {
    //   print('Error: ${e.toString()}');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MyDrawer(),
      appBar: AppBar(
        toolbarHeight: Get.height * 0.1,
        backgroundColor: Color(0xff2B65EC),
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Text(
            "Find Jobs",
            style: TextStyle(
              color: Color(0xffffffff),
              fontFamily: "Outfit",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              // letterSpacing: -0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //       Get.to(SearchScreen());
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.only(right: 20.0, top: 0.0),
        //       child: SvgPicture.asset("assets/images/search.svg"),
        //     ),
        //   ),
        // ],
      ),
      backgroundColor: Color(0xff2B65EC),
      body: Container(
        // height: 500,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(248, 249, 251, 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchJobsWidget();
                            });
                          },
                          controller: searchController,
                          autofocus: false,
                          style: TextStyle(color: Colors.grey),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 14.0),
                            hintText: 'Search Jobs',
                            border: InputBorder.none,
                            suffixIcon: searchController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        searchController.text = '';
                                        print(
                                            "searchControllerClear ${searchController.text}");
                                      });
                                    },
                                    child: Icon(Icons.clear,
                                        size: 22.0,
                                        color: Color(0xffD4DCE1)))
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // searchCarsWidget();
                                      });
                                    },
                                    child: Icon(Icons.search,
                                        size: 22.0,
                                        color: Color(0xffD4DCE1))),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              // height: Get.height * 0.6,
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : searchCustomerJobsModel.data?.length == null
                      ? Center(
                          child: Text(
                            "No Result",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: "Outfit",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              // letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )
                      : Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              itemCount: searchCustomerJobsModel.data?.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                // SearchCustomerJobsModel guest = widget.eventGuest![index];
                                return Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.only(top: 20),
                                  // width: MediaQuery.of(context).size.width * 0.51,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 0,
                                            blurRadius: 20,
                                            offset: Offset(0, 2),
                                            color: Color.fromRGBO(
                                                167, 169, 183, 0.1)),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  10.0),
                                          child: FadeInImage(
                                            placeholder: AssetImage(
                                              "assets/images/fade_in_image.jpeg",
                                            ),
                                            fit: BoxFit.fitWidth,
                                            width: 114,
                                            height: 96,
                                            image: NetworkImage(
                                                "$baseUrlImage${searchCustomerJobsModel.data?[index].image}"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets
                                                  .symmetric(
                                              horizontal: 0.0,
                                              vertical: 5.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                            children: [
                                              Text(
                                                // 'Eleanor Pena',
                                                "${searchCustomerJobsModel.data?[index].name}",
                                                style: TextStyle(
                                                  color:
                                                      Color(0xff000000),
                                                  fontFamily: "Outfit",
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.w500,
// letterSpacing: -0.3,
                                                ),
                                                textAlign:
                                                    TextAlign.left,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                child: Text(
                                                  // 'Mar 03, 2023',
                                                  "${searchCustomerJobsModel.data?[index].dateAdded}",
                                                  style: TextStyle(
                                                    color: Color(
                                                        0xff9D9FAD),
                                                    fontFamily:
                                                        "Outfit",
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.w500,
// letterSpacing: -0.3,
                                                  ),
                                                  textAlign:
                                                      TextAlign.left,
                                                ),
                                              ),
                                              Text(
                                                'Taken By',
                                                style: TextStyle(
                                                  color:
                                                      Color(0xff2B65EC),
                                                  fontFamily: "Outfit",
                                                  fontSize: 8,
                                                  fontWeight:
                                                      FontWeight.w400,
// letterSpacing: -0.3,
                                                ),
                                                textAlign:
                                                    TextAlign.left,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  // Image.asset("assets/images/g1.png"),
                                                  CircleAvatar(
                                                      // radius: (screenWidth > 600) ? 90 : 70,
                                                      //   radius: 50,
                                                      backgroundColor:
                                                          Colors
                                                              .transparent,
                                                      backgroundImage: searchCustomerJobsModel
                                                                  .data?[
                                                                      index]
                                                                  .usersCustomersData ==
                                                              null
                                                          ? Image.asset(
                                                                  "assets/images/person2.png")
                                                              .image
                                                          : NetworkImage(baseUrlImage +
                                                              searchCustomerJobsModel
                                                                  .data![
                                                                      index]
                                                                  .usersCustomersData!
                                                                  .profilePic
                                                                  .toString())
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
                                                    width: 7,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                                .only(
                                                            top: 15.0),
                                                    child: Container(
                                                      width: 65,
                                                      child: Text(
                                                        // 'Wade Warren',
                                                        "${searchCustomerJobsModel.data?[index].usersCustomersData!.firstName} ${searchCustomerJobsModel.data?[index].usersCustomersData!.lastName}",
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
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 40, left: 2),
                                          width: 67,
                                          height: 19,
                                          decoration: BoxDecoration(
                                            color: Color(0xffFFDACC),
                                            borderRadius:
                                                BorderRadius.circular(
                                                    30),
                                          ),
                                          child: Center(
                                            child: Text(
                                              // customerongoingjobstList[index].subTitle,
                                              "${searchCustomerJobsModel.data?[index].status}",
                                              style: TextStyle(
                                                color:
                                                    Color(0xffFF4700),
                                                fontFamily: "Outfit",
                                                fontSize: 10,
                                                fontWeight:
                                                    FontWeight.w400,
// letterSpacing: -0.3,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ),
            ),
          ],
        ),
      ),
    );

//       Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Search Jobs",
//                       style: TextStyle(
//                         color: Color.fromRGBO(0, 0, 0, 1),
//                         fontFamily: "Outfit",
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                         // letterSpacing: -0.3,
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                      SizedBox(
//                       height: Get.height * 0.02,
//                     ),
//                     Row(
//                       children: [
//                         // Expanded(
//                         //   child: TextFormField(
//                         //     controller: searchController,
//                         //     textAlign: TextAlign.left,
//                         //     onChanged: (value){
//                         //       handleSearch();
//                         //     },
//                         //     style: const TextStyle(
//                         //       color: Color.fromRGBO(167, 169, 183, 1),
//                         //       fontFamily: "Outfit",
//                         //       fontWeight: FontWeight.w300,
//                         //       fontSize: 14,
//                         //     ),
//                         //     keyboardType: TextInputType.emailAddress,
//                         //     decoration: InputDecoration(
//                         //       // contentPadding: const EdgeInsets.only(top: 12.0),
//                         //       hintText: "Search your Jobs",
//                         //       hintStyle: const TextStyle(
//                         //         color: Color.fromRGBO(167, 169, 183, 1),
//                         //         fontFamily: "Outfit",
//                         //         fontWeight: FontWeight.w300,
//                         //         fontSize: 14,
//                         //       ),
//                         //       prefixIcon: Padding(
//                         //         padding: const EdgeInsets.all(12.0),
//                         //         child: SvgPicture.asset("assets/images/search.svg", color: Colors.black,),
//                         //       ),
//                         //       enabledBorder: OutlineInputBorder(
//                         //         borderRadius: BorderRadius.circular(12),
//                         //         borderSide: const BorderSide(
//                         //           color: Color.fromRGBO(243, 243, 243, 1),
//                         //           width: 1.0,
//                         //         ),
//                         //       ),
//                         //       errorBorder: OutlineInputBorder(
//                         //         borderRadius: BorderRadius.circular(12),
//                         //         borderSide: const BorderSide(
//                         //           color: Color.fromRGBO(243, 243, 243, 1),
//                         //           width: 1.0,
//                         //         ),
//                         //       ),
//                         //       focusedErrorBorder: OutlineInputBorder(
//                         //         borderRadius: BorderRadius.circular(12),
//                         //         borderSide: const BorderSide(
//                         //           color: Color.fromRGBO(243, 243, 243, 1),
//                         //           width: 1.0,
//                         //         ),
//                         //       ),
//                         //       focusedBorder: OutlineInputBorder(
//                         //         borderRadius: BorderRadius.circular(12),
//                         //         borderSide: const BorderSide(
//                         //           color: Color.fromRGBO(243, 243, 243, 1),
//                         //           width: 1.0,
//                         //         ),
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                         Expanded(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             height: MediaQuery.of(context).size.height * 0.06,
//                             child: Padding(
//                               padding:  EdgeInsets.symmetric(horizontal: 20),
//                               child: TextField(
//                                 onChanged: (value) {
//                                   setState(() {
//                                     searchCarsWidget();
//                                   });
//                                 },
//                                 controller: searchController,
//                                 autofocus: false,
//                                 style: TextStyle(color: Colors.grey),
//                                 decoration:  InputDecoration(
//                                   contentPadding: EdgeInsets.only(left: 10.0, right: 10.0, top: 14.0),
//                                   hintText: 'Search for Cars',
//                                   border: InputBorder.none,
//                                   suffixIcon: searchController.text.isNotEmpty?
//
//                                   GestureDetector(
//                                       onTap: (){
//                                         setState(() {
//                                           searchController.text = '';
//                                           print("searchControllerClear ${searchController.text}");
//                                         });
//                                       },
//                                       child: Icon(Icons.clear, size: 22.0, color: Color(0xffD4DCE1))):
//                                   GestureDetector(
//                                       onTap: (){
//                                         setState(() {
//                                           // searchCarsWidget();
//                                         });
//                                       },
//                                       child: Icon(Icons.search, size: 22.0, color: Color(0xffD4DCE1))),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: Get.width * 0.02,
//                         ),
//                         // ElevatedButton(onPressed: (){
//                         //   handleSearch();
//                         // } , child: Text(
//                         //   "Search",
//                         //   style: TextStyle(
//                         //     color: Color.fromRGBO(0, 0, 0, 1),
//                         //     fontFamily: "Outfit",
//                         //     fontSize: 16,
//                         //     fontWeight: FontWeight.w400,
//                         //     // letterSpacing: -0.3,
//                         //   ),
//                         //   textAlign: TextAlign.left,
//                         // ),),
//                       ],
//                     ),
//                      SizedBox(
//                       height: Get.height * 0.02,
//                     ),
//                     // Container(
//                     //   padding: EdgeInsets.only(
//                     //       left: padding * 2,
//                     //       right: padding * 2,
//                     //       top: padding * 0.3,
//                     //       bottom: padding * 2),
//                     //   child: Column(
//                     //     crossAxisAlignment: CrossAxisAlignment.start,
//                     //     children: [
//                     //       // Text('Event Guests List', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: globalBlack)),
//                     //       SizedBox(height: padding),
//                     //       Container(
//                     //         height: 44,
//                     //         decoration: BoxDecoration(
//                     //           boxShadow: [
//                     //             BoxShadow(
//                     //               color: Colors.grey,
//                     //               blurRadius: 3,
//                     //             ),
//                     //           ],
//                     //         ),
//                     //         child: TextFormField(
//                     //           style: TextStyle(color:Colors.black, ),
//                     //           onChanged: (value) {
//                     //             if (value.isEmpty) {
//                     //               searchFilter();
//                     //             } else {
//                     //               searchFilter(title: value);
//                     //               setState(() {});
//                     //             }
//                     //           },
//                     //           decoration: InputDecoration(
//                     //             border: InputBorder.none,
//                     //             hintText: 'Search Username or Ticket Code',
//                     //             hintStyle: TextStyle(
//                     //               color:Colors.black,
//                     //             ),
//                     //             fillColor: Colors.white,
//                     //             filled: true,
//                     //             prefixIcon: Icon(Icons.search, color: Colors.black , ),
//                     //           ),
//                     //         ),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: Get.height * 0.55,
//                 child: loading ? Center(child: CircularProgressIndicator()) :
//
//                 searchCustomerJobsModel.data?.length == null
//                     ? Center(child: Text(
//                     "No Result",
//                     style: TextStyle(
//                       color: Color.fromRGBO(0, 0, 0, 1),
//                       fontFamily: "Outfit",
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       // letterSpacing: -0.3,
//                     ),
//                     textAlign: TextAlign.left,
//                   ),)
//                     : Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                       child: Column(
//                       children: [
//                         ListView.builder(
//                             shrinkWrap: true,
//                             scrollDirection: Axis.vertical,
//                             itemCount: searchCustomerJobsModel.data?.length,
//                             itemBuilder: (BuildContext context, int index){
//                               // SearchCustomerJobsModel guest = widget.eventGuest![index];
//                               return  Container(
//                                 margin: EdgeInsets.only(top: 10),
//                                 padding: EdgeInsets.only(top: 20),
//                                 // width: MediaQuery.of(context).size.width * 0.51,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(10),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           spreadRadius: 0,
//                                           blurRadius: 20,
//                                           offset: Offset(0, 2),
//                                           color: Color.fromRGBO(167, 169, 183, 0.1)),
//                                     ]),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Row(mainAxisAlignment: MainAxisAlignment
//                                       .spaceBetween,
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(10.0),
//                                         child:
//                                         FadeInImage(
//                                           placeholder: AssetImage(
//                                             "assets/images/fade_in_image.jpeg",),
//                                           fit: BoxFit.fitWidth,
//                                           width: 114,
//                                           height: 96,
//                                           image: NetworkImage("$baseUrlImage${searchCustomerJobsModel.data?[index].image}"),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 0.0, vertical: 5.0),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               // 'Eleanor Pena',
//                                               "${searchCustomerJobsModel.data?[index].name}",
//                                               style: TextStyle(
//                                                 color: Color(0xff000000),
//                                                 fontFamily: "Outfit",
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w500,
// // letterSpacing: -0.3,
//                                               ),
//                                               textAlign: TextAlign.left,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.symmetric(
//                                                   vertical: 5.0),
//                                               child: Text(
//                                                 // 'Mar 03, 2023',
//                                                 "${searchCustomerJobsModel.data?[index].dateAdded}",
//                                                 style: TextStyle(
//                                                   color: Color(0xff9D9FAD),
//                                                   fontFamily: "Outfit",
//                                                   fontSize: 8,
//                                                   fontWeight: FontWeight.w500,
// // letterSpacing: -0.3,
//                                                 ),
//                                                 textAlign: TextAlign.left,
//                                               ),
//                                             ),
//                                             Text(
//                                               'Taken By',
//                                               style: TextStyle(
//                                                 color: Color(0xff2B65EC),
//                                                 fontFamily: "Outfit",
//                                                 fontSize: 8,
//                                                 fontWeight: FontWeight.w400,
// // letterSpacing: -0.3,
//                                               ),
//                                               textAlign: TextAlign.left,
//                                             ),
//                                             SizedBox(
//                                               height: 8,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.start,
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 // Image.asset("assets/images/g1.png"),
//                                                 CircleAvatar(
//                                                   // radius: (screenWidth > 600) ? 90 : 70,
//                                                   //   radius: 50,
//                                                     backgroundColor: Colors.transparent,
//                                                     backgroundImage: searchCustomerJobsModel.data?[index].usersCustomersData == null
//                                                         ? Image.asset("assets/images/person2.png").image
//                                                         : NetworkImage(baseUrlImage+searchCustomerJobsModel.data![index].usersCustomersData!.profilePic.toString())
//                                                   // NetworkImage(baseUrlImage+ getUserProfileModelObject.data!.profilePic!)
//
//                                                 ),
//                                                 // CircleAvatar(
//                                                 //     backgroundColor: Colors.transparent,
//                                                 //     backgroundImage: profilePic1 == null
//                                                 //         ? Image.asset("assets/images/g1.png").image
//                                                 //         : NetworkImage(baseUrlImage+getJobsModel.data!.profilePic.toString())
//                                                 // ),
//                                                 // CircleAvatar(
//                                                 //   backgroundColor: Colors.transparent,
//                                                 //   backgroundImage: NetworkImage(
//                                                 //       "$baseUrlImage${getJobsModel.data?[index].}"),),
//                                                 SizedBox(
//                                                   width: 7,
//                                                 ),
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(top: 15.0),
//                                                   child: Container(
//                                                     width: 65,
//                                                     child: Text(
//                                                       // 'Wade Warren',
//                                                       "${searchCustomerJobsModel.data?[index].usersCustomersData!.firstName} ${searchCustomerJobsModel.data?[index].usersCustomersData!.lastName}",
//                                                       // "${usersProfileModel.data?.firstName} ${usersProfileModel.data?.lastName}",
//                                                       style: TextStyle(
//                                                         color: Color(0xff000000),
//                                                         fontFamily: "Outfit",
//                                                         fontSize: 8,
//                                                         fontWeight: FontWeight.w500,
// // letterSpacing: -0.3,
//                                                       ),
//                                                       textAlign: TextAlign.left,
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         margin: EdgeInsets.only(top: 40, left: 2),
//                                         width: 67,
//                                         height: 19,
//                                         decoration: BoxDecoration(
//                                           color: Color(0xffFFDACC),
//                                           borderRadius: BorderRadius.circular(30),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             // customerongoingjobstList[index].subTitle,
//                                             "${searchCustomerJobsModel.data?[index].status}",
//                                             style: TextStyle(
//                                               color: Color(0xffFF4700),
//                                               fontFamily: "Outfit",
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.w400,
// // letterSpacing: -0.3,
//                                             ),
//                                             textAlign: TextAlign.left,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                             ),
//                       ],
//                   ),
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
  }
}
