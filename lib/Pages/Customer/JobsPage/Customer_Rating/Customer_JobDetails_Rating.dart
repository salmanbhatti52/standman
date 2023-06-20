import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../Models/add_job_rating_Model.dart';
import '../../../../Utils/api_urls.dart';
import '../../../../widgets/MyButton.dart';
import '../../../../widgets/ToastMessage.dart';
import '../../../../widgets/TopBar.dart';
import '../Customer_Profile&List/Customer_Profile.dart';
import 'package:http/http.dart' as http;

class Customer_Rating extends StatefulWidget {
  String? image;
  String? jobName;
  String? jobId;
  String? totalPrice;
  String? address;
  String? completeJobTime;
  String? description;
  String? profilePic;
  String? name;
  String? status;
  String? employeeId;
  String? customerId;
   Customer_Rating({Key? key,   this.image, this.jobId,
    this.jobName, this.totalPrice, this.address, this.customerId,
    this.completeJobTime, this.description, this.employeeId,
    this.profilePic, this.name, this.status,}) : super(key: key);

  @override
  State<Customer_Rating> createState() => _Customer_RatingState();
}

class _Customer_RatingState extends State<Customer_Rating> {

  double? _ratingValue;
  TextEditingController commentJob = TextEditingController();
  final key = GlobalKey<FormState>();

  AddJobRatingModel addJobRatingModel = AddJobRatingModel();

  bool loading = false;
  addJobRating() async {
    String apiUrl = addJobRatingModelApiUrl;
    print("working");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "users_customers_id": "${widget.customerId}",
        "employee_users_customers_id": "${widget.employeeId}",
        "jobs_id": widget.jobId,
        "rating": _ratingValue.toString(),
        "comment": commentJob.text.toString(),
      },
    );
    final responseString = response.body;
    print("addJobRatingModelApi: ${response.body}");
    print("status Code addJobRatingModel: ${response.statusCode}");
    print("in 200 addJobRating");
    if (response.statusCode == 200) {
      addJobRatingModel = addJobRatingModelFromJson(responseString);
      // setState(() {});
      print('addJobRatingModel status: ${addJobRatingModel.status}');
      print('addJobRatingModel data: ${addJobRatingModel.data}');
      setState(() {
        loading = false;
      });
    }
    Future.delayed(const Duration(seconds: 1),
            () {
          if(addJobRatingModel.status == "success"){
            toastSuccessMessage("Add Rating Successfully", Colors.green);
            Get.to(Customer_Profile(
              customerId: widget.customerId.toString(),
              employeeId: widget.employeeId.toString(),
             rating: "${addJobRatingModel.data?.jobRated?.rating}",
              profilePic: "$baseUrlImage${addJobRatingModel.data?.userData?.profilePic}",
              name: "${addJobRatingModel.data?.userData?.firstName} ${addJobRatingModel.data?.userData?.lastName}",
            ));
          } else{
            toastFailedMessage("Something Went Wrong", Colors.red);
          }
        });
    // Get.to(Customer_Profile());
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("jobid : ${widget.jobId}");
    print("users_customers_id: ${widget.customerId}",);
    print("employee_users_customers_id : ${widget.employeeId}",);
    print("rating : ${_ratingValue}",);
    print("jobid : ${widget.jobId}");
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff2B65EC),
      appBar: StandManAppBar1(title: "Job Details", bgcolor: Color(0xff2B65EC), titlecolor: Colors.white, iconcolor: Colors.white,),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding:  EdgeInsets.symmetric(vertical: height * 0.02),
              //   child: Bar(
              //     "Job Details",
              //     'assets/images/arrow-back.svg',
              //     Colors.white,
              //     Colors.white,
              //         () {
              //       Get.back();
              //     },
              //   ),
              // ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.04,
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
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: 73,
                        height: 19,
                        decoration: BoxDecoration(
                          color: Color(0xffE9FFE7),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "${widget.status}",
                            style: TextStyle(
                              color: Color(0xff10C900),
                              fontFamily: "Outfit",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Form(
                        key: key,
                        child: Column(children: [Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Give Ratings",
                            style: TextStyle(
                              color: Color.fromRGBO(25, 29, 49, 1),
                              fontFamily: "Outfit",
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              // letterSpacing: -0.3,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          RatingBar(
                              initialRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemSize: 30,
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
                                  )),
                              onRatingUpdate: (value) {
                                setState(() {
                                  _ratingValue = value;
                                });
                              }),
                        ],
                      ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Add Comment",
                              style: TextStyle(
                                color: Color.fromRGBO(25, 29, 49, 1),
                                fontFamily: "Outfit",
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                // letterSpacing: -0.3,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Color.fromRGBO(243, 243, 243, 1),
                                width: 1.0,
                              )),
                          height: height * 0.12, // 97,
                          child: TextField(
                            maxLines: null,
                            controller: commentJob,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Color.fromRGBO(167, 169, 183, 1),
                              fontFamily: "Outfit",
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding:
                              const EdgeInsets.only(top: 5.0, left: 12),
                              hintText: "Type here....",
                              hintStyle: const TextStyle(
                                color: Color.fromRGBO(167, 169, 183, 1),
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),],),),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      GestureDetector(
                        onTap: (){
                          if (key.currentState!.validate()) {
                            if (  _ratingValue == null) {
                              toastFailedMessage(
                                  'Please Add Rating', Colors.red);
                            } else if (commentJob.text.toString().isEmpty) {
                              toastFailedMessage(
                                  'Please Add Comment', Colors.red);
                            } else {
                              addJobRating();
                              // print("hello");
                              // addJobRating();
                            }
                          }
                          // Get.to(Customer_Profile());
                        },
                          child: mainButton("Submit", Color.fromRGBO(43, 101, 236, 1), context))
                    ],
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
