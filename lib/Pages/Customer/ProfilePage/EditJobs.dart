import 'package:StandMan/Models/jobEditModels.dart';
import 'package:StandMan/Pages/Bottombar.dart';
import 'package:StandMan/Pages/Customer/HomePage/HomePage.dart';
import 'package:StandMan/widgets/ToastMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/MyButton.dart';
import '../../../widgets/TopBar.dart';
import 'package:http/http.dart' as http;

class EditJob extends StatefulWidget {
  final String? jobDate;
  final String? startTime;
  final String? endTime;
  final String? jobid;
  EditJob({Key? key, this.jobDate, this.startTime, this.endTime, this.jobid})
      : super(key: key);

  @override
  State<EditJob> createState() => _EditJobState();
}

class _EditJobState extends State<EditJob> {
  JobEditModels jobEditModels = JobEditModels();
  bool isLoading = false;
  Editjob() async {
    prefs = await SharedPreferences.getInstance();
    usersCustomersId = prefs!.getString('usersCustomersId');
    print("userId in Prefs is = $usersCustomersId");
    String apiUrl = "https://admin.standman.ca/api/jobs_edit";
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Accept": "application/json"},
      body: {
        "jobs_id": "${widget.jobid}",
        "start_date": "${selectedDate.toString()}",
        "start_time": "${startTime24Hour}",
        "end_time": "${endTime24Hour}"
      },
    );
    final responseString = response.body;
    print("jobEditListModels: ${response.body}");
    print("status Code jobEditListModels: ${response.statusCode}");
    print("in 200 jobEditListModels");
    if (response.statusCode == 200) {
      jobEditModels = jobEditModelsFromJson(responseString);
      setState(() {
        isLoading = false;
      });
      print('jobEditListModels status: ${jobEditModels.status}');
      // print('jobEditListModels status: ${jobEditListModels}');

// Example usage:
      startTime = TimeOfDay(hour: 2, minute: 0); // Replace with your start time
      endTime = TimeOfDay(hour: 15, minute: 30); // Replace with your end time

      startTime24Hour = convertTimeOfDayTo24HourFormat(startTime!);
      endTime24Hour = convertTimeOfDayTo24HourFormat(endTime!);

      print(startTime24Hour!); // Output: 02:00:00
      print(endTime24Hour!);
    }
  }

  String? startTime24Hour;
  String? endTime24Hour;
// Example usage:
// Output: 15:30:00
  String convertTimeOfDayTo24HourFormat(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }

