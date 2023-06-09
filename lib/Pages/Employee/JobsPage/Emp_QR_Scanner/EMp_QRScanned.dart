import 'package:StandMan/Pages/Customer/HomePage/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../widgets/TopBar.dart';
class EMpQRScanneer extends StatefulWidget {
  final String? customerId;
  String? jobName;

  String? myJobId;
   EMpQRScanneer({Key? key,
     this.customerId,
     this.myJobId,
     this.jobName,
   }) : super(key: key);

  @override
  State<EMpQRScanneer> createState() => _EMpQRScanneerState();
}

class _EMpQRScanneerState extends State<EMpQRScanneer> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("CustomerId, jobId, jobName ${widget.customerId} ${widget.myJobId} ${widget.jobName}");
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: StandManAppBar1(title: "Get your QR Scanned", bgcolor: Color(0xff2B65EC), titlecolor: Colors.white, iconcolor: Colors.white,),
      backgroundColor: Color(0xff2B65EC),
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
              //     "Get your QR Scanned",
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: height * 0.06,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "If your job is completed, then tell your customer to scan this in order to mark the job as Completed.",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: "Outfit",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
// letterSpacing: -0.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: height * 0.1,),
                      // Image.asset("assets/images/qrcode.png"),
                      QrImageView(
                        data: "${widget.customerId} ${widget.myJobId} ${widget.jobName}",
                        version: QrVersions.auto,
                        size: 300.0,
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
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
