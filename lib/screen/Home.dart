// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_interpolation_to_compose_strings
part of '../header.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getLocation();
    // fbmessaging.initFirebase(
    //   context: context,
    // );
  }

  getLocation() async {
    await Geolocator.isLocationServiceEnabled();
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => alert.alertConfirmExit(context),
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
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
                  height: global.getHeight(context) / 1.5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [defGreen, defGreen, defBlack1],
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: global.getWidth(context),
                        child: Row(
                          children: [
                            Image.asset("assets/icon.png", width: global.getWidth(context) / 7),
                            SizedBox(width: 10),
                            Text(
                              "E-Monitoring Penerimaan Barang",
                              style: textStyling.styleText5(global.getWidth(context) / 25, defWhite),
                            ),
                            Spacer(),
                            PopupMenuButton<String>(
                              icon: Icon(Icons.more_vert_rounded, color: defWhite),
                              onSelected: (value) async {
                                if (value == "Logout") {
                                  alert.alertLogout(context);
                                }
                              },
                              itemBuilder: (BuildContext context) => widget.getChoicePopUp(context),
                            ),
                          ],
                        ),
                      ),
                      widget.getBoxNamed(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.getImageBgSugar(context),
          Positioned(
            top: 0,
            bottom: kToolbarHeight * 3,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Spacer(),
                Container(
                  margin: EdgeInsets.only(top: 0, left: 15, right: 15),
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  decoration: widget.decCont2(defWhite, 30, 30, 30, 30),
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          widget.getWidgetMenu2(
                            context: context,
                            routeName: "/mainPenerimaan",
                            title: "Penerimaan Barang Proyek",
                            color: defOrange,
                            colorIcon: defBlue,
                            menuCode: "inputPenerimaan",
                            image: AssetImage("assets/shipment.png"),
                          ),
                          SizedBox(height: 15),
                          widget.getWidgetMenu2(
                            context: context,
                            routeName: "/laporanPenerimaan",
                            title: "Laporan Penerimaan Barang",
                            color: defRed,
                            colorIcon: defBlue,
                            menuCode: "pelaporanPenerimaan",
                            image: AssetImage("assets/barang.png"),
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
}
