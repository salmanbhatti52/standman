import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastFailedMessage(toastMessage, bgColor) {
  return Fluttertoast.showToast(
      msg: toastMessage.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

toastSuccessMessage(toastMessage, bgColor) {
  return Fluttertoast.showToast(
      msg: toastMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

toastMessage(toastMessage) {
  return Fluttertoast.showToast(
      msg: toastMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.9),
      textColor: Colors.white,
      fontSize: 16.0);
}
