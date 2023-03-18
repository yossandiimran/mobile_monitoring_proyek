// ignore_for_file: prefer_typing_uninitialized_variables, file_names, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable, use_build_context_synchronously
part of "../header.dart";

class VendorService {
  final BuildContext context;
  final objParam;

  VendorService({required this.context, this.objParam});

  Future createVendorService() async {
    alert.loadingAlert(context: context, text: "Mohon Tunggu .. ", isPop: false);
    var dataReturn;
    var dataMain = jsonDecode(objParam["page1"]);
    var imageFileList = objParam["image"];

    var request = http.MultipartRequest('POST', global.getMainServiceUrl("vendor/create"));
    request.headers["Authorization"] = 'Bearer ' + preference.getData('token');
    request.fields['server_name'] = dataMain["serverData"]["name"];
    request.fields['jenis_vendor'] = dataMain["jenisVendorData"]["kode_akun"].toString();
    request.fields['company_code'] = dataMain["compCodeData"]["kode"].toString();
    request.fields['purch_org'] = dataMain["purchOrgData"]["werks"].toString();
    request.fields['nama_vendor'] = dataMain["namaVendor"];
    request.fields['short_term'] = dataMain["shortTrem"];
    request.fields['alamat'] = dataMain["alamat"];
    request.fields['kode_negara'] = dataMain["kodeNegaraData"]["kode"].toString();
    request.fields['no_telp'] = dataMain["noTelpon"];
    request.fields['no_hp'] = dataMain["noHp"];
    request.fields['fax'] = dataMain["fax"];
    request.fields['email'] = dataMain["email"];
    request.fields['kode_bank_1'] = dataMain["kodeBankData"]["kode"].toString();
    request.fields['no_rek_1'] = dataMain["noRek"];
    request.fields['atas_nama_1'] = dataMain["atasNama"];
    request.fields['kode_bank_2'] = dataMain["kodeBankData2"]["kode"].toString();
    request.fields['no_rek_2'] = dataMain["noRek2"];
    request.fields['atas_nama_2'] = dataMain["atasNama2"];
    request.fields['durasi_pembayaran'] = dataMain["lamaPembayaranData"]["kode"].toString();
    request.fields['kurs'] = dataMain["kurs"];
    request.fields['no_ktp'] = dataMain["noKtp"];
    request.fields['no_npwp'] = dataMain["noNpwp"];

    for (var i = 0; i < imageFileList.length; i++) {
      request.files.add(await http.MultipartFile.fromPath('foto[]', imageFileList[i].path));
    }

    await request.send().then((val) async {
      var responseString = await val.stream.bytesToString();
      final decodedMap = json.decode(responseString);
      print(decodedMap);
      if (decodedMap["success"] == false) {
        global.errorResponsePop(context, decodedMap["message"]);
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        global.successResponsePop(context, "Data Berhasil Disimpan");
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future getDetailVendor() async {
    var dataReturn;
    try {
      var url = global.getMainServiceUrl("vendor/detail");
      var header = {'authorization': 'Bearer ' + preference.getData('token')};
      var body = {
        "kode_vendor": objParam["kodeVendor"],
        "company_code": objParam["compCodeData"]["kode"],
        "purch_org": objParam["purchOrgData"]["werks"],
      };

      await http.post(url, headers: header, body: body).then((res) async {
        var data = json.decode(res.body);
        dataReturn = global.checkResponseStatus(context, res, data);
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        return global.errorResponsePop(context, "Koneksi Timeout ...");
      });
    } catch (e) {
      dataReturn = 500;
    }
    return dataReturn;
  }

  Future changeVendorService() async {
    alert.loadingAlert(context: context, text: "Mohon Tunggu .. ", isPop: false);
    var dataReturn;
    var dataMain = jsonDecode(objParam["page1"]);
    var imageFileList = objParam["image"];

    var request = http.MultipartRequest('POST', global.getMainServiceUrl("vendor/update"));
    request.headers["Authorization"] = 'Bearer ' + preference.getData('token');
    request.fields['key'] = dataMain["key"];
    request.fields['nama_vendor'] = dataMain["namaVendor"];
    request.fields['short_term'] = dataMain["shortTrem"];
    request.fields['no_rek_1'] = dataMain["noRek"];
    request.fields['no_rek_2'] = dataMain["noRek2"];
    request.fields['atas_nama_1'] = dataMain["atasNama"];
    request.fields['atas_nama_2'] = dataMain["atasNama2"];

    for (var i = 0; i < imageFileList.length; i++) {
      request.files.add(await http.MultipartFile.fromPath('bukti[]', imageFileList[i].path));
    }

    await request.send().then((val) async {
      var responseString = await val.stream.bytesToString();
      final decodedMap = json.decode(responseString);
      if (decodedMap["success"] == false) {
        global.errorResponsePop(context, "Gagal Mengupload Data, coba beberapa saat lagi");
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        global.successResponsePop(context, "Data Berhasil Diubah");
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future getStatusVendor() async {
    var dataReturn;
    try {
      var url = global.getMainServiceUrl("vendor/list");
      var header = {'authorization': 'Bearer ' + preference.getData('token')};
      await http.get(url, headers: header).then((res) async {
        var data = json.decode(res.body);
        dataReturn = global.checkResponseStatus(context, res, data);
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        return global.errorResponsePop(context, "Koneksi Timeout ...");
      });
    } catch (e) {
      dataReturn = "err";
    }
    return dataReturn;
  }
}
