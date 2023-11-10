// ignore_for_file: prefer_typing_uninitialized_variables, file_names, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable, use_build_context_synchronously
part of "../header.dart";

class TransaksiService {
  final BuildContext context;
  final objParam;
  final duration;
  final isDone;

  TransaksiService({required this.context, this.objParam, this.duration, this.isDone = "0"});

  Future createTransaksiService() async {
    alert.loadingAlert(context: context, text: "Mohon Tunggu .. ", isPop: false);
    var dataReturn;

    var imageFileList = jsonDecode(objParam["foto"]);
    var request = http.MultipartRequest('POST', global.getTrxServiceUrl("transaksi/save"));
    request.headers["Authorization"] = 'Bearer ' + preference.getData('token');
    request.fields['plant'] = objParam["plant"];
    request.fields['nomer_po'] = objParam['no_po'];
    request.fields['detail'] = objParam["detail"];
    request.fields['no_mobil'] = objParam["no_mobil"];
    request.fields['keterangan'] = objParam["keterangan"];
    request.fields['lat'] = objParam["lat"];
    request.fields['lng'] = objParam["lng"];
    request.fields['timestamp'] = parseDateCustom(objParam["created_at"]);
    request.fields['no_doc'] = objParam["no_doc"];
    request.fields['version'] = appVersion;
    request.fields['imei'] = "123456";
    request.fields['zhours'] = duration.toString();
    request.fields['is_done'] = isDone.toString();

    for (var i = 0; i < imageFileList.length; i++) {
      request.files.add(await http.MultipartFile.fromPath('foto[]', File(imageFileList[i]).path));
    }

    try {
      await request.send().then((val) async {
        var responseString = await val.stream.bytesToString();
        final decodedMap = json.decode(responseString);
        if (decodedMap["success"] == false) {
          global.errorResponsePop(context, decodedMap["message"]);
        } else {
          if (isDone.toString() == "1") {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          }
          global.successResponsePop(context, "Data Berhasil Disimpan");
          await dbHelper.updateStatusTransaksi(
            noMobil: objParam["no_mobil"],
            noPo: objParam["no_po"],
            createdAt: objParam["created_at"],
            status: "1",
          );
        }
      });
    } catch (err) {
      global.errorResponsePop(context, err.toString());
    }
  }

  Future getNoDoc() async {
    var dataReturn;
    try {
      var url = global.getTrxServiceUrl("transaksi/getNoDoc");
      var header = {'authorization': 'Bearer ' + preference.getData('token')};
      await http.post(url, headers: header, body: objParam).then((res) async {
        print(res.body);
        var data = json.decode(res.body);
        if (data["success"] == 'false') {
          if (data["message" == "Unauthenticated."]) {
            global.checkResponseStatus(context, res, data);
          }
        }
        dataReturn = global.checkResponseStatus(context, res, data);
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        return global.errorResponsePop(context, "Koneksi Timeout ...");
      });
    } catch (e) {
      print(e);
      dataReturn = [];
    }
    return dataReturn;
  }

  Future acceptGr() async {
    var dataReturn;
    print("okey");
    try {
      var url = global.getTrxServiceUrl("transaksi/accGr");
      var header = {'authorization': 'Bearer ' + preference.getData('token')};
      await http.post(url, headers: header, body: objParam).then((res) async {
        var data = json.decode(res.body);
        if (data["success"] == 'false') {
          if (data["message" == "Unauthenticated."]) {
            global.checkResponseStatus(context, res, data);
          }
          return global.errorResponsePop(context, data["message"]);
        }
        dataReturn = global.checkResponseStatus(context, res, data);
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        return global.errorResponsePop(context, "Koneksi Timeout ...");
      });
    } catch (e) {
      return global.errorResponsePop(context, e.toString());
    }
    return dataReturn;
  }

  String parseDateCustom(date) {
    final DateFormat formatter;
    formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(DateTime.parse(date));
    return formatted.toString();
  }
}
