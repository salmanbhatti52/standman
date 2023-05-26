import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Customer_Previous_JobsList.dart';

class Customer_PreviousJobs extends StatefulWidget {
  const Customer_PreviousJobs({Key? key}) : super(key: key);

  @override
  State<Customer_PreviousJobs> createState() => _Customer_PreviousJobsState();
}

class _Customer_PreviousJobsState extends State<Customer_PreviousJobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Customer_PreviousJobList(),
    );
  }
}
