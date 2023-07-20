import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../../../widgets/TopBar.dart';
import 'package:percent_indicator/percent_indicator.dart';


class Emp_ChangeJobRadius extends StatefulWidget {

  Emp_ChangeJobRadius({Key? key,}) : super(key: key);

  @override
  _Emp_ChangeJobRadiusState createState() => _Emp_ChangeJobRadiusState();
}

class _Emp_ChangeJobRadiusState extends State<Emp_ChangeJobRadius> {
  late GoogleMapController _mapController;
  Position? _currentPosition;
  double _circleRadius = 10000; // Initial circle radius in meters

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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
        // backgroundColor: Colors.black.withOpacity(0.1),
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
            ),
            child: Column(
              children: [
                Expanded(
                  child: _currentPosition != null
                      ? GoogleMap(
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                    padding: EdgeInsets.only(top: Get.height * 0.44),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      ),
                      zoom: 11.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('currentLocation'),
                        position: LatLng(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        ),
                      ),
                    },
                    circles: {
                      Circle(
                        circleId: CircleId('currentLocationCircle'),
                        center: LatLng(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        ),
                        radius: _circleRadius,
                        fillColor: Colors.blue.withOpacity(0.3),
                        strokeColor: Colors.blue,
                      ),
                    },
                  )
                      : Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Container(
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
                        Bar(
                          "Change Job Radius",
                          'assets/images/left.svg',
                          Colors.black,
                          Colors.black,
                              () {
                            Get.back();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Form(
                            key: key,
                            child: TextFormField(
                              controller: _currentAddress1,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color.fromRGBO(167, 169, 183, 1),
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                              ),
                              keyboardType: TextInputType.number,
                              // validator: (val) {
                              //   return RegExp(
                              //       r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              //       .hasMatch(val!)
                              //       ? null
                              //       : "Please enter correct Email";
                              // },
                              decoration: InputDecoration(
                                // contentPadding: const EdgeInsets.only(top: 12.0),
                                hintText: "Enter job radius",
                                hintStyle: const TextStyle(
                                  color: Color.fromRGBO(167, 169, 183, 1),
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(243, 243, 243, 1),
                                    width: 1.0,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(243, 243, 243, 1),
                                    width: 1.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(243, 243, 243, 1),
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(243, 243, 243, 1),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_currentAddress1.text.isEmpty) {
                              toastFailedMessage(
                                  'Enter Your job radius', Colors.red);
                            } else {
                              // Get.to(
                              //   JobDetails(
                              //     latitude: "${_currentPosition?.latitude == null ? latt : _currentPosition?.latitude}",
                              //     longitude: "${_currentPosition?.longitude == null ? long : _currentPosition?.longitude}",
                              //     currentaddress: "${mainText.text.toString()}",
                              //     currentaddress1: "${_currentAddress1.text.toString()}",
                              //   ),
                              // );
                            }
                            // }
                          },
                          child: mainButton(
                              "Save", Color.fromRGBO(43, 101, 236, 1), context),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}