// Example usage:
  // Output: 15:30:00

  final key = GlobalKey<FormState>();
  bool isInAsyncCall = false;

  @override
  void initState() {
    super.initState();
    print("jobDate ${widget.jobDate}");
    print("TimeStart ${widget.startTime}");
    print("TimeEnd ${widget.endTime}");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: StandManAppBar1(
        title: "Edit Job",
        bgcolor: Color(0xff2B65EC),
        titlecolor: Colors.white,
        iconcolor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard when the user taps anywhere on the screen
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
              child: Column(
                children: [
                  Container(
                    child: Form(
                      key: key,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Job Date",
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
                                Container(
                                  width: Get.width,
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Color.fromRGBO(243, 243, 243, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedDate != null
                                            ? '${selectedDate.toString().split(' ')[0]}'
                                            : "${widget.jobDate}",
                                        style: TextStyle(
                                          color: selectedDate != null
                                              ? Colors.black
                                              : Color.fromRGBO(
                                                  167, 169, 183, 1),
                                          fontFamily: "Outfit",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        ),
                                      ),
                                      //     hintStyle: const

                                      InkWell(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child:
                                            // Text(
                                            //   valueDate,
                                            //   style: TextStyle(
                                            //       color: valueDate == "Select"
                                            //           ? Colors.green
                                            //           : Colors.black, fontSize: 16 ),
                                            // ),
                                            SvgPicture.asset(
                                                "assets/images/note.svg"),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Start Time",
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontFamily: "Outfit",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            // letterSpacing: -0.3,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        GestureDetector(
                                            onTap: () =>
                                                _selectStartTime(context),
                                            // onTap: () => selectTime(context),
                                            child: dateContainer(
                                              size,
                                              startTime != null
                                                  ? '${formatTimeOfDay(startTime!)}'
                                                  : "${widget.startTime}",
                                              // valueTime.toString(),
                                              // _selectedTime.format(context),
                                              Icons.calendar_today,
                                            )),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "End Time",
                                          style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontFamily: "Outfit",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            // letterSpacing: -0.3,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        GestureDetector(
                                            onTap: () =>
                                                _selectEndTime(context),
                                            // onTap: () => _EndSelectTime(context),
                                            child: dateContainer(
                                                size,
                                                // ' ${_endSelectedTime.format(context)}',
                                                endTime != null
                                                    ? '${formatTimeOfDay(endTime!)}'
                                                    : "${widget.endTime}",
                                                Icons.calendar_today)),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                Text(
                                  "These times are approximate and will be adjusted on the bill based on the registered"
                                  " time when a StandMan starts and when the Customer confirms the job is completed",
                                  style: TextStyle(
                                    color: Color(0xffC70000).withOpacity(0.5),
                                    fontFamily: "Outfit",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
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
                                    if (selectedDate?.toString() == null) {
                                      toastFailedMessage(
                                          'Date cannot be empty', Colors.red);
                                    } else if (formatTimeOfDay(startTime!) ==
                                        null) {
                                      toastFailedMessage(
                                          'Start Time  cannot be empty',
                                          Colors.red);
                                    } else if (formatTimeOfDay(endTime!) ==
                                        null) {
                                      toastFailedMessage(
                                          'End Time cannot be empty',
                                          Colors.red);
                                    } else {
                                      print(
                                          "start_date: ${selectedDate.toString()}");
                                      print(
                                          "start_time: ${formatTimeOfDay(startTime!)}");
                                      print(
                                          "end_time: ${formatTimeOfDay(endTime!)}");
                                      setState(() {
                                        isInAsyncCall = true;
                                      });
                                      await Editjob();

                                      if (jobEditModels.status == "success") {
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          Get.to(() => bottom_bar(
                                                currentIndex: 0,
                                              ));
                                          // Estimated_PaymentMethod(
                                          //   ctx: context,
                                          //   randomNumbers : randomNumbers.toString(),
                                          //   price: jobsPriceModel.data?.totalPrice,
                                          //   amount: jobsPriceModel.data?.price,
                                          //   chargers: jobsPriceModel.data?.serviceCharges,
                                          //   tax: jobsPriceModel.data?.tax,
                                          //   img: base64ID,
                                          //   jobName: jobName.text.toString(),
                                          //   date: selectedDate.toString(),
                                          //   time: startTime?.format(context),
                                          //   endtime: endTime?.format(context),
                                          //   describe: describeJob.text.toString(),
                                          //   address: widget.currentaddress.toString() == ""
                                          //       ? widget.currentaddress1.toString()
                                          //       : widget.currentaddress.toString(),
                                          //   long: widget.longitude,
                                          //   lat: widget.latitude,
                                          // );
                                        });
                                        setState(() {
                                          isInAsyncCall = false;
                                        });
                                      }
                                      if (jobEditModels.status != "success") {
                                        toastFailedMessage(
                                            jobEditModels.message, Colors.red);
                                        setState(() {
                                          isInAsyncCall = false;
                                        });
                                      }
                                    }
                                  }
                                },
                                child: isInAsyncCall
                                    ? mainButton(
                                        "Please wait", Colors.grey, context)
                                    : mainButton(
                                        "Update Job",
                                        Color.fromRGBO(43, 101, 236, 1),
                                        context)),
                            SizedBox(
                              height: Get.height * 0.03,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        startTime = null;
        endTime = null;
      });
    }
  }

  // Future<void> _selectStartTime(BuildContext context) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //
  //   if (pickedTime != null) {
  //     final DateTime selectedDateTime = DateTime(
  //       selectedDate!.year,
  //       selectedDate!.month,
  //       selectedDate!.day,
  //       pickedTime.hour,
  //       pickedTime.minute,
  //     );
  //
  //     if (selectedDateTime.isBefore(DateTime.now())) {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Invalid Time'),
  //             content: Text('Please select a future time.'),
  //             actions: [
  //               ElevatedButton(
  //                 child: Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     } else {
  //       setState(() {
  //         startTime = pickedTime;
  //       });
  //     }
  //   }
  // }

  Future<TimeOfDay?> showCustomTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
  }) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        );
      },
    );
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showCustomTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final DateTime selectedDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      if (selectedDateTime.isBefore(DateTime.now())) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Time'),
              content: Text('Please select a future time.'),
              actions: [
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          startTime = pickedTime;
        });
      }
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showCustomTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final DateTime startDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        startTime!.hour,
        startTime!.minute,
      );
      final DateTime endDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      if (endDateTime.isBefore(startDateTime)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Time'),
              content: Text('End time must be greater than start time.'),
              actions: [
                ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          endTime = pickedTime;
        });
      }
    }
  }

// Function to format the time in 12-hour clock format with AM/PM
  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }

  // DateTime? selectedDate;
  // TimeOfDay? startTime;
  // TimeOfDay? endTime;
  //
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2100),
  //   );
  //
  //   if (pickedDate != null && pickedDate != selectedDate) {
  //     setState(() {
  //       selectedDate = pickedDate;
  //       startTime = null;
  //       endTime = null;
  //     });
  //   }
  // }
  //
  // Future<void> _selectStartTime(BuildContext context) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //
  //   if (pickedTime != null) {
  //     final DateTime selectedDateTime = DateTime(
  //       selectedDate!.year,
  //       selectedDate!.month,
  //       selectedDate!.day,
  //       pickedTime.hour,
  //       pickedTime.minute,
  //     );
  //
  //     if (selectedDateTime.isBefore(DateTime.now())) {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Invalid Time'),
  //             content: Text('Please select a future time.'),
  //             actions: [
  //               ElevatedButton(
  //                 child: Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     } else {
  //       setState(() {
  //         startTime = pickedTime;
  //       });
  //     }
  //   }
  // }
  //
  // Future<void> _selectEndTime(BuildContext context) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //
  //   if (pickedTime != null) {
  //     final DateTime startDateTime = DateTime(
  //       selectedDate!.year,
  //       selectedDate!.month,
  //       selectedDate!.day,
  //       startTime!.hour,
  //       startTime!.minute,
  //     );
  //     final DateTime endDateTime = DateTime(
  //       selectedDate!.year,
  //       selectedDate!.month,
  //       selectedDate!.day,
  //       pickedTime.hour,
  //       pickedTime.minute,
  //     );
  //
  //     if (endDateTime.isBefore(startDateTime)) {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Invalid Time'),
  //             content: Text('End time must be greater than start time.'),
  //             actions: [
  //               ElevatedButton(
  //                 child: Text('OK'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     } else {
  //       setState(() {
  //         endTime = pickedTime;
  //       });
  //     }
  //   }
  // }

  Widget dateContainer(size, text, icon) {
    return Container(
      height: 50,
      width: size.width / 2.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color.fromRGBO(243, 243, 243, 1),
            width: 1.0,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon, size: 12, color: Colors.black),
          Text(text,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.black)),
          Icon(
            Icons.keyboard_arrow_down_outlined,
            size: 18,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
