import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_watermark/image_watermark.dart';
import 'package:intl/intl.dart';
import 'package:grproyek/helper/global.dart';
import 'package:http/http.dart' as http;
import 'package:grproyek/main.dart';
import 'package:grproyek/model/database/TempTransaksiDBModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

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
part 'service/LaporanService.dart';
part 'service/TransaksiService.dart';
part 'service/SapService.dart';

// Screen / View ======================================
part 'screen/Login.dart';
part 'screen/ChangePass.dart';
part 'screen/Home.dart';
// ================= Penerimaan Barang Screen ====================
part 'screen/penerimaanBarang/InputPenerimaan.dart';
part 'screen/penerimaanBarang/MenuPenerimaan.dart';
part 'screen/penerimaanBarang/HistoryPenerimaan.dart';
part 'screen/penerimaanBarang/LaporanPenerimaan.dart';
