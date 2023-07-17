import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  double percent = 0.9;


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
                          height: Get.height * 0.04,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            children: [
                              GestureDetector(
                              onPanUpdate: (details) {
                        setState(() {
                        // Adjust the percentage based on finger movement
                        percent += details.delta.dx / 100;
                        percent = percent.clamp(0.0, 1.0); // Ensure the value stays between 0 and 1
                        });
                        },
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: LinearPercentIndicator(
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: percent,
                              center: Text("${(percent * 100).toStringAsFixed(1)}%"),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Colors.greenAccent,
                            ),
                          ),
                        ),
                              Text(
                                "Choose Your Job Radius On moving Line",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Outfit",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.04,
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