import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/employee_signin_model.dart';
import '../../../Utils/api_urls.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/ToastMessage.dart';
import '../../../widgets/social_button.dart';
import '../../Customer/HomePage/HomePage.dart';
import '../../EmpBottombar.dart';
import '../../Employee/HomePage/EmpHomePage.dart';
import '../../session_maintain.dart';
import '../SignUp_tab_class.dart';
import 'EmpForgotPassword.dart';
import 'package:http/http.dart' as http;

class EmpLoginPage extends StatefulWidget {
  EmpLoginPage({Key? key}) : super(key: key);

  @override
  State<EmpLoginPage> createState() => _EmpLoginPageState();
}

class _EmpLoginPageState extends State<EmpLoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final key = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  bool isInAsyncCall = false;

  EmployeeSigninModel employeeSigninModel = EmployeeSigninModel();

  employeesignin() async {
    String apiUrl = employeeSignInApiUrl;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "email": emailController.text.toString(),
        "password": passwordController.text.toString(),
      },
    );
    final responseString = response.body;
    print("responseSignInApi: $responseString");
    print("status Code SignIn: ${response.statusCode}");
    print("in 200 SignIn");
    if (response.statusCode == 200) {
      employeeSigninModel = employeeSigninModelFromJson(responseString);
      setState(() {});
      print('signUpModel status: ${employeeSigninModel.status}');
      print('signUpModel email: ${employeeSigninModel.data?.email}');
    }
  }

  bool loading = true;
  // String? userFirstName, userLastName, userImage;
  sharedPrefs() async {
    loading = true;
    setState(() {});
    print('in LoginPage shared prefs');
    empPrefs = await SharedPreferences.getInstance();
    empUsersCustomersId = (empPrefs!.getString('usersCustomersId'));
    empUserEmail = (empPrefs!.getString('user_email'));
    // userFirstName = (prefs!.getString('user_first_name'));
    // userLastName = (prefs!.getString('user_last_name'));
    print("userId in LoginPrefs is = $empUsersCustomersId");
    print("userEmail in LoginPrefs is = $empUserEmail");
    // print("userFirstName in LoginPrefs is = $userFirstName $userLastName");

    // if (empUsersCustomersId != null) {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => Empbottom_bar(currentIndex: 0,)));
    // }
    // else{
    //   loading = false;
    //   setState(() {});
    //   // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    //   print("userId value is = $usersCustomersId");
    // }
  }

  // bool isLoggedIn = false;
  // void checkLoginStatus() async {
  //   bool loggedIn = await SessionManager.isLoggedIn();
  //   setState(() {
  //     isLoggedIn = loggedIn;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
    // checkLoginStatus();
  }

  DateTime currentBackPressTime = DateTime.now();

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Tap Again to Exit'); // you can use snackbar too here
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body:
        // ModalProgressHUD(
        //   inAsyncCall: isInAsyncCall,
        //   opacity: 0.02,
        //   blur: 0.5,
        //   color: Colors.transparent,
        //   progressIndicator: CircularProgressIndicator(
        //     color: Colors.blue,
        //   ),
        //   child:
          SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
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
                            // contentPadding: const EdgeInsets.only(top: 12.0),
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
                          Get.to(EmployeeForgotPassword());
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
                      if (key.currentState!.validate()) {
                        if (emailController.text.isEmpty) {
                          toastFailedMessage('email cannot be empty', Colors.red);
                        } else if (passwordController.text.length < 6) {
                          toastFailedMessage(
                              'password must be 6 digit', Colors.red);
                        } else {
                          setState(() {
                            isInAsyncCall = true;
                          });
                          await employeesignin();

                          if (employeeSigninModel.status == "success") {
                            SharedPreferences sharedPref = await SharedPreferences.getInstance();
                            await sharedPref.setString('empUser_email', "${employeeSigninModel.data?.email.toString()}");
                            await sharedPref.setString('empPhoneNumber',
                                "${employeeSigninModel.data?.phone.toString()}");
                            await sharedPref.setString('empFullName',
                                "${employeeSigninModel.data?.fullName.toString()}");
                            await sharedPref.setString('empProfilePic',
                                "${employeeSigninModel.data?.profilePic.toString()}");
                            await sharedPref.setString('empUsersCustomersId',
                                "${employeeSigninModel.data?.usersCustomersId.toString()}");

                            Future.delayed(const Duration(seconds: 3), () {
                              if (employeeSigninModel.data!.usersCustomersType ==
                                  "Employee") {
                                Get.offAll(Empbottom_bar(currentIndex: 0,));
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
                          if (employeeSigninModel.status != "success") {
                            toastFailedMessage(
                                employeeSigninModel.message, Colors.red);
                            setState(() {
                              isInAsyncCall = false;
                            });
                          }
                        }
                      }
                      // if (isLoggedIn) {
                      //   SessionManager.setLoggedIn(false);
                      // } else {
                      //   SessionManager.setLoggedIn(true);
                      // }
                      // setState(() {
                      //   isLoggedIn = !isLoggedIn;
                      // });
                    },
                    child: isInAsyncCall
                        ?  loadingBar(context)
                    : mainButton(
                        "Sign In", Color.fromRGBO(43, 101, 236, 1), context)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'No account yet?',
                        style: TextStyle(
                          color: Color(0xffA7A9B7),
                          fontFamily: "Outfit",
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          // letterSpacing: -0.3,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          //   Navigator.pushReplacementNamed(context, '/registerType');
                          Get.to(SignUpTabClass(signup: 1,));
                        },
                        // onPressed: () {
                        //   _navKey.currentState!.push(
                        //     MaterialPageRoute(
                        //       builder: (_) => SignUpTabClass(),
                        //     ),
                        //   );
                        // },
                        child: const Text(
                          'Register Your Account',
                          style: TextStyle(
                            color: Color(0xff2B65EC),
                            fontFamily: "Outfit",
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            // letterSpacing: -0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        // ),
      ),
    );
  }
}
