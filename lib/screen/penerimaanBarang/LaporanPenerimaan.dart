// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, no_logic_in_create_state, avoid_print, avoid_unnecessary_containers, unnecessary_null_comparison, invalid_use_of_visible_for_testing_member, use_build_context_synchronously, prefer_interpolation_to_compose_strings, avoid_function_literals_in_foreach_calls
part of '../../header.dart';

class LaporanPenerimaan extends StatefulWidget {
  final objParam;
  const LaporanPenerimaan({this.objParam});
  @override
  LaporanPenerimaanState createState() => LaporanPenerimaanState(objParam);
}

class LaporanPenerimaanState extends State<LaporanPenerimaan> {
  final objParam;
  var dataListHistory = [], tempListHistory = [], isLoading = true, groupedList = {};
  var statusIdx = "2";
  TextEditingController sloc = TextEditingController(text: "");
  LaporanPenerimaanState(this.objParam);

  @override
  void initState() {
    getHistoryTransaksi();
    super.initState();
  }

  getHistoryTransaksi() async {
    sloc.text = preference.getData("plant");
    Map objSend = {
      "sloc": sloc.text,
      "is_done": statusIdx,
    };
    dataListHistory = await LaporanService(context: context, objParam: objSend).getLaporanService();
    tempListHistory = dataListHistory;
    print(tempListHistory);
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
            title: "Report Penerimaan Barang Proyek ",
            color: Colors.transparent,
            action: [
              IconButton(
                onPressed: () {
                  getHistoryTransaksi();
                },
                icon: Icon(Icons.filter_list),
                tooltip: "Filter Data",
              ),
            ]),
        body: Stack(children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.only(top: kToolbarHeight, left: 20, right: 20),
                  height: kToolbarHeight * 5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [defBlack1, defGreen, defGreen],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5, left: 3, right: 3),
                            decoration: widget.decCont2(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context) / 2.5,
                            child: TextFormField(
                              textCapitalization: TextCapitalization.characters,
                              controller: sloc,
                              readOnly: true,
                              enabled: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "SLOC ...",
                                counterText: "",
                              ),
                              maxLength: 10,
                              onChanged: (value) {
                                getHistoryTransaksi();
                                setState(() {});
                              },
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont2(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context) / 2.5,
                            child: DropdownButton<String>(
                              value: statusIdx,
                              isExpanded: true,
                              items: widget.getItemsDropdown("statusReport", []),
                              onChanged: (newValue) async {
                                statusIdx = (int.parse(newValue.toString())).toString();
                                getHistoryTransaksi();
                                setState(() {});
                              },
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                  padding: EdgeInsets.only(top: 10),
                  height: global.getHeight(context) - (kToolbarHeight * 2.5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                    color: Colors.blueGrey.shade50,
                  ),
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: SingleChildScrollView(
                      child: Column(
                        children: !isLoading
                            ? getChildren()
                            : [
                                SizedBox(height: kToolbarHeight * 6),
                                CircularProgressIndicator(),
                              ],
                      ),
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

  showActionFilter() {}

  List<Widget> getChildren() {
    var children = <Widget>[];
    if (tempListHistory.isEmpty) {
      children.add(Container(
        padding: EdgeInsets.all(10),
        height: global.getHeight(context) / 1.5,
        child: Text("Tidak ada data Laporan ..."),
      ));
    } else {
      children.add(Container(
        padding: EdgeInsets.all(5),
      ));
      for (var i = 0; i < tempListHistory.length; i++) {
        children.add(
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: widget.decCont2(defWhite, 20, 20, 20, 20),
            child: ExpansionTile(
              title: Text("Nomor PO : " + tempListHistory[i]["nomer_po"].toString()),
              subtitle: Text("SLOC : " + tempListHistory[i]["plant"].toString()),
              children: getSubChildren(tempListHistory[i]),
            ),
          ),
        );
      }
    }
    return children;
  }

  List<Widget> getSubChildren(val) {
    print(val);
    var children = <Widget>[];
    var value = val["detail"];

    children.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: widget.decCont(defWhite, 20, 20, 20, 20),
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(),
            1: FixedColumnWidth(64),
            2: FixedColumnWidth(64),
          },
          children: [
            TableRow(children: [
              Container(
                color: defBlue,
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "Nama Barang",
                  textAlign: TextAlign.center,
                  style: textStyling.styleText5(14, defWhite),
                ),
              ),
              Container(
                color: defBlue,
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "QTY",
                  textAlign: TextAlign.center,
                  style: textStyling.styleText5(14, defWhite),
                ),
              ),
              Container(
                color: defBlue,
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "Satuan",
                  textAlign: TextAlign.center,
                  style: textStyling.styleText5(14, defWhite),
                ),
              ),
            ]),
            for (var i = 0; i < value.length; i++)
              TableRow(children: [
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    value[i]["TXZ01"],
                    textAlign: TextAlign.center,
                    style: textStyling.styleText5(14, defBlack1),
                  ),
                ),
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    value[i]["MENGE"].toString(),
                    textAlign: TextAlign.center,
                    style: textStyling.styleText5(14, defBlack1),
                  ),
                ),
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    value[i]["MEINS"],
                    textAlign: TextAlign.center,
                    style: textStyling.styleText5(14, defBlack1),
                  ),
                ),
              ]),
          ],
        ),
      ),
    );
    for (var i = 0; i < val["transaksi"].length; i++) {
      children.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          decoration: widget.decCont(defWhite, 20, 20, 20, 20),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
            },
            children: [
              TableRow(children: [
                Container(
                  color: defGrey,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "  No Document",
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(14, defWhite),
                  ),
                ),
                Container(
                  color: defGrey,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    val["transaksi"][i]["no_doc"].toString(),
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(14, defWhite),
                  ),
                ),
              ]),
              TableRow(children: [
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "  No Mobil",
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(14, defBlack1),
                  ),
                ),
                Container(
                  color: val["transaksi"][i]["gr"] == "X" ? Colors.green[100] : defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    val["transaksi"][i]["no_mobil"].toString(),
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(14, defBlack1),
                  ),
                ),
              ]),
              TableRow(children: [
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "  Keterangan",
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(14, defBlack1),
                  ),
                ),
                Container(
                  color: val["transaksi"][i]["gr"] == "X" ? Colors.green[100] : defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    val["transaksi"][i]["keterangan"].toString(),
                    textAlign: TextAlign.left,
                    style: textStyling.nunitoBold(14, defBlack1),
                  ),
                ),
              ]),
              TableRow(children: [
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "  Tanggal / Jam",
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(14, defBlack1),
                  ),
                ),
                Container(
                  color: val["transaksi"][i]["gr"] == "X" ? Colors.green[100] : defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    val["transaksi"][i]["timestamp"].toString(),
                    textAlign: TextAlign.left,
                    style: textStyling.nunitoBold(14, defBlack1),
                  ),
                ),
              ]),
              TableRow(children: [
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "  koordinat",
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(14, defBlack1),
                  ),
                ),
                Container(
                  color: val["transaksi"][i]["gr"] == "X" ? Colors.green[100] : defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    val["transaksi"][i]["lat"].toString() + ", " + val["transaksi"][i]["lng"].toString(),
                    textAlign: TextAlign.left,
                    style: textStyling.nunitoBold(14, defBlack1),
                  ),
                ),
              ]),
              TableRow(children: [
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "  Foto",
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(14, defBlack1),
                  ),
                ),
                Container(
                  color: val["transaksi"][i]["gr"] == "X" ? Colors.green[100] : defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Wrap(children: [
                    for (var x = 0; x < val["transaksi"][i]["foto"].length; x++)
                      GestureDetector(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  val["transaksi"][i]["no_mobil"].toString() +
                                      "\n" +
                                      val["transaksi"][i]["timestamp"].toString(),
                                  style: textStyling.styleText5(12, defBlack1),
                                ),
                                content: SingleChildScrollView(
                                    child: Container(
                                  child: Image.network(
                                    global.imageUrl + "storage/uploads/transaksi/" + val["transaksi"][i]["foto"][x],
                                  ),
                                )),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Close'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(4),
                          decoration: widget.decCont(defOrange, 10, 10, 10, 10),
                          child: Text("Foto " + (x + 1).toString(), style: textStyling.styleText5(14, defWhite)),
                        ),
                      ),
                  ]),
                ),
              ]),
              TableRow(children: [
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "  Sudah di gr",
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(14, defBlack1),
                  ),
                ),
                Container(
                  color: val["transaksi"][i]["gr"] == "X" ? Colors.green[100] : defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Wrap(children: [
                    GestureDetector(
                      onTap: () async {
                        if (val["transaksi"][i]["gr"] != "X") {
                          alert.loadingAlert(context: context, text: "Mohon Tunggu", isPop: false);
                          Map obj = {"id": val["transaksi"][i]["id"].toString()};
                          await TransaksiService(context: context, objParam: obj).acceptGr();
                          global.successResponsePop(context, "Berhasil");
                          getHistoryTransaksi();
                        }
                      },
                      child: Container(
                        width: 100,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(4),
                        decoration:
                            widget.decCont2(val["transaksi"][i]["gr"] == "X" ? defGreen : defRed, 10, 10, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            val["transaksi"][i]["gr"] == "X"
                                ? Icon(Icons.check_circle_rounded, color: defWhite)
                                : Icon(Icons.remove_circle_rounded, color: defWhite),
                            val["transaksi"][i]["gr"] == "X"
                                ? Text(" Selesai", style: textStyling.styleText5(12, defWhite))
                                : Text(" Terima", style: textStyling.styleText5(12, defWhite)),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ]),
            ],
          ),
        ),
      );
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

  acceptGr(id) async {
    getHistoryTransaksi();
  }
}
