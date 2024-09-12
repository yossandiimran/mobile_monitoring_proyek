// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, no_logic_in_create_state, avoid_print, avoid_unnecessary_containers, unnecessary_null_comparison, invalid_use_of_visible_for_testing_member, use_build_context_synchronously, prefer_interpolation_to_compose_strings, avoid_function_literals_in_foreach_calls
part of '../../../header.dart';

class LaporanRekap extends StatefulWidget {
  final objParam;
  const LaporanRekap({this.objParam});
  @override
  LaporanRekapState createState() => LaporanRekapState(objParam);
}

class LaporanRekapState extends State<LaporanRekap> {
  final objParam;
  var dataListHistory = [], tempListHistory = [], isLoading = false, groupedList = {};
  var listSend = [];
  TextEditingController cpudt = TextEditingController();
  bool isAll = false;
  var statusIdx = "2";
  TextEditingController sloc = TextEditingController(text: "");
  TextEditingController po = TextEditingController(text: "");
  // TextEditingController po = TextEditingController(text: "4010001961");
  LaporanRekapState(this.objParam);

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
    dataListHistory = await LaporanService(context: context, objParam: objSend).getRekapLaporan();
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
          title: "Laporan GR Rekap Harian",
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
                            padding: EdgeInsets.symmetric(vertical: 21, horizontal: 20),
                            margin: EdgeInsets.only(top: 5, left: 3, right: 3),
                            decoration: widget.decCont2(Colors.white, 10, 10, 10, 10),
                            width: global.getWidth(context) / 3,
                            child: Text("${preference.getData("name")}", style: textStyling.styleText5(12, defBlack1)),
                          ),
                          Spacer(),
                          Container(
                            width: global.getWidth(context) / 2,
                            margin: EdgeInsets.only(top: 5, left: 3, right: 3),
                            decoration: widget.decCont2(Colors.white, 10, 10, 10, 10),
                            child: TextField(
                              controller: po,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                hintText: "Nomor PO",
                              ),
                              readOnly: false,
                            ),
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
                              getHistoryTransaksi();
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
                  height: global.getHeight(context) - (kToolbarHeight * 3.5),
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
          Container(
            margin: EdgeInsets.only(bottom: 8, left: 10, right: 10),
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: widget.decCont(defWhite, 20, 20, 20, 20),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "Nomor Laporan : " + tempListHistory[i]["nomer_laporan"].toString(),
                    style: textStyling.styleText5(global.getWidth(context) / 30, defBlack1),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      downloadPdfAction(tempListHistory[i]);
                    },
                    child: Container(
                      width: global.getWidth(context) / 3,
                      padding: EdgeInsets.all(10),
                      decoration: widget.decCont2(defRed, 10, 10, 10, 10),
                      child: Row(
                        children: [
                          Spacer(),
                          Text("Download PDF", style: textStyling.styleText5(global.getWidth(context) / 35, defWhite)),
                          Spacer(),
                          Icon(
                            Icons.download,
                            color: defWhite,
                            size: global.getWidth(context) / 30,
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: getSubChildren(tempListHistory[i]),
                ),
                Divider(),
              ],
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
                color: defGrey,
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                child: Text(
                  "Nama Barang",
                  textAlign: TextAlign.left,
                  style: textStyling.styleText5(12, defWhite),
                ),
              ),
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
    children.add(Divider());
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
                  "No",
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
                  padding: EdgeInsets.only(top: 3),
                  alignment: Alignment.center,
                  child: Text((i + 1).toString()),
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
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    val["details"][i]["no_mobil"].toString(),
                    textAlign: TextAlign.left,
                    style: textStyling.styleText5(12, defBlack1),
                  ),
                ),
                Container(
                  color: defWhite,
                  padding: EdgeInsets.symmetric(vertical: 4),
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

  downloadPdfAction(dataSelected) async {
    print(dataSelected);
    // Buat instance dari Document
    final pdf = pw.Document();

    // Tambahkan halaman ke PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Container(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Column(children: [
                  pw.Divider(),
                  pw.Text(
                    "Laporan GR Rekap Harian",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
                  ),
                  pw.Text(
                    "Aplikasi GR Proyek",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
                  ),
                ]),
              ),
              pw.Divider(),
              pw.SizedBox(height: 3),
              pw.Row(children: [
                pw.Text(
                  "Nomor PO : ${dataSelected["nomer_po"]}",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 8),
                ),
                pw.Spacer(),
                pw.Text(
                  "Nomor Laporan : ${dataSelected["nomer_laporan"]}",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 8),
                ),
              ]),
              pw.Row(children: [
                pw.Text(
                  "Plant Sloc  : ${dataSelected["plant"]}",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 8),
                ),
                pw.Spacer(),
                pw.Text(
                  "Tanggal : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(dataSelected["created_at"]))}",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 8),
                ),
              ]),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(width: 1),
                children: [
                  pw.TableRow(children: [
                    pw.Container(
                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Text(
                        "No",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                      child: pw.Text(
                        "Deskripsi",
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Text(
                        "Satuan",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                  ]),
                  for (var i = 0; i < dataSelected["detail"].length; i++)
                    pw.TableRow(
                      children: [
                        pw.Container(
                          padding: pw.EdgeInsets.only(top: 3),
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            (i + 1).toString(),
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                          child: pw.Text(
                            dataSelected["detail"][i]["TXZ01"].toString(),
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                          child: pw.Text(
                            dataSelected["detail"][i]["MEINS"].toString(),
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(width: 1),
                children: [
                  pw.TableRow(children: [
                    pw.Container(
                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Text(
                        "No",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Text(
                        "No Doc",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Text(
                        "No Mobil",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Text(
                        "Ket",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Text(
                        "Tgl Penerimaan Barang",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(fontSize: 8),
                      ),
                    ),
                  ]),
                  for (var i = 0; i < dataSelected["details"].length; i++)
                    pw.TableRow(
                      children: [
                        pw.Container(
                          padding: pw.EdgeInsets.only(top: 3),
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            (i + 1).toString(),
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                          child: pw.Text(
                            dataSelected["details"][i]["no_doc"].toString(),
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                          child: pw.Text(
                            dataSelected["details"][i]["no_mobil"].toString(),
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                          child: pw.Text(
                            dataSelected["details"][i]["keterangan"].toString(),
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ),
                        pw.Container(
                          padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                          child: pw.Text(
                            dataSelected["details"][i]["timestamp"].toString(),
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(fontSize: 8),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              pw.SizedBox(height: 30),
              pw.Row(children: [
                pw.Text(
                  "   Pemeriksa Barang",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 8),
                ),
                pw.Spacer(),
                pw.Text(
                  "Penerima Barang       ",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 8),
                ),
              ]),
              pw.SizedBox(height: 80),
              pw.Row(children: [
                pw.Text(
                  "(....................................)",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 8),
                ),
                pw.Spacer(),
                pw.Text(
                  "(....................................)",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 8),
                ),
              ]),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.Text(
                "NOTE : ",
                textAlign: pw.TextAlign.left,
                style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold, fontStyle: pw.FontStyle.italic),
              ),
              pw.Row(children: [
                pw.Text(
                  "Pemeriksa Barang :",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic),
                ),
                pw.Text(
                  "di isi dengan ttd penerima barang secara system SAP, admin / pic gudang bahan baku.",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic),
                ),
              ]),
              pw.Row(children: [
                pw.Text(
                  "Penerima Barang :",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic),
                ),
                pw.Text(
                  "di isi dengan ttd penerima barang secara fisik, pic lapangan yang menginput transaski di aplikasi.",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 8, fontStyle: pw.FontStyle.italic),
                ),
              ]),
            ],
          ),
        ),
      ),
    );

    // Simpan PDF ke perangkat

    if (await Permission.storage.request().isGranted) {
      Directory? downloadDir = Directory('/storage/emulated/0/Download');
      File file = File('${downloadDir.path}/GR-Laporan-${dataSelected["nomer_laporan"]}.pdf');
      await file.writeAsBytes(await pdf.save());
      print('PDF Saved: ${file.path}');
      alert.alertSuccess(
        context: context,
        text: "File Berhasil Di download\nGR-Laporan-${dataSelected["nomer_laporan"]}.pdf",
      );
    } else {
      if (await Permission.storage.request().isGranted) {
        print('Izin akses penyimpanan diberikan.');
      } else {
        print('Izin akses penyimpanan ditolak.');
      }
    }
  }

  Future<void> saveFileToDownloads(String fileName, File fileData) async {}

  processRekapCreate() async {
    print(listSend);
    if (listSend.isEmpty) {
      return alert.alertWarning(context: context, text: "Pilih nomor document terlebih dahulu !");
    }
    List idSend = [];
    for (var i = 0; i < listSend.length; i++) {
      idSend.add(listSend[i]["id"]);
    }

    Map objSend = {
      'plant': sloc.text,
      'nomer_po': po.text,
      'keterangan': 'REKAP',
      'detail': tempListHistory[0]["detail"],
      'id': idSend,
    };
  }
}
