import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../widgets/MyButton.dart';
import '../../../../widgets/social_button.dart';
import '../../../Models/customer_signin_model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/ToastMessage.dart';
import '../../Bottombar.dart';
import '../../Customer/HomePage/HomePage.dart';
import '../SignUp_tab_class.dart';
import 'ForgotPassword.dart';
import 'package:http/http.dart' as http;

class CustomerLoginPage extends StatefulWidget {
  CustomerLoginPage({Key? key}) : super(key: key);

  @override
  State<CustomerLoginPage> createState() => _CustomerLoginPageState();
}

class _CustomerLoginPageState extends State<CustomerLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final key = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  bool isInAsyncCall = false;
  bool loading = true;

  CustomerSigninModel customerSigninModel = CustomerSigninModel();

  customersignin() async {
    String apiUrl = customerSignInApiUrl;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "email": emailController.text,
        "password": passwordController.text,
      },
    );
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 SignIn");
    if (response.statusCode == 200) {
      customerSigninModel = customerSigninModelFromJson(responseString);
      setState(() {});
      print('signUpModel status: ${customerSigninModel.status}');
    }
  }

  sharedPrefs() async {
    loading = true;
    setState(() {});
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = (prefs!.getString('usersCustomersId'));
    userEmail = (prefs!.getString('user_email'));
    print("userId in LoginPrefs is = $usersCustomersId");
    print("userEmail in LoginPrefs is = $userEmail");
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
        content: Text('Location services are disabled. Please enable the services'),
      ));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are denied'),
        ));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Location permissions are permanently denied, we cannot request permissions.'),
      ));
      return false;
    }

    return true;
  }

  Future<bool> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return false;

    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    setState(() {
      _currentAddress =
      '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      _currentAddress1 = TextEditingController(
          text:
          " ${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}");
      print("long : ${_currentPosition!.longitude}");
      print("lat : ${_currentPosition!.latitude}");
    });
  }

  @override
  void initState() {
    super.initState();
     sharedPrefs();
  }


  DateTime currentBackPressTime = DateTime.now();

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Tap Again to Exit');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body:
          SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: key,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email Address",
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: "Outfit",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            // letterSpacing: -0.3,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailController,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Color.fromRGBO(167, 169, 183, 1),
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            return RegExp(
                                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                .hasMatch(val!)
                                ? null
                                : "Please enter correct Email";
                          },
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.only(top: 12.0),
                            hintText: "Enter your email address",
                            hintStyle: const TextStyle(
                              color: Color.fromRGBO(167, 169, 183, 1),
                              fontFamily: "Outfit",
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset("assets/images/email.svg"),
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
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          "Password",
                          style: TextStyle(
                            color: Color.fromRGBO(25, 29, 49, 1),
                            fontFamily: "Outfit",
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            // letterSpacing: -0.3,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordController,
                          style: const TextStyle(
                            color: Color.fromRGBO(167, 169, 183, 1),
                            fontFamily: "Outfit",
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                          obscureText: isPasswordObscure,
                          obscuringCharacter: '*',
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            hintStyle: const TextStyle(
                              color: Color.fromRGBO(167, 169, 183, 1),
                              fontFamily: "Outfit",
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                            prefixIcon: InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  isPasswordObscure
                                      ? "assets/images/lock.svg"
                                      : "assets/images/lock.svg",
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  isPasswordObscure = !isPasswordObscure;
                                });
                              },
                            ),
                            suffixIcon: InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  isPasswordObscure
                                      ? "assets/images/eye.svg"
                                      : "assets/images/eye.svg",
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  isPasswordObscure = !isPasswordObscure;
                                });
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
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
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: TextButton(
                        onPressed: () {
                          Get.to( () => const CustomerForgotPassword(),
                            transition : Transition.rightToLeftWithFade,
                            duration: Duration(milliseconds: 250),);
                        },
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                              fontFamily: "Outfit",
                              fontSize: 14,
                              color: Color.fromRGBO(167, 169, 183, 1),
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () async {
                        final currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus &&
                            currentFocus.focusedChild != null) {
                          FocusManager.instance.primaryFocus
                              ?.unfocus();
                        }
                      if (key.currentState!.validate()) {
                        if (emailController.text.isEmpty) {
                          toastFailedMessage('email cannot be empty', Colors.red);
                        } else if (passwordController.text.length < 8) {
                          toastFailedMessage(
                              'password must be 8 digit', Colors.red);
                        } else {
                          setState(() {
                            isInAsyncCall = true;
                          });

                          final locationPermissionGranted = await _getCurrentPosition();

                          if (!locationPermissionGranted) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Failed to retrieve location'),
                            ));
                            setState(() {
                              isInAsyncCall = false;
                            });
                            return;
                          }

                          await customersignin();

                          if (customerSigninModel.status == "success") {

                            SharedPreferences sharedPref = await SharedPreferences.getInstance();
                            await sharedPref.setString('user_email', "${customerSigninModel.data?.email.toString()}");
                            await sharedPref.setString('phoneNumber', "${customerSigninModel.data?.phone.toString()}");
                            await sharedPref.setString('firstName', "${customerSigninModel.data?.firstName.toString()}");
                            await sharedPref.setString('lastName', "${customerSigninModel.data?.lastName.toString()}");
                            await sharedPref.setString('profilePic', "${baseUrlImage+customerSigninModel.data!.profilePic.toString()}");
                            await sharedPref.setString('usersCustomersId', "${customerSigninModel.data?.usersCustomersId.toString()}");
                            await sharedPref.setString('password', "${customerSigninModel.data?.password.toString()}");
                            await sharedPref.setString('oneSignalId', "${customerSigninModel.data?.oneSignalId}");

                            Future.delayed(const Duration(seconds: 3), () {
                              if(customerSigninModel.data!.usersCustomersType == "Customer"){
                                Get.offAll(bottom_bar(currentIndex: 0,),
                                  transition : Transition.downToUp,
                                  duration: Duration(milliseconds: 350),);
                                toastSuccessMessage("Login Successfully", Colors.green);
                              } else {
                                toastFailedMessage("Invalid email", Colors.red);
                              }
                              setState(() {
                                isInAsyncCall = false;
                              });
                              print("false: $isInAsyncCall");
                            });
                          }
                          if (customerSigninModel.status != "success") {
                            toastFailedMessage(
                                customerSigninModel.message, Colors.red);
                            setState(() {
                              isInAsyncCall = false;
                            });
                          }
                        }
                      }
                    },
                    child: isInAsyncCall
                 ?  loadingBar(context)
                    : mainButton("Sign In",
                        const Color.fromRGBO(43, 101, 236, 1), context),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "OR",
                    style: TextStyle(
                        fontFamily: "Outfit",
                        fontSize: 14,
                        color: Color.fromRGBO(167, 169, 183, 1),
                        fontWeight: FontWeight.w300),
                  ),
                ),
                socialButton(context),
                SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    Get.to(  () => SignUpTabClass(signup: 0,),  transition : Transition.upToDown,
                      duration: Duration(milliseconds: 350),);
                  },
                  child: const Text(
                    'Register Your Account',
                    style: TextStyle(
                      color: Color(0xff2B65EC),
                      fontFamily: "Outfit",
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                // Container(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       const Text(
                //         'No account yet?',
                //         style: TextStyle(
                //           color: Color(0xffA7A9B7),
                //           fontFamily: "Outfit",
                //           fontSize: 14,
                //           fontWeight: FontWeight.w300,
                //           // letterSpacing: -0.3,
                //         ),
                //       ),
                //       TextButton(
                //         onPressed: () {
                //          Get.to( SignUpTabClass(signup: 0,));
                //         },
                //         child: const Text(
                //           'Register Your Account',
                //           style: TextStyle(
                //             color: Color(0xff2B65EC),
                //             fontFamily: "Outfit",
                //             fontSize: 14,
                //             fontWeight: FontWeight.w300,
                //             // letterSpacing: -0.3,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        // ),
      ),
    );
  }
}
