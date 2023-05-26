import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:StandMan/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../../../widgets/TopBar.dart';
import 'JobDetails.dart';
import 'package:http/http.dart' as http;
import 'package:places_service/places_service.dart';

class FindPlace extends StatefulWidget {
  late double? location;

  FindPlace({Key? key, this.location}) : super(key: key);

  @override
  State<FindPlace> createState() => _FindPlaceState();
}

class _FindPlaceState extends State<FindPlace> {
  //    var long;
  //    var lat;
  //  final key = GlobalKey<FormState>();
  //  TextEditingController controller = TextEditingController();
  //
  //  var uuid = Uuid();
  //  String _sessionToken = "122344";
  //  List<Marker> _placeList = [];
  //
  //  final Completer<GoogleMapController> _controller =
  //      Completer<GoogleMapController>();
  //
  //  static const CameraPosition _kGooglePlex = CameraPosition(
  //    target: LatLng(30.183419, 71.427832),
  //    zoom: 14,
  //  );
  //
  //  final List<Marker> markers = [
  //    Marker(
  //      markerId: MarkerId("1"),
  //      position: LatLng(30.183419, 71.427832),
  //      infoWindow: InfoWindow(
  //        title: "Marker",
  //      ),
  //    ),
  //  ];
  //
  // Future<Position> _getCurrentLocation() async {
  //   await Geolocator.requestPermission()
  //       .then((value) {})
  //       .onError((error, stackTrace) {
  //     print("error" + error.toString());
  //   });
  //   return await Geolocator.getCurrentPosition();
  // }
  //
  // loadData() {
  //   _getCurrentLocation().then((value) async {
  //     lng = value.longitude.toString() as double;
  //     lat = value.latitude.toString() as double;
  //     print(value.latitude.toString());
  //     print(value.longitude.toString());
  //     markers.add(
  //       Marker(
  //         markerId: MarkerId("1"),
  //         position: LatLng(30.183419, 71.427832),
  //         infoWindow: InfoWindow(
  //           title: "Marker",
  //         ),
  //       ),
  //     );
  //
  //     CameraPosition cameraPosition = CameraPosition(
  //       target: LatLng(value.latitude, value.longitude),
  //       zoom: 14,
  //     );
  //     final GoogleMapController controller =
  //         (await selectedAddress) as GoogleMapController;
  //     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //     setState(() {});
  //   });
  // }

  //
  //  onChanged() {
  //    if (_sessionToken == null) {
  //      setState(() {
  //        _sessionToken = uuid.v4();
  //      });
  //      getSuggestion(controller.text);
  //    }
  //  }
  //
  //  getSuggestion(String input) async {
  //    String kPLACES_API_KEY = "AIzaSyA1kEvCbj9i4-ez8d8KEvEfUuoDzFyjvEc";
  //    String baseURL =
  //        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  //    String request =
  //        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
  //
  //    var response = await http.get(Uri.parse(request));
  //
  //    if (response.statusCode == 200) {
  //      setState(() {
  //        _placeList = jsonDecode(response.body.toString())["predictions"];
  //      });
  //    } else {
  //      throw Exception("Failed load Dta");
  //    }
  //  }
  //
  //
  // String location ='Null, Press Button';
  // String Address = 'search';
  // Future<Position> _getGeoLocationPosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     await Geolocator.openLocationSettings();
  //     return Future.error('Location services are disabled.');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }
  // Future<void> GetAddressFromLatLong(Position position)async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  //   print(placemarks);
  //   Placemark place = placemarks[0];
  //   Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  //   setState(()  {
  //   });
  // }
  //
  //  @override
  //  void initState() {
  //    // TODO: implement initState
  //    super.initState();
  //    loadData();
  //    controller.addListener(() {
  //      onChanged();
  //    });
  //  }

  late TextEditingController mainText;

