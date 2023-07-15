import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../widgets/TopBar.dart';


class Emp_ChangeJobRadius extends StatefulWidget {

  Emp_ChangeJobRadius({Key? key,}) : super(key: key);

  @override
  _Emp_ChangeJobRadiusState createState() => _Emp_ChangeJobRadiusState();
}

class _Emp_ChangeJobRadiusState extends State<Emp_ChangeJobRadius> {
  late GoogleMapController _mapController;
  Position? _currentPosition;
  double _circleRadius = 5000; // Initial circle radius in meters

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

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _circleRadius = calculateCircleRadius(position.zoom);
    });
  }

  double calculateCircleRadius(double zoom) {
    // Implement your own calculation logic based on the zoom level
    // to determine the desired circle radius
    // For demonstration purposes, let's use a simple linear calculation
    return 5000 * (15 - zoom);
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
                        radius: 10000,
                        fillColor: Colors.blue.withOpacity(0.3),
                        strokeColor: Colors.blue,
                      ),
                    },
                    onCameraMove: _onCameraMove,
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
                        SizedBox(
                          height: Get.height * 0.2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            children: [
                              Text(
                                "Choose on map  ",
                                style: const TextStyle(
                                  color: Color.fromRGBO(167, 169, 183, 1),
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
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