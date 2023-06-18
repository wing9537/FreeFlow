import 'package:flutter/material.dart';
import 'package:free_flow/common/constant.dart';
import 'package:intl/intl.dart';

class Tool {
  static void showToast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), backgroundColor: Colors.grey),
    );
  }

  static String dateToString(DateTime dateTime) {
    return DateFormat(Format.dateTime).format(dateTime);
  }

  static DateTime stringToDate(String dateString) {
    return DateFormat(Format.dateTime).parse(dateString);
  }
}
