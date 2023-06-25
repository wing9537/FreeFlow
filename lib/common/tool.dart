import 'package:flutter/material.dart';
import 'package:free_flow/common/constant.dart';
import 'package:intl/intl.dart';

class Tool {
  static void showToast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), backgroundColor: Colors.grey),
    );
  }

  static String dateToString(DateTime dateTime, {String? format}) {
    return DateFormat(format ?? Format.dateTime).format(dateTime);
  }

  static DateTime stringToDate(String dateString, {String? format}) {
    return DateFormat(format ?? Format.dateTime).parse(dateString);
  }
}