  // mainText =TextEditingController(text: widget.location.eventAddress!.fullAddress);
  final List<Marker> markers = [];
  final Set<Marker> _markers = Set();
  PlacesService _placesService = PlacesService();
  List<PlacesAutoCompleteResult> _autoCompleteResult = [];
  late LatLng latLng;
  LatLng? latlng = LatLng(30.183419, 71.427832);
  double lat = 0.0;
  double lng = 0.0;
  bool isClicked = false;
  late  final latt;
  late  final long;

  addMarker(double lat, double long) {
    int id = Random().nextInt(100);
    setState(() {
      markers.add(Marker(
          position:
              LatLng(widget.location!.toDouble(), widget.location!.toDouble()),
          markerId: MarkerId(id.toString())));
    });
  }

  final key = GlobalKey<FormState>();
  TextEditingController selectedAddress = TextEditingController();
  TextEditingController current = TextEditingController();

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   openLoadingDialog(context, "Loading...");
    //   getDressCodes();
    // });
    // var startBreak = startShift.add(Duration(hours: widget.selectedEventStartTime.hour));
    // loca = widget.event;
    _placesService.initialize(
        apiKey: "AIzaSyA1kEvCbj9i4-ez8d8KEvEfUuoDzFyjvEc");
    // city = TextEditingController(text: widget.event.eventAddress!.city);
    // zip = TextEditingController(text: widget.event.eventAddress!.zip);
    // state = TextEditingController(text: widget.event.eventAddress!.state);
    mainText = TextEditingController(text: "");
    // print(startBreak);
  }

  MapType _defaultMapType = MapType.normal;

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  String? _currentAddress;
  TextEditingController _currentAddress1 = TextEditingController();
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition().then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        _currentAddress1 = TextEditingController(
            text: " ${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}");
        print("long : ${_currentPosition!.longitude}");
        print("lat : ${_currentPosition!.latitude}");
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
          ),
          child: Column(
            children: [
              Expanded(
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  // onMapCreated: _onMapCreated,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.location ?? 30.183419,
                        widget.location ?? 71.427832),
                    zoom: 10.0,
                  ),
                  // markers: markers.toSet()
                  markers: _markers,
                ),
              ),
              // Container(
              //   // margin: EdgeInsets.only(top: 80, right: 10),
              //   alignment: Alignment.topRight,
              //   child: Column(
              //       children: <Widget>[
              //         FloatingActionButton(
              //             child: Icon(Icons.layers),
              //             elevation: 5,
              //             backgroundColor: Colors.teal[200],
              //             onPressed: () {
              //               _changeMapType();
              //               print('Changing the Map Type');
              //             }),
              //       ]),
              // ),
              Container(
                // width: width,
                // height: height * 0.4,
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
                        "Find Place",
                        'assets/images/left.svg',
                        Colors.black,
                        Colors.black,
                        () {
                          Get.back();
                        },
                      ),
                      // Container(
                      //   height: 150,
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.grey,
                      //         blurRadius: 5,
                      //       ),
                      //     ],
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Container(
                      //         padding:
                      //         EdgeInsets.symmetric(horizontal: 15),
                      //         child: Text(
                      //           mainText.text,
                      //           style: TextStyle(
                      //             color: Colors.black.withOpacity(0.5),
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w300,
                      //             height: 2.3,
                      //           ),
                      //         ),
                      //         height: 40,
                      //       ),
                      //     ],
                      //   ),
                      // ),i
                      // isClicked == true
                      //     ? Padding(
                      //       padding: const EdgeInsets.symmetric(vertical: 18.0),
                      //       child: Container(
                      //   height: 60,
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(5),
                      //             border: Border.all(color: Colors.black.withOpacity(0.3)),
                      //           ),
                      //         child: Center(child: Padding(
                      //           padding: const EdgeInsets.only(right: 70.0),
                      //           child: Text('${_currentAddress ?? "Address"}' , maxLines: 1,),
                      //         )) ,
                      //         ),
                      //     )
                      //     :
                      //     Text('ADDRESS: ${_currentAddress ?? ""}') ,
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Form(
                              key: key,
                              child: ConneventsTextField(
                                // hintText: "dsfd",
                                // hintStyleColor: Colors.black,
                                controller: mainText.text.isNotEmpty
                                    ? mainText
                                    : _currentAddress1,
                                onSaved: (value) =>
                                    widget.location = value! as double,
                                onChanged: (value) async {
                                  setState(() {
                                    print(value);
                                  });
                                  final autoCompleteSuggestions =
                                      await _placesService
                                          .getAutoComplete(value);
                                  _autoCompleteResult = autoCompleteSuggestions;
                                },
                              ),
                            ),
                          ),
                          if (_autoCompleteResult.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 90.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black)),
                                height: 140,
                                child: ListView.builder(
                                  itemCount: _autoCompleteResult.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      title: Text(
                                        _autoCompleteResult[index].mainText ??
                                            "",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      subtitle: Text(
                                        _autoCompleteResult[index]
                                                .description ??
                                            "",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onTap: () async {
                                        var id = _autoCompleteResult[index].placeId;
                                        final placeDetails = await _placesService.getPlaceDetails(id!);
                                        setState(() {
                                          // zip.text = placeDetails.zip!;
                                          // state.text = placeDetails.state!;
                                          // city.text = placeDetails.city!;
                                          latlng = LatLng(lat, lng);
                                          widget.location = placeDetails.lat!;
                                          widget.location = placeDetails.lng!;
                                          print("lat ${placeDetails.lat}");
                                          print("long ${placeDetails.lng}");
                                          mainText.text = "${_autoCompleteResult[index].mainText!} " + _autoCompleteResult[index].secondaryText!;
                                          _autoCompleteResult.clear();
                                          addMarker(widget.location!.toDouble(),
                                              widget.location!.toDouble());
                                        });
                                         latt = placeDetails.lat;
                                         long = placeDetails.lng;
                                        print("latt ${latt}");
                                        print("long ${long}");
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
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
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isClicked = true;
                                  print("true");
                                });
                                // loadData();
                                _getCurrentPosition();
                              },
                              child: SvgPicture.asset(
                                'assets/images/gps.svg',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // print('selectedAddressText ${_currentAddress}');
                          // print('longitude ${_currentPosition!.longitude}');
                          // print('latitude ${_currentPosition!.latitude}');
                          // print("lattttt $latt");
                          // print('lat'
                          //     'long $lat $lng');
                          // print("lat $_currentPosition");
                          // print("lat");
                          // Position position = await _getGeoLocationPosition();
                          // location ='Lat: ${position.latitude.toString()} , Long: ${position.longitude.toString()}';
                          // GetAddressFromLatLong(position);
                          // if (key.currentState!.validate()) {
                          if (mainText.text.isEmpty &&
                              _currentAddress1.text.isEmpty) {
                            toastFailedMessage(
                                'Enter Your Address', Colors.red);
                          } else {
                            // SharedPreferences prefs = await SharedPreferences.getInstance();
                            // prefs.setDouble('latitude', _currentPosition!.latitude);
                            // prefs.setDouble('longitude', _currentPosition!.longitude);
                            Get.to(
                              JobDetails(
                                latitude: "${_currentPosition?.latitude == null ? latt : _currentPosition?.latitude}",
                                longitude: "${_currentPosition?.longitude == null ? long : _currentPosition?.longitude}",
                                // latitude1: "${latt}",
                                // longitude1: "${long}",
                                currentaddress: "${mainText.text.toString()}",
                                currentaddress1: "${_currentAddress1.text.toString()}",
                              ),
                            );
                          }
                          // }
                        },
                        child: mainButton(
                            "Next", Color.fromRGBO(43, 101, 236, 1), context),
                      )
                      // Container(
                      //   width: width,
                      //   height: height * 0.4,
                      //   decoration: const BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.only(
                      //       topLeft: Radius.circular(30),
                      //       topRight: Radius.circular(30),
                      //     ),
                      //   ),
                      //   child: SingleChildScrollView(
                      //     child: Column(
                      //       children: [
                      //         // Padding(
                      //         //   padding: const EdgeInsets.symmetric(
                      //         //       horizontal: 30, vertical: 30),
                      //         //   child: Column(
                      //         //     children: [
                      //         //       Bar(
                      //         //         "Find Place",
                      //         //         'assets/images/left.svg',
                      //         //         Colors.black,
                      //         //         Colors.black,
                      //         //         () {
                      //         //           Get.back();
                      //         //         },
                      //         //       ),
                      //         //       SizedBox(
                      //         //         height: height * 0.03,
                      //         //       ),
                      //         //       Form(
                      //         //         key: key,
                      //         //         child: TextFormField(
                      //         //           controller: controller,
                      //         //           textAlign: TextAlign.left,
                      //         //           style: const TextStyle(
                      //         //             color: Color.fromRGBO(167, 169, 183, 1),
                      //         //             fontFamily: "Outfit",
                      //         //             fontWeight: FontWeight.w300,
                      //         //             fontSize: 14,
                      //         //           ),
                      //         //           keyboardType: TextInputType.emailAddress,
                      //         //           decoration: InputDecoration(
                      //         //             // contentPadding: const EdgeInsets.only(top: 12.0),
                      //         //             hintText: "Find place..!",
                      //         //             hintStyle: const TextStyle(
                      //         //               color: Color.fromRGBO(167, 169, 183, 1),
                      //         //               fontFamily: "Outfit",
                      //         //               fontWeight: FontWeight.w300,
                      //         //               fontSize: 14,
                      //         //             ),
                      //         //             prefixIcon: Padding(
                      //         //               padding: const EdgeInsets.all(12.0),
                      //         //               child: SvgPicture.asset(
                      //         //                   "assets/images/location.svg"),
                      //         //             ),
                      //         //             enabledBorder: OutlineInputBorder(
                      //         //               borderRadius: BorderRadius.circular(12),
                      //         //               borderSide: const BorderSide(
                      //         //                 color: Color.fromRGBO(243, 243, 243, 1),
                      //         //                 width: 1.0,
                      //         //               ),
                      //         //             ),
                      //         //             focusedBorder: OutlineInputBorder(
                      //         //               borderRadius: BorderRadius.circular(12),
                      //         //               borderSide: const BorderSide(
                      //         //                 color: Color.fromRGBO(243, 243, 243, 1),
                      //         //                 width: 1.0,
                      //         //               ),
                      //         //             ),
                      //         //           ),
                      //         //         ),
                      //         //       ),
                      //         //       // Expanded(
                      //         //       //   child: ListView.builder(
                      //         //       //     itemCount: _placeList.length,
                      //         //       //     itemBuilder: (context,  index) {
                      //         //       //       return ListTile(
                      //         //       //         title: Text("${_placeList[index]}"),
                      //         //       //       );
                      //         //       //     },
                      //         //       //   ),
                      //         //       // ),
                      //         //       Padding(
                      //         //         padding: const EdgeInsets.symmetric(vertical: 12.0),
                      //         //         child: Row(
                      //         //           children: [
                      //         //             Text(
                      //         //               "Choose on map  ",
                      //         //               style: const TextStyle(
                      //         //                 color: Color.fromRGBO(167, 169, 183, 1),
                      //         //                 fontFamily: "Outfit",
                      //         //                 fontWeight: FontWeight.w300,
                      //         //                 fontSize: 14,
                      //         //               ),
                      //         //             ),
                      //         //             GestureDetector(
                      //         //               onTap: () {
                      //         //                 loadData();
                      //         //               },
                      //         //               child: SvgPicture.asset(
                      //         //                 'assets/images/gps.svg',
                      //         //               ),
                      //         //             ),
                      //         //           ],
                      //         //         ),
                      //         //       ),
                      //         //     ],
                      //         //   ),
                      //         // ),
                      //         // GestureDetector(
                      //         //     onTap: () async {
                      //         //       Position position = await _getGeoLocationPosition();
                      //         //       location ='Lat: ${position.latitude.toString()} , Long: ${position.longitude.toString()}';
                      //         //       GetAddressFromLatLong(position);
                      //         //       if (key.currentState!.validate()) {
                      //         //         if (controller.text.isEmpty) {
                      //         //           toastFailedMessage(
                      //         //               'Enter Your Address', Colors.red);
                      //         //         } else {
                      //         //
                      //         //           SharedPreferences sharedPref = await SharedPreferences.getInstance();
                      //         //           await sharedPref.setString('longitude', long);
                      //         //           await sharedPref.setString('lattitude', lat);
                      //         //           print("longitude is = $long");
                      //         //           print("lattitude is = $lat");
                      //         //           Get.to(
                      //         //           JobDetails(
                      //         //             address: controller.text.toString(),
                      //         //             latitude: lat,
                      //         //             longitude: long,
                      //         //             currentaddress: Address,
                      //         //           ),
                      //         //           );
                      //         //         }
                      //         //       }
                      //         //     },
                      //         //     child: mainButton(
                      //         //         "Next", Color.fromRGBO(43, 101, 236, 1), context)),
                      //         SizedBox(
                      //           height: height * 0.02,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ConneventsTextField extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? name;
  Color? color;
  bool isTextFieldEnabled;
  final TextInputType? keyBoardType;
  final String? value;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Color? textColor;
  final Color? hintStyleColor;
  final Color? cursorColor;
  final IconData? icon;
  final Color? iconColor;
  final Color? borderColor;
  final Color? errorTextColor;
  final TextStyle? errorStyle;
  final String? hintText;
  final int? maxLines;

  ConneventsTextField(
      {Key? key,
      this.color = Colors.white,
      this.isTextFieldEnabled = true,
      this.maxLines,
      this.onChanged,
      this.hintText,
      this.value,
      this.name,
      this.icon,
      this.controller,
      this.validator,
      this.keyBoardType,
      this.borderColor,
      this.cursorColor,
      this.errorTextColor,
      this.errorStyle,
      this.hintStyleColor,
      this.iconColor,
      this.onFieldSubmitted,
      this.onSaved,
      this.textColor})
      : super(key: key);

  @override
  _ConneventsTextFieldState createState() => _ConneventsTextFieldState();
}

class _ConneventsTextFieldState extends State<ConneventsTextField> {
  final _node = FocusNode();

  @override
  void initState() {
    super.initState();
    _node.addListener(_listenToFocus);
  }

  _listenToFocus() => setState(() {});

  @override
  void dispose() {
    _node.removeListener(_listenToFocus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          // BoxShadow(color: globalLGray, blurRadius: 5),
        ],
      ),
      child: TextFormField(
        focusNode: _node,
        initialValue: widget.value,

        onSaved: widget.onSaved,
        controller: widget.controller,
        enabled: widget.isTextFieldEnabled,
        textCapitalization: TextCapitalization.sentences,
        //  inputFormatters: widget.onlyNumbers! ? [FilteringTextInputFormatter.digitsOnly] : null,
        validator: widget.validator,
        textInputAction: TextInputAction.newline,
        onFieldSubmitted: widget.onFieldSubmitted ?? (val) {},
        onChanged: widget.onChanged ?? (val) {},
        keyboardType: widget.keyBoardType,
        maxLines: 1,
        style: TextStyle(
          color: Colors.black,
          height: 1.7,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorStyle: widget.errorStyle,
          fillColor: widget.color,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 14,
            height: 1.7,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
