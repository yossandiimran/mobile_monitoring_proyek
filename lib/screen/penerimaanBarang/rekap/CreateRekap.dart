// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, no_logic_in_create_state, avoid_print, avoid_unnecessary_containers, unnecessary_null_comparison, invalid_use_of_visible_for_testing_member, use_build_context_synchronously, prefer_interpolation_to_compose_strings, avoid_function_literals_in_foreach_calls, void_checks
part of '../../../header.dart';

class CreateRekap extends StatefulWidget {
  final objParam;
  const CreateRekap({this.objParam});
  @override
  CreateRekapState createState() => CreateRekapState(objParam);
}

class CreateRekapState extends State<CreateRekap> {
  final objParam;
  var dataListHistory = [], tempListHistory = [], isLoading = false, groupedList = {};
  var listSend = [];
  TextEditingController cpudt = TextEditingController();
  bool isAll = false;
  var statusIdx = "2";
  TextEditingController sloc = TextEditingController(text: "");
  TextEditingController po = TextEditingController(text: "");
  CreateRekapState(this.objParam);

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    sloc.text = preference.getData("plant");
    setState(() {});
  }

  getHistoryTransaksi() async {
    isLoading = true;
    setState(() {});
    Map objSend = {
      "sloc": sloc.text,
      "nomer_po": po.text,
      "tgl_awal": cpudt.text,
      "tgl_akhir": cpudt.text,
      "nomer_laporan": "null"
    };
    dataListHistory = await LaporanService(context: context, objParam: objSend).getRekapService();
    tempListHistory = dataListHistory;

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
          title: "Create Rekap Penerimaan",
          color: Colors.transparent,
          action: [],
        ),
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
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            margin: EdgeInsets.only(top: 5, left: 3, right: 3),
                            decoration: widget.decCont2(Colors.white, 10, 10, 10, 10),
                            width: global.getWidth(context) / 1.15,
                            child: Text("${preference.getData("name")}", style: textStyling.styleText5(12, defBlack1)),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 23, horizontal: 20),
                            margin: EdgeInsets.only(top: 5, left: 3, right: 3),
                            decoration: widget.decCont2(Colors.white, 10, 10, 10, 10),
                            width: global.getWidth(context) / 5,
                            child: Text(sloc.text),
                          ),
                          Spacer(),
                          Container(
                            width: global.getWidth(context) / 2,
                            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                            margin: EdgeInsets.only(top: 5, left: 3, right: 3),
                            decoration: widget.decCont2(Colors.white, 10, 10, 10, 10),
                            child: TextField(
                              controller: cpudt,
                              decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                hintText: "Tanggal",
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  setState(() {
                                    cpudt.text = formattedDate;
                                  });
                                }
                              },
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              if (cpudt.text == "") {
                                alert.alertWarning(context: context, text: "Tanggal wajib diisi !.");
                              } else {
                                getHistoryTransaksi();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: widget.decCont2(defBlue, 10, 10, 10, 10),
                              child: Icon(Icons.search_rounded, color: defWhite),
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
                  height: global.getHeight(context) - (kToolbarHeight * 3.2),
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
                                SizedBox(height: kToolbarHeight * 4),
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
          tempListHistory[i]["details"].isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: widget.decCont2(defWhite, 20, 20, 20, 20),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Nomor PO : " + tempListHistory[i]["nomer_po"].toString(),
                          style: textStyling.styleText5(14, defBlack1),
                        ),
                        subtitle: Text(
                          "SLOC : " + tempListHistory[i]["plant"].toString(),
                          style: textStyling.styleText5(14, defBlack1),
                        ),
                      ),
                      Column(children: getSubChildren(tempListHistory[i])),
                      Divider(),
                      GestureDetector(
                        onTap: () {
                          processRekapCreate(tempListHistory[i]["detail"], tempListHistory[i]["nomer_po"]);
                        },
                        child: Container(
                          decoration: widget.decCont2(defOrange, 10, 10, 10, 10),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                          child: Text(
                            "Proses",
                            style: textStyling.styleText5(12, defWhite),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
        );
      }
    }
    return children;
  }

  List<Widget> getSubChildren(val) {
    var children = <Widget>[];
    var value = val["detail"];
    for (var i = 0; i < val["details"].length; i++) {
      val["details"][i].addEntries({"nomer_po": val["nomer_po"]}.entries);
    }
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
                color: defGrey,
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                child: Text(
                  "Nama Barang",
                  textAlign: TextAlign.left,
                  style: textStyling.styleText5(12, defWhite),
                ),
              ),
              // Container(
              //   color: defGrey,
              //   padding: EdgeInsets.symmetric(vertical: 4),
              //   child: Text(
              //     "QTY",
              //     textAlign: TextAlign.center,
              //     style: textStyling.styleText5(12, defWhite),
              //   ),
              // ),
              Container(
                color: defGrey,
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "Satuan",
                  textAlign: TextAlign.center,
                  style: textStyling.styleText5(12, defWhite),
                ),
              ),
            ]),
            for (var i = 0; i < value.length; i++)
              TableRow(children: [
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                  child: Text(
                    value[i]["TXZ01"],
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(12, defBlack1),
                  ),
                ),
                // Container(
                //   color: defWhite,
                //   padding: EdgeInsets.symmetric(vertical: 4),
                //   child: Text(
                //     value[i]["MENGE"].toString(),
                //     textAlign: TextAlign.center,
                //     style: textStyling.styleText5(12, defBlack1),
                //   ),
                // ),
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    value[i]["MEINS"],
                    textAlign: TextAlign.center,
                    style: textStyling.styleText5(12, defBlack1),
                  ),
                ),
              ]),
          ],
        ),
      ),
    );
    children.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: widget.decCont(defWhite, 20, 20, 20, 20),
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(30),
            1: FixedColumnWidth(80),
            2: FixedColumnWidth(64),
          },
          children: [
            TableRow(children: [
              Container(
                color: defBlue,
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "#",
                  textAlign: TextAlign.center,
                  style: textStyling.styleText5(12, defWhite),
                ),
              ),
              Container(
                color: defBlue,
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "No Doc",
                  textAlign: TextAlign.center,
                  style: textStyling.styleText5(12, defWhite),
                ),
              ),
              Container(
                color: defBlue,
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "No Mobil",
                  textAlign: TextAlign.center,
                  style: textStyling.styleText5(12, defWhite),
                ),
              ),
              Container(
                color: defBlue,
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "Ket",
                  textAlign: TextAlign.center,
                  style: textStyling.styleText5(12, defWhite),
                ),
              ),
              Container(
                color: defBlue,
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "Waktu",
                  textAlign: TextAlign.center,
                  style: textStyling.styleText5(12, defWhite),
                ),
              ),
            ]),
            for (var i = 0; i < val["details"].length; i++)
              TableRow(children: [
                Container(
                  child: IconButton(
                    iconSize: 20,
                    icon: Icon(
                      val["details"][i]["SELECTED"] == "-" || !val["details"][i].containsKey("SELECTED")
                          ? Icons.check_box_outline_blank
                          : Icons.check_box,
                      color: val["details"][i]["SELECTED"] == "-" || !val["details"][i].containsKey("SELECTED")
                          ? Colors.black
                          : Colors.black,
                    ),
                    onPressed: () {
                      if (listSend
                          .where((element) => element["nomer_po"] != val["details"][i]["nomer_po"])
                          .isNotEmpty) {
                        return alert.alertWarning(context: context, text: "Hanya bisa memproses 1 PO");
                      }
                      if (val["details"][i]["SELECTED"] == "-" || !val["details"][i].containsKey("SELECTED")) {
                        val["details"][i].addEntries({"SELECTED": "X"}.entries);
                        val["details"][i].addEntries({"nomer_po": val["nomer_po"]}.entries);
                        listSend.add(val["details"][i]);
                      } else {
                        listSend.removeWhere((element) => element["no_doc"] == val["details"][i]["no_doc"]);
                        val["details"][i].addEntries({"SELECTED": "-"}.entries);
                      }
                      setState(() {});
                    },
                  ),
                ),
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    val["details"][i]["no_doc"].toString(),
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(11, defBlack1),
                  ),
                ),
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                  child: Text(
                    val["details"][i]["no_mobil"].toString(),
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(12, defBlack1),
                  ),
                ),
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                  child: Text(
                    val["details"][i]["keterangan"].toString(),
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(12, defBlack1),
                  ),
                ),
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    val["details"][i]["timestamp"].toString(),
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(12, defBlack1),
                  ),
                ),
              ]),
          ],
        ),
      ),
    );
    return children;
  }

  processRekapCreate(dataDetail, po) async {
    if (listSend.isEmpty) {
      return alert.alertWarning(context: context, text: "Pilih nomor document terlebih dahulu !");
    }

    if (listSend[0]["nomer_po"] != po) {
      return alert.alertWarning(context: context, text: "PO tidak sesuai");
    }

    List idSend = [];
    for (var i = 0; i < listSend.length; i++) {
      idSend.add(listSend[i]["id"]);
    }

    Map objSend = {
      'plant': sloc.text,
      'nomer_po': listSend[0]["nomer_po"],
      'keterangan': 'REKAP',
      // 'detail': tempListHistory[0]["detail"],
      'detail': dataDetail,
      'id': idSend,
    };

    TransaksiService(context: context, objParam: objSend).createRekapService();
  }
}
