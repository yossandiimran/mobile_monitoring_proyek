// ignore_for_file: file_names, prefer_typing_uninitialized_variables, avoid_print, prefer_interpolation_to_compose_strings
part of '../header.dart';

class SapService {
  final context, objParam;

  SapService({
    required BuildContext this.context,
    required var this.objParam,
  });

  callResponseSap({urlSap}) async {
    var dataReturn;
    var url = global.getMainServiceUrl('sap/trx');
    try {
      await http.post(url, headers: {
        'authorization': 'Bearer ' + preference.getData('token'),
      }, body: {
        'url': urlSap,
        'type': 'get',
        'werks': preference.getData("plant"),
        'param': jsonEncode(objParam),
      }).then((res) {
        print("urra");
        var data = json.decode(res.body);
        if (res.statusCode == 200) {
          if (data["T_RETURN"].length != 0) {
            return global.errorResponse(context, data["T_RETURN"][0]["MESSAGE"]);
          } else {
            dataReturn = data;
          }
        } else if (res.statusCode == 400) {
          return global.errorResponse(context, data["message"]);
        } else {
          preference.clearPreference();
          return global.errorResponseNavigate(context, "Sesi Anda Habis, Silahkan Login Ulang !", '/');
        }
      }).timeout(const Duration(seconds: 100), onTimeout: () {
        return global.errorResponseNavigate(context, "Kesalahan Saat Koneksi Ke SAP !", '/home');
      }).catchError((err1) {
        return global.errorResponseNavigate(context, url, '/home');
      });
    } catch (err2) {
      return global.errorResponseNavigate(context, "Kesalahan Sistem Android!", '/home');
    }
    return dataReturn;
  }
}
