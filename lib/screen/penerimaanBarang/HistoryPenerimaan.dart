// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, no_logic_in_create_state, avoid_print, avoid_unnecessary_containers, unnecessary_null_comparison, invalid_use_of_visible_for_testing_member, use_build_context_synchronously, prefer_interpolation_to_compose_strings
part of '../../header.dart';

class HistoryPenerimaan extends StatefulWidget {
  final objParam;
  const HistoryPenerimaan({this.objParam});
  @override
  HistoryPenerimaanState createState() => HistoryPenerimaanState(objParam);
}

class HistoryPenerimaanState extends State<HistoryPenerimaan> {
  final objParam;
  var dataListHistory = [], isLoading = true;
  HistoryPenerimaanState(this.objParam);

  @override
  void initState() {
    getHistoryTransaksi();
    super.initState();
  }

  getHistoryTransaksi() async {
    final allRows = await dbHelper.readTransaksi(
      plant: objParam["plant"],
      noPo: objParam["noPo"],
      barang: objParam["barang"],
    );
    dataListHistory = allRows;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: defWhite,
        extendBodyBehindAppBar: true,
        appBar: widget.appBarTitle(
          context: context,
          title: "History ${objParam["title"]}",
          color: Colors.transparent,
        ),
        body: Stack(children: [
          widget.bgAppbar(context: context),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                Container(
                  // padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                  height: global.getHeight(context) - (kToolbarHeight * 1),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                    color: Colors.blueGrey.shade50,
                  ),
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: SingleChildScrollView(
                      child: Column(children: getChildren()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  List<Widget> getChildren() {
    var children = <Widget>[];
    if (dataListHistory.isEmpty) {
      children.add(Container(
        padding: EdgeInsets.all(10),
        height: global.getHeight(context) / 1.5,
        child: Text("Tidak ada data history ..."),
      ));
    } else {
      children.add(Container(
        padding: EdgeInsets.all(5),
      ));
      for (var i = 0; i < dataListHistory.length; i++) {
        children.add(
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: widget.decCont2(defWhite, 20, 20, 20, 20),
            child: ListTile(
              title: Text("Nomor PO : " + dataListHistory[i]["no_po"], style: textStyling.styleText5(15, defBlack1)),
              // subtitle: Column(
              //   children: getSubChildren(dataListHistory[i]),
              // ),
              subtitle: Text(
                "NO Mobil : " +
                    dataListHistory[i]["no_mobil"] +
                    "\nTanggal : " +
                    parseDateCustom(dataListHistory[i]["created_at"], "date") +
                    "\nJam : " +
                    parseDateCustom(dataListHistory[i]["created_at"], "time") +
                    "\nKeterangan : " +
                    dataListHistory[i]["keterangan"],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // UNCOMMENT JIKA INGIN ADA FITUR DELETE
                  // IconButton(
                  //   icon: Icon(Icons.delete_rounded, color: defRed),
                  //   tooltip: "Hapus Transaksi",
                  //   onPressed: () async {
                  //     await dbHelper.deleteTransaksi(
                  //       noPo: dataListHistory[i]["no_po"],
                  //       noMobil: dataListHistory[i]["no_mobil"],
                  //       createdAt: dataListHistory[i]["created_at"],
                  //     );
                  //     getHistoryTransaksi();
                  //   },
                  // ),
                  i == 0
                      ? IconButton(
                          icon: Icon(Icons.send, color: defBlue, size: 35),
                          tooltip: "Kirim Ke Server",
                          onPressed: () async {
                            await sendToServer(dataListHistory[i]);
                            getHistoryTransaksi();
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.access_time, color: defOrange),
                          onPressed: () {
                            alert.alertWarning(context: context, text: "Kirim data paling atas terlebih dahulu");
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      }
    }
    return children;
  }

  List<Widget> getSubChildren(data) {
    var children = <Widget>[];
    List newData = jsonDecode(data["detail"]);
    for (var j = 0; j < newData.length; j++) {
      children.add(ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        minLeadingWidth: 4,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.circle, color: Colors.blueGrey, size: 14),
          ],
        ),
        title: Text(newData[j]["MATNR"].toString()),
        subtitle: Text(
          "Qty : " + newData[j]["MENGE"].toString() + " || Satuan : " + newData[j]["MEINS"],
        ),
      ));
    }
    return children;
  }

  String parseDateCustom(date, type) {
    final DateFormat formatter;
    if (type == "date") {
      formatter = DateFormat('dd/MM/yyyy');
    } else {
      formatter = DateFormat('HH:mm:ss');
    }
    final String formatted = formatter.format(DateTime.parse(date));
    return formatted.toString();
  }

  sendToServer(obj) async {
    print("asadasd");

    final data = await dbHelper.readTransaksiFilterDate(
      noMobil: obj["no_mobil"],
      noPo: obj["no_po"],
      createdAt: obj["created_at"],
    );
    await TransaksiService(
            context: context,
            objParam: data[0],
            duration: objParam["durasi"],
            isDone: data[0]["is_done"],
            title: objParam["title"])
        .createTransaksiService();

    getHistoryTransaksi();
  }
}
