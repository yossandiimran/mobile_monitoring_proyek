// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, no_logic_in_create_state, avoid_print, avoid_unnecessary_containers, unnecessary_null_comparison, invalid_use_of_visible_for_testing_member, use_build_context_synchronously, avoid_function_literals_in_foreach_calls, prefer_interpolation_to_compose_strings
part of '../../header.dart';

class MainPenerimaan extends StatefulWidget {
  final objParam;
  const MainPenerimaan({this.objParam});
  @override
  MainPenerimaanState createState() => MainPenerimaanState(objParam);
}

class MainPenerimaanState extends State<MainPenerimaan> {
  final objParam;
  bool isLoading = true;
  List plantData = [], plantDataReal = [];
  var plantIdx = "0", poData = [], poTemp = [], selectedPo;
  var groupedList = {};
  TextEditingController keyword = TextEditingController();
  MainPenerimaanState(this.objParam);
  List<File> imageFileList = [];

  @override
  void initState() {
    getDataService();
    super.initState();
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
          title: objParam["title"].toString(),
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
                  padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                  height: global.getHeight(context) - (kToolbarHeight * 1),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                    color: Colors.blueGrey.shade50,
                  ),
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            "  Plant / Lokasi",
                            textAlign: TextAlign.left,
                            style: textStyling.styleText5(16, defBlack1),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          margin: EdgeInsets.only(top: 5),
                          decoration: widget.decCont2(Colors.white, 15, 15, 15, 15),
                          width: global.getWidth(context),
                          // child: Text(preference.getData("sloc")),
                          child: DropdownButton<String>(
                            value: plantIdx,
                            isExpanded: true,
                            items: widget.getItemsDropdown("plant", plantData),
                            onChanged: (newValue) async {
                              plantIdx = (int.parse(newValue.toString())).toString();
                              setState(() {});
                              poTemp.clear();
                              selectedPo = null;
                              if (newValue.toString() != "0") {
                                alert.loadingAlert(context: context, text: "Mohon Tunggu", isPop: true);
                                await getDataPoService();
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(thickness: 3, color: defBlack1),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text(
                                "  No. PO : ",
                                textAlign: TextAlign.left,
                                style: textStyling.styleText5(16, defBlack1),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                                decoration: widget.decCont2(Colors.white, 15, 15, 15, 15),
                                width: global.getWidth(context) / 2,
                                child: TextFormField(
                                  controller: keyword,
                                  textInputAction: TextInputAction.search,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Cari No Po",
                                  ),
                                  onEditingComplete: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    if (poData.isEmpty) {
                                      alert.alertWarning(context: context, text: "Nomor Po kosong !");
                                    } else {
                                      searchPo(keyword.text);
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  if (poData.isEmpty) {
                                    alert.alertWarning(context: context, text: "Nomor Po kosong !");
                                  } else {
                                    searchPo(keyword.text);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  decoration: widget.decCont2(defOrange, 15, 15, 15, 15),
                                  child: Icon(Icons.search_rounded, color: defWhite),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                          margin: EdgeInsets.only(top: 5),
                          decoration: widget.decCont2(Colors.white, 15, 15, 15, 15),
                          width: global.getWidth(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                            margin: EdgeInsets.symmetric(vertical: 0),
                            width: global.getWidth(context),
                            height: global.getHeight(context) / 1.9,
                            child: SingleChildScrollView(
                              child: Column(
                                children: getChildren(),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: global.getWidth(context),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  width: global.getWidth(context) / 2.5,
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: widget.decCont2(defRed, 15, 15, 15, 15),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Icon(Icons.arrow_back_rounded, color: defWhite),
                                      Text(" Kembali", style: textStyling.styleText5(14, defWhite)),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  sendService();
                                },
                                child: Container(
                                  width: global.getWidth(context) / 2.5,
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  margin: EdgeInsets.only(top: 5),
                                  decoration: widget.decCont2(defBlue, 15, 15, 15, 15),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Text("Lanjutkan ", style: textStyling.styleText5(14, defWhite)),
                                      Icon(Icons.arrow_forward_rounded, color: defWhite),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
    if (poTemp.isEmpty) {
      children.add(Text(
        "\n\n\n\nTidak ada data PO\nPastikan memilih lokasi yang benar !...",
        textAlign: TextAlign.center,
      ));
    } else {
      groupedList.forEach((key, value) {
        children.add(
          Container(
            child: ExpansionTile(
              leading: IconButton(
                icon: Icon(selectedPo == key ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded),
                onPressed: () {
                  setState(() {
                    selectedPo = key;
                  });
                },
              ),
              title: Text(key),
              subtitle: Text("Vendor : " + groupedList[key][0]["NAME1"]),
              children: [
                Table(
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
                          " Nama Barang",
                          textAlign: TextAlign.left,
                          style: textStyling.styleText5(14, defWhite),
                        ),
                      ),
                      Container(
                        color: defBlue,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "Qty",
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
                    for (var i = 0; i < groupedList[key].length; i++)
                      TableRow(children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                          child: Text(groupedList[key][i]["TXZ01"], textAlign: TextAlign.left),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Text(groupedList[key][i]["MENGE"].toString(), textAlign: TextAlign.center),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Text(groupedList[key][i]["MEINS"], textAlign: TextAlign.center),
                        ),
                      ])
                  ],
                )
              ],
            ),
          ),
        );
      });
    }
    return children;
  }

  Future<void> generateSumPo() async {
    groupedList.clear();
    poTemp.forEach((item) {
      String key = item['EBELN'];
      if (groupedList.containsKey(key)) {
        groupedList[key]!.add(item);
      } else {
        groupedList[key] = [item];
      }
    });
  }

  Future<void> searchPo(key) async {
    poTemp = poData.where((element) => (element["EBELN"].toLowerCase().contains(key.toLowerCase()))).toList();
    await generateSumPo();
    setState(() {});
  }

  Future<void> getDataPoService() async {
    Map objParam = {"FUNCTION": "ZCNTNWRFC2_T020A", "PLANT": preference.getData("plant")};
    // Map objParam = {"FUNCTION": "ZCNTNWRFC2_T020A", "PLANT": plantData[(int.parse(plantIdx) - 1)]};
    var rawPos = await SapService(context: context, objParam: objParam).callResponseSap();

    var rawPo = rawPos["T_PO"].where((element) => element["LGORT"] == plantData[(int.parse(plantIdx) - 1)]);
    // if (plantData[(int.parse(plantIdx) - 1)] == '1C46') {
    // rawPo = rawPos["T_PO"].where((element) => element["LGORT"] == plantData[(int.parse(plantIdx) - 1)]);
    // }
    print(rawPo);
    rawPo.toList();
    if (rawPo != []) {
      try {
        if (rawPo != []) {
          List checkAvaliablePo = await LaporanService(
            context: context,
            objParam: {"plant": plantData[(int.parse(plantIdx) - 1)]},
          ).checkAvaliablePo();
          List newPo = rawPo.where((element) => !checkAvaliablePo.contains(element["EBELN"])).toList();
          setState(() {
            poData = newPo;
            poTemp = poData;
          });
          await generateSumPo();
          return global.successResponse(context, "Berhasil Mengambil PO");
        } else {
          return global.errorResponse(context, "Kesalahan Aplikasi : err(101)!");
        }
      } catch (err) {
        print(err);
        return global.errorResponse(context, "Kesalahan Aplikasi : err(100)!");
      }
    }
  }

  Future<void> getDataService() async {
    await Future.delayed(const Duration(microseconds: 500), () {
      alert.loadingAlert(context: context, text: "Loading ...", isPop: false);
    });
    Map objParam = {"FUNCTION": "ZCNTNWRFC2_T019"};
    var rawPlantData = await SapService(context: context, objParam: objParam).callResponseSap();
    if (rawPlantData != null) {
      // preference.getData("plant")
      plantDataReal = rawPlantData["T_PLANT"];
      plantData = jsonDecode(preference.getData("sloc"));
      plantIdx = (plantData.indexWhere((element) => element == preference.getData("plant")) + 1).toString();
      await getDataPoService();
      setState(() {});
      Navigator.pop(context);
    } else {
      global.errorResponse(context, "Lokasi Tidak Ditemukan");
    }
    setState(() {});
  }

  Future<void> sendService() async {
    if (selectedPo == null) {
      return alert.alertWarning(context: context, text: "Silahkan pilih po terlebih dahulu !");
    }

    print(plantDataReal);
    print(plantData);
    print(plantIdx);
    print(plantData[int.parse(plantIdx) - 1]);

    var containsPlant = plantDataReal.where((element) => element["PLANT"] == plantData[int.parse(plantIdx) - 1]).first;
    var objectSend = {
      "dataPo": jsonEncode(groupedList[selectedPo]),
      // "lokasi": plantData[(int.parse(plantIdx) - 1)]["PLANT"],
      "lokasi": groupedList[selectedPo][0]["LGORT"],
      // "durasi": plantData[(int.parse(plantIdx) - 1)]["ZHOURS"],
      "durasi": containsPlant["ZHOURS"],
      "title": objParam["title"],
    };
    Navigator.pushNamed(context, '/inputPenerimaan', arguments: objectSend);
  }
}
