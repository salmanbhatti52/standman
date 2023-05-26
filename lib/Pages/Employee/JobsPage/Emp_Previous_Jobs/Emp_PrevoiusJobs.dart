import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Emp_Previous JobsList.dart';

class EmpPreviousJobs extends StatefulWidget {
  const EmpPreviousJobs({Key? key}) : super(key: key);

  @override
  State<EmpPreviousJobs> createState() => _EmpPreviousJobsState();
}

class _EmpPreviousJobsState extends State<EmpPreviousJobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: EmpPreviousJobList(),
    );
  }
}
