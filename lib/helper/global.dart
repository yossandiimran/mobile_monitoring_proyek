import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grproyek/header.dart';
import 'package:grproyek/helper/database/database.dart';

Global global = Global();
Preference preference = Preference();
Alert alert = Alert();
CustomWidget widget = CustomWidget();
TextStyling textStyling = TextStyling();
FirebaseMessagingHelper fbmessaging = FirebaseMessagingHelper();

var appVersion = '1.0.0';
final dbHelper = DatabaseHelper.instance;
//Default Theme Color
Color defBlue = const Color(0xff1572e8), defRed = const Color(0xffea4d56);
Color defOrange = const Color(0xffff910a), defGreen = const Color(0xff2bb930);
Color defGrey = const Color(0xff8d9498), defBlack1 = const Color(0xff1a2035);
Color defBlack2 = const Color(0xff202940), defWhite = Colors.white;
Color defPurple = const Color(0xff6861ce), defPurple2 = const Color(0xff5c55bf);

class Global {
  getWidth(context) => MediaQuery.of(context).size.width;
  getHeight(context) => MediaQuery.of(context).size.height;

  //Handle Service ===============================================================
  // DEV PUBLIC 36.91.208.116
  var baseUrl = 'http://36.91.208.116/user-center/public/api/';
  var transUrl = 'http://36.91.208.116/emopb/public/api/';
  var imageUrl = 'http://36.91.208.116/emopb/public/';

  // Local Dev 113
  // var baseUrl = 'http://192.168.1.113:30/sum-app/public/api/';
  // var transUrl = 'http://192.168.1.113:30/emopb/public/api/';
  // var imageUrl = 'http://192.168.1.113:30/emopb/public/';

  //PRD PUBLIC 210.210.165.197
  // var baseUrl = 'http://210.210.165.197/user-center/public/api/';
  // var transUrl = 'http://210.210.165.197/grproyek/public/api/';
  // var imageUrl = 'http://210.210.165.197/grproyek/public/';

  getMainServiceUrl(String link) => Uri.parse(baseUrl + link);
  getTrxServiceUrl(String link) => Uri.parse(transUrl + link);

  defaultErrorResponse(context, message) => alert.alertWarning(context: context, text: message);

  defaultSuccessResponse(context, message) => alert.alertSuccess(context: context, text: message);

  errorResponse(context, message) {
    Navigator.pop(context);
    alert.alertWarning(context: context, text: message);
  }

  errorResponseNavigate(context, message, route) {
    Navigator.pushNamed(context, route);
    alert.alertWarning(context: context, text: message);
  }

  successResponse(context, message) {
    Navigator.pop(context);
    alert.alertSuccess(context: context, text: message);
  }

  successResponseNavigate(context, message, route) {
    Navigator.pushNamed(context, route);
    alert.alertSuccess(context: context, text: message);
  }

  errorResponsePop(context, message) {
    Navigator.pop(context);
    alert.alertWarning(context: context, text: message);
  }

  successResponsePop(context, message) {
    Navigator.pop(context);
    alert.alertSuccess(context: context, text: message);
  }

  navigateCheckPermission({context, route, menuCode}) async {
    List<dynamic> permissionData = jsonDecode(await preference.getData("permission"));
    var checkMenu = permissionData.where((element) => element == menuCode);
    checkMenu.isNotEmpty
        ? Navigator.pushNamed(context, route)
        : alert.alertWarning(context: context, text: "Anda Tidak Memiliki Akses");
  }

  checkResponseStatus(context, res, data) async {
    if (res.statusCode == 200) {
      return data["data"];
    } else if (res.statusCode == 422) {
      return global.errorResponsePop(context, "Error 422");
    } else if (res.statusCode == 401) {
      preference.clearPreference();
      return global.errorResponseNavigate(context, "Sesi anda habis, silahkan login ulang !", '/');
    } else if (res.statusCode == 400) {
      return global.errorResponsePop(context, data["message"]);
    }
  }
}
