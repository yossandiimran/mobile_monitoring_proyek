// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, no_logic_in_create_state, avoid_print, avoid_unnecessary_containers, unnecessary_null_comparison, invalid_use_of_visible_for_testing_member, prefer_interpolation_to_compose_strings, use_build_context_synchronously, unrelated_type_equality_checks
part of '../../header.dart';

class InputPenerimaan extends StatefulWidget {
  final objParam;
  const InputPenerimaan({this.objParam});
  @override
  InputPenerimaanState createState() => InputPenerimaanState(objParam);
}

class InputPenerimaanState extends State<InputPenerimaan> {
  final objParam;
  var plant, dataPo, current, lat, lng, cntNotif = 0, indexDone = 0;
  TextEditingController noMobil = TextEditingController(), keterangan = TextEditingController();
  InputPenerimaanState(this.objParam);
  List<File> imageFileList = [];
  final List<bool> isDone = <bool>[false, true];

  @override
  void initState() {
    plant = objParam["lokasi"];
    dataPo = jsonDecode(objParam["dataPo"]);
    getNotifBadge();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: defWhite,
        extendBodyBehindAppBar: true,
        appBar: widget.appBarTitle(
          context: context,
          title: "Form Penerimaan Barang",
          color: Colors.transparent,
          action: [
            BadgeIconNotif(
              notificationCount: cntNotif,
              iconData: Icons.history,
              onTap: () {
                var obj = {
                  "durasi": objParam["durasi"],
                  "plant": plant,
                  "noPo": dataPo[0]["EBELN"],
                  "barang": dataPo[0]["MATNR"]
                };
                Navigator.pushNamed(context, '/historyPenerimaan', arguments: obj).then((value) => getNotifBadge());
              },
            ),
          ],
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
                  padding: EdgeInsets.only(top: 20),
                  height: global.getHeight(context) - (kToolbarHeight * 1.4),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                    color: Colors.blueGrey.shade50,
                  ),
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            alignment: Alignment.bottomLeft,
                            child: Text("  Informasi :", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            decoration: widget.decCont2(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: Column(children: [
                              ListTile(
                                leading: Icon(Icons.receipt_long_rounded, color: defPurple, size: 40),
                                title: Text("Lokasi   : $plant\nPO          : " + dataPo[0]["EBELN"]),
                              ),
                              Divider(color: defBlack1, thickness: 3),
                              for (var i = 0; i < dataPo.length; i++)
                                ListTile(
                                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                  minLeadingWidth: 4,
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[Icon(Icons.circle, color: Colors.blueGrey, size: 14)],
                                  ),
                                  title: Text(dataPo[i]["TXZ01"]),
                                  subtitle: Text(
                                    "Qty : " + dataPo[i]["MENGE"].toString() + " || Satuan : " + dataPo[i]["MEINS"],
                                  ),
                                ),
                            ]),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Text("  No Mobil :", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            decoration: widget.decCont2(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.characters,
                              controller: noMobil,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "No Mobil",
                                counterText: "",
                              ),
                              maxLength: 10,
                              onFieldSubmitted: (value) {
                                noMobil.text = value.replaceAll(' ', '').toUpperCase();
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Text("  Keterangan :", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            decoration: widget.decCont2(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            height: kToolbarHeight * 3,
                            child: TextFormField(
                              maxLines: 7,
                              controller: keterangan,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Keterangan",
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Wrap(
                              children: [
                                GestureDetector(
                                  onTap: () => getImage(),
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    width: 80,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: defGreen),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.camera_alt, color: defGreen),
                                    ),
                                  ),
                                ),
                                for (var i = 0; i < imageFileList.length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      imageFileList.removeAt(i);
                                      setState(() {});
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      width: 80,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: defGreen),
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        image: DecorationImage(
                                          image: FileImage(imageFileList[i]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            child: Text(
                              "*) Tap Foto Untuk Menghapus",
                              style: TextStyle(
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                            margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                            decoration: widget.decCont2(Colors.white, 15, 15, 15, 15),
                            child: Row(children: [
                              Spacer(),
                              Text("PO SELESAI ? ", style: textStyling.styleText5(14, defBlack1)),
                              SizedBox(width: 20),
                              ToggleButtons(
                                direction: Axis.horizontal,
                                onPressed: (int index) {
                                  setState(() {
                                    for (int i = 0; i < isDone.length; i++) {
                                      isDone[i] = i == index;
                                    }
                                  });
                                },
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                selectedBorderColor: isDone[0] ? defGreen : defRed,
                                selectedColor: defWhite,
                                color: isDone[1] ? defGreen : defRed,
                                fillColor: isDone[0] ? defGreen : defRed,
                                isSelected: isDone,
                                children: [
                                  Icon(Icons.check_circle_outline_rounded),
                                  Icon(Icons.remove_circle_outline_rounded),
                                ],
                              ),
                              Spacer(),
                            ]),
                          ),
                          SizedBox(height: 20),
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
                                    decoration: widget.decCont(defRed, 15, 15, 15, 15),
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
                                  onTap: () => sendService(),
                                  child: Container(
                                    width: global.getWidth(context) / 2.5,
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    margin: EdgeInsets.only(top: 5),
                                    decoration: widget.decCont(defBlue, 15, 15, 15, 15),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Text("Simpan ", style: textStyling.styleText5(14, defWhite)),
                                        Icon(Icons.check_circle_outline, color: defWhite),
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
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Future getImage() async {
    var img = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      maxWidth: 1276,
      maxHeight: 780,
      imageQuality: 80,
    );
    if (img != null) {
      File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(path: img.path);
      imageFileList.add(File(rotatedImage.path));
      setState(() {});
    }
  }

  getNotifBadge() async {
    cntNotif = (await dbHelper.countTransaksi(plant: plant, noPo: dataPo[0]["EBELN"], barang: dataPo[0]["MATNR"]))!;
    setState(() {});
  }

  getKoordinat() async {
    current = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = current == null ? "" : current.latitude.toString();
      lng = current == null ? "" : current.longitude.toString();
    });
  }

  sendService() async {
    if (noMobil.text == "") return alert.alertWarning(context: context, text: "No Mobil belum diisi");
    if (keterangan.text == "") return alert.alertWarning(context: context, text: "Keterangan masih kosong");
    if (imageFileList.length < 2) return alert.alertWarning(context: context, text: "Minimal mengambil 2 foto");

    var nVal = noMobil.text.replaceAll(' ', '');
    noMobil.text = nVal.toUpperCase();

    alert.loadingAlert(context: context, text: "Menyimpan Data ...", isPop: false);
    Map isChecked = await checkInterval();

    Navigator.pop(context);

    if (cntNotif != 0) {
      var obj = {
        "durasi": objParam["durasi"],
        "plant": plant,
        "noPo": dataPo[0]["EBELN"],
        "barang": dataPo[0]["MATNR"]
      };
      Navigator.pushNamed(context, '/historyPenerimaan', arguments: obj).then((value) => getNotifBadge());

      return alert.alertWarning(context: context, text: "Transaksi sebelumnya belum dikirim ke server !");
    }

    if (isChecked["status"]) {
      insertPenerimaanDb();
      alert.alertSuccess(context: context, text: isChecked["message"]);
      noMobil.clear();
      keterangan.clear();
      imageFileList.clear();
      getNotifBadge();
    } else {
      alert.alertWarning(context: context, text: isChecked["message"]);
    }
  }

  void insertPenerimaanDb() async {
    List<String> imgList = [];
    if (imageFileList.isNotEmpty) {
      for (var i = 0; i < imageFileList.length; i++) {
        imgList.add(imageFileList[i].path);
      }
    }

    var checkDone = isDone[0] ? "1" : "0";
    Map<String, dynamic> row = {
      'plant': plant,
      'no_mobil': noMobil.text,
      'no_po': dataPo[0]["EBELN"],
      'detail': jsonEncode(dataPo),
      'foto': jsonEncode(imgList),
      'keterangan': keterangan.text,
      'lat': lat.toString(),
      'lng': lng.toString(),
      'status_kirim': "0",
      'is_done': checkDone,
      'created_at': DateTime.now().toString(),
    };
    TempTransaksiDBModel transaksi = TempTransaksiDBModel.fromMap(row);
    try {
      await dbHelper.insertTransaksi(transaksi);
    } catch (e) {
      alert.alertWarning(context: context, text: "Terjadi kesalahan sistem aplikasi !...");
    }
  }

  Future<Map> checkInterval() async {
    final allRows = await dbHelper.readTransaksiFilter(noMobil: noMobil.text, noPo: dataPo[0]["EBELN"]);
    var data = allRows;
    setState(() {});
    if (data.isEmpty) {
      return {
        "status": true,
        "message": "Berhasil menambahkan laporan, segera mengirim laporan secara online melalui menu histori !"
      };
    } else {
      final DateTime date = DateTime.parse(data[(data.length - 1)]["created_at"]);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(date);
      var textAlert = "Gagal dapat menyimpan data untuk kode kendaraan " + noMobil.text;
      return {"status": difference.inHours >= objParam["durasi"], "message": textAlert};
    }
  }
}
