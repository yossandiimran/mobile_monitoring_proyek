// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, no_logic_in_create_state, avoid_print, avoid_unnecessary_containers, unnecessary_null_comparison, invalid_use_of_visible_for_testing_member, prefer_interpolation_to_compose_strings, use_build_context_synchronously, unrelated_type_equality_checks
part of '../../header.dart';

class CancelTransaksi extends StatefulWidget {
  final objParam;
  const CancelTransaksi({this.objParam});
  @override
  CancelTransaksiState createState() => CancelTransaksiState(objParam);
}

class CancelTransaksiState extends State<CancelTransaksi> {
  final objParam;
  bool isLoadImage = false;
  var plant, dataPo, current, lat, lng, cntNotif = 0, indexDone = 0;
  TextEditingController noDoc = TextEditingController(), keterangan = TextEditingController();
  CancelTransaksiState(this.objParam);
  DateFormat dateFormat = DateFormat('ddMMyy');
  List<File> imageFileList = [];
  final List<bool> isDone = <bool>[false, true];

  @override
  void initState() {
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
          title: "Form Pembatalan Tranasksi",
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
                  padding: EdgeInsets.only(top: 20),
                  height: global.getHeight(context) - (kToolbarHeight * 1),
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
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Text("  Nomor Document :", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            decoration: widget.decCont2(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.characters,
                              controller: noDoc,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Nomor Document",
                                counterText: "",
                              ),
                              maxLength: 12,
                              onFieldSubmitted: (value) {
                                noDoc.text = value.replaceAll(' ', '').toUpperCase();
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
                          SizedBox(height: 20),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Text("  Foto Memo :", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Wrap(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isLoadImage = true;
                                    });
                                    getImage();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    width: 80,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: defGreen),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: isLoadImage
                                          ? CircularProgressIndicator(color: defGreen)
                                          : Icon(Icons.camera_alt, color: defGreen),
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
                                          image: FileImage(File(imageFileList[i].path)),
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
                                    decoration: widget.decCont(defOrange, 15, 15, 15, 15),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Text("Batalkan ", style: textStyling.styleText5(14, defWhite)),
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
      maxWidth: 1280,
      maxHeight: 720,
      imageQuality: 80,
    );
    if (img != null) {
      File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(path: img.path);
      imageFileList.add(rotatedImage);
      isLoadImage = false;
      setState(() {});
    }
  }

  sendService() async {
    if (noDoc.text == "") return alert.alertWarning(context: context, text: "No PO belum diisi");
    if (keterangan.text == "") return alert.alertWarning(context: context, text: "Keterangan masih kosong");
    if (imageFileList.isEmpty) return alert.alertWarning(context: context, text: "Harap Ambil Foto Memo");

    alert.loadingAlert(context: context, text: "Menyimpan Data ...", isPop: false);

    Map objParam = {"no_doc": noDoc.text, "keterangan": keterangan.text};

    print(objParam);

    var res = await TransaksiService(context: context, objParam: objParam).reverseTransaction();

    if (res != null) {
      Navigator.pop(context);
      global.successResponsePop(context, "Transaksi Berhasil dibatalkan");
    }
  }
}
