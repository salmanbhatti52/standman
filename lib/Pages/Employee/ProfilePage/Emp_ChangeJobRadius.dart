import 'dart:convert';

import 'package:StandMan/Pages/EmpBottombar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../../../widgets/TopBar.dart';
import 'package:http/http.dart' as http;

import '../HomePage/EmpHomePage.dart';


// ignore: must_be_immutable
class Emp_ChangeJobRadius extends StatefulWidget {
  String? circleRadius;
  Emp_ChangeJobRadius({Key? key, this.circleRadius}) : super(key: key);

  @override
  _Emp_ChangeJobRadiusState createState() => _Emp_ChangeJobRadiusState();
}

class _Emp_ChangeJobRadiusState extends State<Emp_ChangeJobRadius> {
  late GoogleMapController _mapController;
  Position? _currentPosition;
  double _circleRadius = 10000; // Initial circle radius in meters
  late double _value;

  @override
  void initState() {
    super.initState();
    _value  =double.parse( widget.circleRadius.toString());
    print("value $_value");
    _getCurrentLocation();
    print("job_radius : ${widget.circleRadius}");
  }

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = position;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  TextEditingController _currentAddress1 = TextEditingController();
  final key = GlobalKey<FormState>();

  bool isLoading = false;
  dynamic updateJobRadius;

  updateJobsRadius() async {
    setState(() {
      isLoading = true;
    });

    empPrefs = await SharedPreferences.getInstance();
    empUsersCustomersId = empPrefs!.getString('empUsersCustomersId');
    print("userId = $empUsersCustomersId");

    String apiUrl = updateJobRadiusApiUrl;
    print("getUserProfileApi: $apiUrl");

    http.Response response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "users_customers_id": empUsersCustomersId.toString(),
        "job_radius": _value.toString(),
      },
      headers: {
        'Accept': 'application/json',
      },
    );

    if (mounted) {
      setState(() {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          String status = jsonResponse['status'];
          if (status == 'success') {
            // Success case
            var data = jsonResponse['data'];
            updateJobRadius = data;
            print("updateJobRadius: $updateJobRadius");
            print("job_radius ${updateJobRadius['job_radius'].toString()}");
            isLoading = false;
            toastSuccessMessage('Radius Changed Successfully', Colors.green);
            Get.to(  () => Empbottom_bar(currentIndex: 0));
          } else {
            // Error case
            print("Response Body: ${response.body}");
            isLoading = false;
            // Show error message (you can implement a function to show a Toast or a dialog)
            toastFailedMessage('Error occurred. Please try again.', Colors.red);
          }
        } else {
          // Error case
          print("Response Body: ${response.body}");
          isLoading = false;
          // Show error message (you can implement a function to show a Toast or a dialog)
          toastFailedMessage('Error occurred. Please try again.', Colors.red);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus
              ?.unfocus();
        }
      },
      child: Scaffold(
        appBar: StandManAppBar1(title: "Change Job Radius", bgcolor: Color(0xff2B65EC), titlecolor: Colors.white, iconcolor: Colors.white,),
        backgroundColor: Color(0xff2B65EC),
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              // color: Colors.w
            ),
            child: Column(
              children: [
                // Expanded(
                //   child: _currentPosition != null
                //       ? GoogleMap(
                //     onMapCreated: _onMapCreated,
                //     myLocationEnabled: true,
                //     padding: EdgeInsets.only(top: Get.height * 0.44),
                //     initialCameraPosition: CameraPosition(
                //       target: LatLng(
                //         _currentPosition!.latitude,
                //         _currentPosition!.longitude,
                //       ),
                //       zoom: 10.0,
                //     ),
                //     markers: {
                //       Marker(
                //         markerId: MarkerId('currentLocation'),
                //         position: LatLng(
                //           _currentPosition!.latitude,
                //           _currentPosition!.longitude,
                //         ),
                //       ),
                //     },
                //     circles: {
                //       Circle(
                //         circleId: CircleId('currentLocationCircle'),
                //         center: LatLng(
                //           _currentPosition!.latitude,
                //           _currentPosition!.longitude,
                //         ),
                //         radius: double.parse(widget.circleRadius!) * 1000, // Convert km to meters
                //         fillColor: Colors.blue.withOpacity(0.3),
                //         strokeColor: Colors.blue,
                //       ),
                //     },
                //   )
                //       : Center(
                //     child: CircularProgressIndicator(),
                //   ),
                // ),
                Container(
                  height: Get.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: Column(
                      children: [
                        // Bar(
                        //   "Change Job Radius",
                        //   'assets/images/left.svg',
                        //   Colors.black,
                        //   Colors.black,
                        //       () {
                        //     Get.back();
                        //   },
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 30.0),
                        //   child: Form(
                        //     key: key,
                        //     child: TextFormField(
                        //       controller: _currentAddress1,
                        //       textAlign: TextAlign.left,
                        //       style: const TextStyle(
                        //         color: Color.fromRGBO(167, 169, 183, 1),
                        //         fontFamily: "Outfit",
                        //         fontWeight: FontWeight.w300,
                        //         fontSize: 14,
                        //       ),
                        //       keyboardType: TextInputType.number,
                        //       // validator: (val) {
                        //       //   return RegExp(
                        //       //       r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                        //       //       .hasMatch(val!)
                        //       //       ? null
                        //       //       : "Please enter correct Email";
                        //       // },
                        //       decoration: InputDecoration(
                        //         // contentPadding: const EdgeInsets.only(top: 12.0),
                        //         hintText: "Enter job radius",
                        //         hintStyle: const TextStyle(
                        //           color: Color.fromRGBO(167, 169, 183, 1),
                        //           fontFamily: "Outfit",
                        //           fontWeight: FontWeight.w300,
                        //           fontSize: 14,
                        //         ),
                        //         enabledBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(12),
                        //           borderSide: const BorderSide(
                        //             color: Color.fromRGBO(243, 243, 243, 1),
                        //             width: 1.0,
                        //           ),
                        //         ),
                        //         errorBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(12),
                        //           borderSide: const BorderSide(
                        //             color: Color.fromRGBO(243, 243, 243, 1),
                        //             width: 1.0,
                        //           ),
                        //         ),
                        //         focusedErrorBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(12),
                        //           borderSide: const BorderSide(
                        //             color: Color.fromRGBO(243, 243, 243, 1),
                        //             width: 1.0,
                        //           ),
                        //         ),
                        //         focusedBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(12),
                        //           borderSide: const BorderSide(
                        //             color: Color.fromRGBO(243, 243, 243, 1),
                        //             width: 1.0,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: Get.height * 0.2,
                        ),
                        SfSlider(
                          min: 0.0,
                          max: 100.0,
                          value: _value,
                          interval: 20,
                          showTicks: true,
                          showLabels: true,
                          enableTooltip: true,
                          minorTicksPerInterval: 1,
                          onChanged: (dynamic value){
                            setState(() {
                              _value = value;
                              print("value $_value");
                            });
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.1,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_value == null) {
                              toastFailedMessage(
                                  'Select Your job radius', Colors.red);
                            } else {
                              updateJobsRadius();
                            }
                          },
                          child: isLoading
                              ? loadingBar(context)
                              : mainButton("Save", Color.fromRGBO(43, 101, 236, 1), context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}