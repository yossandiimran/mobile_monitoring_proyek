// ignore_for_file: file_names, prefer_const_constructors
part of '../../header.dart';

class HomeVendor extends StatefulWidget {
  const HomeVendor({Key? key}) : super(key: key);
  @override
  HomeVendorState createState() => HomeVendorState();
}

class HomeVendorState extends State<HomeVendor> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: defWhite,
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
                  height: global.getHeight(context),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [defPurple, defPurple2, defPurple2],
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: global.getWidth(context),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back_ios_new_rounded, color: defWhite),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Master Data Vendor",
                              style: textStyling.styleText5(global.getWidth(context) / 20, defWhite),
                            ),
                            Spacer(),
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
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 0),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: widget.decCont(Colors.blueGrey.shade50, 30, 30, 30, 30),
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          widget.getWidgetMenu3(
                            icon: Icons.add_circle_outline_rounded,
                            context: context,
                            routeName: "/createVendor",
                            title: "Create Master Data Vendor",
                            color: defGreen,
                            colorIcon: defBlue,
                          ),
                          widget.getWidgetMenu3(
                            icon: Icons.edit_rounded,
                            context: context,
                            routeName: "/changeVendor",
                            title: "Change Master Data Vendor",
                            color: defBlue,
                            colorIcon: defBlue,
                          ),
                          widget.getWidgetMenu3(
                            icon: Icons.report_gmailerrorred_rounded,
                            context: context,
                            routeName: "/statusVendor",
                            title: "Status Permintaan",
                            color: defOrange,
                            colorIcon: defBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
