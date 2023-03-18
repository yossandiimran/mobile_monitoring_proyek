// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, no_logic_in_create_state, avoid_print, avoid_unnecessary_containers, unnecessary_null_comparison, invalid_use_of_visible_for_testing_member
part of '../../header.dart';

class CreateVendorUploadFile extends StatefulWidget {
  final objParam;
  const CreateVendorUploadFile(this.objParam);
  @override
  CreateVendorUploadFileState createState() => CreateVendorUploadFileState(objParam);
}

class CreateVendorUploadFileState extends State<CreateVendorUploadFile> {
  final objParam;
  CreateVendorUploadFileState(this.objParam);
  List<File> imageFileList = [];

  @override
  void initState() {
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
        appBar: widget.appBarTitle(context, "Create Master Data Vendor", Colors.transparent),
        body: Stack(children: [
          widget.bgAppbar(context),
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
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Wrap(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    getImage();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    width: 80,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: defPurple),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.camera_alt, color: defPurple),
                                    ),
                                  ),
                                ),
                                for (var i = 0; i < imageFileList.length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      imageFileList.removeAt(i);
                                      setState(() {});
                                      print(imageFileList.length);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      width: 80,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: defPurple),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
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
                          SizedBox(height: 20),
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
                                  onTap: () async {
                                    sendService();
                                  },
                                  child: Container(
                                    width: global.getWidth(context) / 2.5,
                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    margin: EdgeInsets.only(top: 5),
                                    decoration: widget.decCont(defGreen, 15, 15, 15, 15),
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
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 100,
    );
    if (img != null) {
      File rotatedImage = await FlutterExifRotation.rotateAndSaveImage(path: img.path);
      imageFileList.add(File(rotatedImage.path));
      setState(() {});
      print(imageFileList.length);
    }
  }

  sendService() async {
    if (imageFileList.isEmpty) return alert.alertWarning(context: context, text: "Belum ada foto yang diambil");
    var objectSend = {"page1": jsonEncode(objParam), "image": imageFileList};
    await VendorService(context: context, objParam: objectSend).createVendorService();
  }
}
