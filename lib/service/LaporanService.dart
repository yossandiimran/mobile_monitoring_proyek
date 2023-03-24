// ignore_for_file: prefer_typing_uninitialized_variables, file_names, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable
part of "../header.dart";

class LaporanService {
  final BuildContext context;
  final objParam;

  LaporanService({required this.context, this.objParam});

  Future getLaporanService() async {
    var dataReturn;
    try {
      var url = global.getTrxServiceUrl("transaksi/list");
      var header = {'authorization': 'Bearer ' + preference.getData('token')};
      await http.post(url, headers: header).then((res) async {
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
      dataReturn = [];
    }
    return dataReturn;
  }

  Future checkAvaliablePo() async {
    var dataReturn;
    try {
      var url = global.getTrxServiceUrl("transaksi/listDone");
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
}
