import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../widgets/TopBar.dart';

class CustomerMyJobsDetails extends StatefulWidget {
  String? image;
  String? jobName;
  String? totalPrice;
  String? address;
  String? completeJobTime;
  String? description;
  String? profilePic;
  String? name;
  String? status;
  String? employeeId;
   CustomerMyJobsDetails({Key? key, this.image,
    this.jobName, this.totalPrice, this.address,
    this.completeJobTime, this.description, this.employeeId,
    this.profilePic, this.name, this.status}) : super(key: key);

  @override
  State<CustomerMyJobsDetails> createState() => _CustomerMyJobsDetailsState();
}

class _CustomerMyJobsDetailsState extends State<CustomerMyJobsDetails> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: StandManAppBar1(
        title: "Job Details",
        bgcolor: Color(0xff2B65EC),
        titlecolor: Colors.white,
        iconcolor: Colors.white,
      ),
      backgroundColor: Color(0xff2B65EC),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width,
                height: height * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: height * 0.03,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                                child: Image.network("${widget.image}")),
                            Positioned(
                                bottom: 10,
                                left: 10,
                                child: Container(
                                  margin: EdgeInsets.only(top: 40, left: 2),
                                  width: 73,
                                  height: 19,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFDACC),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${widget.status}",
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
                                ))
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.jobName}",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: "Outfit",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "\$${widget.totalPrice}",
                              style: TextStyle(
                                color: Color(0xff2B65EC),
                                fontFamily: "Outfit",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/locationfill.svg',
                              width: 20,
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * 0.8,
                                  child: AutoSizeText(
                                    "${widget.address}",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    minFontSize: 12,
                                    presetFontSizes: [12],
                                    maxFontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  "${widget.completeJobTime}",
                                  style: const TextStyle(
                                    color: Color.fromRGBO(167, 169, 183, 1),
                                    fontFamily: "Outfit",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${widget.description}",
                                // "Donec dictum tristique porta. Etiam convallis lorem lobortis nulla molestie, nec tincidunt ex ullamcorper. Quisque ultrices lobortis elit sed euismod. Duis in ultrices dolor, ac rhoncus odio. Suspendisse tempor sollicitudin dui sed lacinia. Nulla quis enim posuere, congue libero quis, commodo purus. Cras iaculis massa ut elit.",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: "Outfit",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  // letterSpacing: -0.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Job Posted by",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: "Outfit",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network("${widget.profilePic}")),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.name}",
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontFamily: "Outfit",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
// letterSpacing: -0.3,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Row(
                                        children: [
                                          // Icon(
                                          //   Icons.star,
                                          //   color: Color(0xffFFDF00),
                                          //   size: 15,
                                          // ),
                                          Text(
                                            '--',
                                            style: TextStyle(
                                              color: Color(0xff000000),
                                              fontFamily: "Outfit",
                                              fontSize: 12,
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
                            ),
                            // GestureDetector(
                            //     onTap: () async {
                            //       await chatStartUser();
                            //       Get.to(MessagesDetails(
                            //         usersCustomersId: usersCustomersId,
                            //         other_users_customers_id: widget.employeeId,
                            //         img: widget.profilePic.toString(),
                            //         name: widget.name.toString(),
                            //       ),
                            //       );
                            //     },
                            //     child: smallButton(
                            //         "Chat", Color(0xff2B65EC), context)),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        // GestureDetector(
                        //     onTap: () {
                        //       Get.to(CustomerQRCodeScanner());
                        //     },
                        //     child: mainButton("Complete Job using QR",
                        //         Color(0xff2B65EC), context)),
                        // SizedBox(
                        //   height: height * 0.02,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 25, vertical: 20),
                        //   child: Container(
                        //     height: MediaQuery.of(context).size.height * 0.07,
                        //     // height: 48,
                        //     width: MediaQuery.of(context).size.width,
                        //     decoration: BoxDecoration(
                        //       // color: Color(0xff4DA0E6),
                        //       //   color: Colors.white,
                        //         borderRadius: BorderRadius.circular(12),
                        //         border: Border.all(
                        //             color: Color(0xffC70000), width: 1),
                        //         boxShadow: [
                        //           BoxShadow(
                        //               spreadRadius: 0,
                        //               blurRadius: 15,
                        //               offset: Offset(1, 10),
                        //               color: Color.fromRGBO(7, 1, 87, 0.1)),
                        //         ]),
                        //     child: Center(
                        //       child: Text(
                        //         "Cancel Job",
                        //         style: TextStyle(
                        //             fontFamily: "Outfit",
                        //             fontSize: 14,
                        //             color: Color(0xffC70000),
                        //             fontWeight: FontWeight.w500),
                        //         textAlign: TextAlign.center,
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
