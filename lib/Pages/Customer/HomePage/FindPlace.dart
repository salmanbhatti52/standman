import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../../../widgets/TopBar.dart';
import 'JobDetails.dart';
import 'package:places_service/places_service.dart';

class FindPlace extends StatefulWidget {
  late double? location;

  FindPlace({Key? key, this.location}) : super(key: key);

  @override
  State<FindPlace> createState() => _FindPlaceState();
}

class _FindPlaceState extends State<FindPlace> {

  late TextEditingController mainText;
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

    _placesService.initialize(
        apiKey: "AIzaSyA1kEvCbj9i4-ez8d8KEvEfUuoDzFyjvEc");
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
        print("long111 : ${_currentPosition!.longitude}");
        print("lat111 : ${_currentPosition!.latitude}");
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                      target: LatLng(widget.location ??43.64252511567895,
                          widget.location ?? -79.38652728016845),
                      zoom: 10.0,
                    ),
                    // markers: markers.toSet()
                    markers: _markers,
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
                          "Find Place",
                          'assets/images/left.svg',
                          Colors.black,
                          Colors.black,
                          () {
                            Get.back();
                          },
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Form(
                                key: key,
                                child: ConneventsTextField(
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
                            if (mainText.text.isEmpty &&
                                _currentAddress1.text.isEmpty) {
                              toastFailedMessage(
                                  'Enter Your Address', Colors.red);
                            } else {
                              Get.to(
                                JobDetails(
                                  latitude: "${_currentPosition?.latitude == null ? latt : _currentPosition?.latitude}",
                                  longitude: "${_currentPosition?.longitude == null ? long : _currentPosition?.longitude}",
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
