import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_monitoring_proyek/helper/global.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_monitoring_proyek/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Helper
part 'helper/firebaseMessagingHelper.dart';
part 'helper/preference.dart';
part 'widget/Alert.dart';
part 'widget/CustomWidget.dart';
part 'widget/TextStyling.dart';

// Model
part 'model/LoginModel.dart';

// Service
part 'service/LoginService.dart';
part 'service/MasterService.dart';
part 'service/VendorService.dart';
// ================= Vendor Service ===================

// ================= Customer Service =================

// ================= Shipment Service =================

// ================= Barang Service ===================

// Screen / View ======================================
part 'screen/Login.dart';
part 'screen/ChangePass.dart';
part 'screen/Home.dart';
// ================= Vendor Screen ====================
part 'screen/vendor/HomeVendor.dart';
part 'screen/vendor/CreateVendor.dart';
part 'screen/vendor/CreateVendorUploadFile.dart';
part 'screen/vendor/StatusVendor.dart';
