import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Emp_OnGoing_List.dart';

class Emp_ONGoing extends StatefulWidget {
  const Emp_ONGoing({Key? key}) : super(key: key);

  @override
  State<Emp_ONGoing> createState() => _Emp_ONGoingState();
}

class _Emp_ONGoingState extends State<Emp_ONGoing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: EmpOnGoingJobList(),
    );
  }
}
