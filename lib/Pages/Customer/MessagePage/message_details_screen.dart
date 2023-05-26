// import 'package:flutter/material.dart';
//
// class DateTimePicker extends StatefulWidget {
//   @override
//   _DateTimePickerState createState() => _DateTimePickerState();
// }
//
// class _DateTimePickerState extends State<DateTimePicker> {
//   DateTime? selectedDate;
//   TimeOfDay? startTime;
//   TimeOfDay? endTime;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Date and Time Picker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               child: Text(selectedDate != null
//                   ? 'Selected Date: ${selectedDate.toString().split(' ')[0]}'
//                   : 'Select Date'),
//               onPressed: () {
//                 _selectDate(context);
//               },
//             ),
//             ElevatedButton(
//               child: Text(startTime != null
//                   ? 'Selected Start Time: ${startTime?.format(context)}'
//                   : 'Select Start Time'),
//               onPressed: () {
//                 _selectStartTime(context);
//               },
//             ),
//             ElevatedButton(
//               child: Text(endTime != null
//                   ? 'Selected End Time: ${endTime?.format(context)}'
//                   : 'Select End Time'),
//               onPressed: () {
//                 _selectEndTime(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//
//     if (pickedDate != null && pickedDate != selectedDate) {
//       setState(() {
//         selectedDate = pickedDate;
//         startTime = null;
//         endTime = null;
//       });
//     }
//   }
//
//   Future<void> _selectStartTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (pickedTime != null) {
//       final DateTime selectedDateTime = DateTime(
//         selectedDate!.year,
//         selectedDate!.month,
//         selectedDate!.day,
//         pickedTime.hour,
//         pickedTime.minute,
//       );
//
//       if (selectedDateTime.isBefore(DateTime.now())) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Invalid Time'),
//               content: Text('Please select a future time.'),
//               actions: [
//                 ElevatedButton(
//                   child: Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         setState(() {
//           startTime = pickedTime;
//         });
//       }
//     }
//   }
//
//   Future<void> _selectEndTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (pickedTime != null) {
//       final DateTime startDateTime = DateTime(
//         selectedDate!.year,
//         selectedDate!.month,
//         selectedDate!.day,
//         startTime!.hour,
//         startTime!.minute,
//       );
//       final DateTime endDateTime = DateTime(
//         selectedDate!.year,
//         selectedDate!.month,
//         selectedDate!.day,
//         pickedTime.hour,
//         pickedTime.minute,
//       );
//
//       if (endDateTime.isBefore(startDateTime)) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Invalid Time'),
//               content: Text('End time must be greater than start time.'),
//               actions: [
//                 ElevatedButton(
//                   child: Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         setState(() {
//           endTime = pickedTime;
//         });
//       }
//     }
//   }
// }