// ignore_for_file: file_names, prefer_const_constructors,, prefer_interpolation_to_compose_strings

part of '../header.dart';

class CustomWidget {
  radiusVal(radius) => Radius.circular(radius);

  appBarTitle({required context, required title, required color, isCenter = true, List<Widget>? action}) {
    return AppBar(
      backgroundColor: color,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: defWhite),
      ),
      centerTitle: isCenter,
      title: Text(
        title,
        style: textStyling.styleText5(global.getWidth(context) / 25, defWhite),
      ),
      actions: action,
    );
  }

  bgAppbar({required context, int hght = 2}) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(top: kToolbarHeight, left: 20, right: 20),
            height: kToolbarHeight * hght,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [defGreen, defGreen, defGreen],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getBottomApp({required context, required action}) {
    return Container(
      width: global.getWidth(context),
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: decorationGradient3Color(Colors.lightBlue, defBlue, 0.0, 0.0, 50.0, 50.0),
      child: ListTile(
        title: Text(
          "Versi " + appVersion + " ©2022 Central Developer",
          textAlign: TextAlign.center,
          style: textStyling.styleText6(14, defWhite),
        ),
        trailing: IconButton(
          onPressed: () {
            if (action == 'pop') Navigator.pop(context);
            if (action == 'logout') alert.alertLogout(context);
          },
          icon: action == 'pop' ? Icon(Icons.arrow_back_ios, color: defWhite) : Icon(Icons.logout, color: Colors.red),
        ),
      ),
    );
  }

  getBottomApp2({required context, required action}) {
    return Container(
      width: global.getWidth(context),
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: decorationGradient3Color(Colors.lightBlue, defBlue, 0.0, 0.0, 50.0, 0.0),
      child: ListTile(
        title: Text(
          "Versi " + appVersion + " ©2023 Central Developer",
          textAlign: TextAlign.center,
          style: textStyling.styleText6(14, defWhite),
        ),
        trailing: IconButton(
          onPressed: () {
            if (action == 'pop') Navigator.pop(context);
            if (action == 'logout') alert.alertLogout(context);
          },
          icon: action == 'pop' ? Icon(Icons.arrow_back_ios, color: defWhite) : Icon(Icons.logout, color: Colors.red),
        ),
      ),
    );
  }

  getChoiceMenuBarcode(context, menuCode, routeName) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            child: AlertDialog(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              content: SizedBox(
                height: global.getWidth(context) / 3,
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        "Pilih menu",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: global.getWidth(context) / 20),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () async {
                            // Navigator.pushNamed(context, '/statusBarcode');
                            global.navigateCheckPermission(context: context, route: '/createRekap', menuCode: menuCode);
                          },
                          child: Container(
                            decoration: widget.decCont2(defBlue, 10, 10, 10, 10),
                            padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                            child: Text("Create Rekap", style: textStyling.styleText6(12, defWhite)),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () async {
                            // Navigator.pushNamed(context, '/statusBarcodeLong');
                            global.navigateCheckPermission(
                                context: context, route: '/laporanRekap', menuCode: menuCode);
                          },
                          child: Container(
                            decoration: widget.decCont2(defOrange, 10, 10, 10, 10),
                            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                            child: Text(" Laporan Rekap ", style: textStyling.styleText6(12, defWhite)),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            onWillPop: () async {
              return true;
            });
      },
    );
  }

  getWidgetMenu2(
      {required context, routeName, title, color, icon, colorIcon, menuCode, image, bgColor = Colors.white}) {
    return GestureDetector(
      onTap: () {
        if (routeName == 'back') {
          Navigator.pop(context);
        } else if (routeName == "/rekapPenerimaan") {
          getChoiceMenuBarcode(context, menuCode, routeName);
        } else {
          global.navigateCheckPermission(context: context, route: routeName, menuCode: menuCode, ttl: title);
        }
      },
      child: Container(
        decoration: decCont2(bgColor, 20, 20, 20, 20),
        margin: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 5),
        height: kToolbarHeight + 30,
        width: global.getWidth(context),
        child: Row(
          children: [
            Container(
              height: kToolbarHeight + 30,
              width: 70,
              decoration: BoxDecoration(
                image: DecorationImage(image: image, fit: BoxFit.contain, scale: 0.5),
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
            Spacer(),
            Text(title, textAlign: TextAlign.center, style: textStyling.nunitoBold(16, colorIcon)),
            Spacer(),
          ],
        ),
      ),
    );
  }

  getWidgetMenu3({required context, routeName, title, color, icon, colorIcon, menuCode}) {
    return GestureDetector(
      onTap: () {
        if (routeName == 'back') {
          Navigator.pop(context);
        } else {
          Navigator.pushNamed(context, routeName);
        }
      },
      child: Container(
        decoration: decCont(defWhite, 20, 20, 20, 20),
        margin: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 5),
        height: kToolbarHeight + 30,
        width: global.getWidth(context),
        child: Row(
          children: [
            Container(
              height: kToolbarHeight + 30,
              width: 70,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Icon(icon, color: defWhite, size: 30),
            ),
            Spacer(),
            Text(title, textAlign: TextAlign.center, style: textStyling.nunitoBold(16, colorIcon)),
            Spacer(),
          ],
        ),
      ),
    );
  }

  decorationContainer1(color, radius) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(radiusVal(radius)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  decorationContainer2(color, radius) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(radiusVal(radius)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  decorationContainerGradient(color1, color2, radius) {
    return BoxDecoration(
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [color1, color2]),
      borderRadius: BorderRadius.all(radiusVal(radius)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  decorationGradient3Color(color1, color2, bl, br, tl, tr) {
    return BoxDecoration(
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [color1, color2]),
      borderRadius: BorderRadius.only(
        bottomLeft: radiusVal(bl),
        topLeft: radiusVal(tl),
        topRight: radiusVal(tr),
        bottomRight: radiusVal(br),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  decorationGradient4Color(color1, color2, color3, bl, br, tl, tr) {
    return BoxDecoration(
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [color1, color2, color3]),
      borderRadius: BorderRadius.only(
        bottomLeft: radiusVal(bl),
        topLeft: radiusVal(tl),
        topRight: radiusVal(tr),
        bottomRight: radiusVal(br),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  decCont(color, double radiusBl, double radiusBr, double radiusTl, double radiusTr) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        bottomLeft: radiusVal(radiusBl),
        bottomRight: radiusVal(radiusBr),
        topLeft: radiusVal(radiusTl),
        topRight: radiusVal(radiusTr),
      ),
    );
  }

  decCont2(color, double radiusBl, double radiusBr, double radiusTl, double radiusTr) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        bottomLeft: radiusVal(radiusBl),
        bottomRight: radiusVal(radiusBr),
        topLeft: radiusVal(radiusTl),
        topRight: radiusVal(radiusTr),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  decCont3(color, double radiusBl, double radiusBr, double radiusTl, double radiusTr) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        bottomLeft: radiusVal(radiusBl),
        bottomRight: radiusVal(radiusBr),
        topLeft: radiusVal(radiusTl),
        topRight: radiusVal(radiusTr),
      ),
      boxShadow: const [
        BoxShadow(
          color: Colors.black,
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 3),
        ),
      ],
    );
  }

  textInputDecoration(name, icon, colors) {
    return InputDecoration(
      prefixIcon: icon != null ? Icon(icon, color: colors) : null,
      labelText: name,
      labelStyle: TextStyle(color: defBlue),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
    );
  }

  textInputDecoration2(name, icon, colors) {
    return InputDecoration(
      prefixIcon: icon != null ? Icon(icon, color: colors) : null,
      hintText: name,
      labelStyle: TextStyle(color: defBlue),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
    );
  }

  getChoicePopUp(context) {
    return {'Logout', 'Pengaturan'}.map((String choice) {
      return PopupMenuItem<String>(
        value: choice,
        child: Row(
          children: [
            Icon(
              choice == "Logout" ? Icons.logout : Icons.settings,
              color: choice == "Logout" ? defRed : defBlue,
            ),
            Text("  $choice")
          ],
        ),
      );
    }).toList();
  }

  getBoxNamed(context) {
    return Container(
      decoration: widget.decCont(defWhite, 20, 20, 20, 20),
      width: global.getWidth(context),
      padding: EdgeInsets.only(top: 20, right: 100, left: 20, bottom: 20),
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Halo,", style: textStyling.nunitoBold(global.getWidth(context) / 21, defBlack1)),
          Text(
            (preference.getData("name") ?? "") + " !",
            style: textStyling.mcLarenBold(global.getWidth(context) / 20, defBlack1),
          ),
          Text(
            preference.getData("email") ?? "",
            style: textStyling.nunitonDef(
              preference.getData("email").length > 20
                  ? global.getWidth(context) / (preference.getData("email").length * 1.3)
                  : global.getWidth(context) / 26,
              defBlack1,
            ),
          ),
        ],
      ),
    );
  }

  getImageBgSugar(context) {
    return Positioned(
      top: kToolbarHeight * 2,
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(left: global.getWidth(context) / 2),
            height: kToolbarHeight * 4,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/ic1bg.png")),
            ),
          )
        ],
      ),
    );
  }

  getItemsDropdown(selection, data) {
    List<DropdownMenuItem<String>> widget = [];
    if (selection == "plant") {
      widget.add(DropdownMenuItem(value: "0", child: Text("Plant/Sloc", style: textStyling.styleText4(13))));
      if (data != null) {
        for (var i = 0; i < data.length; i++) {
          widget.add(
            DropdownMenuItem(
              value: (i + 1).toString(),
              child: Text(data[i], style: textStyling.styleText4(13)),
            ),
          );
        }
      }
    }
    if (selection == 'statusReport') {
      widget.add(DropdownMenuItem(value: "2", child: Text("Semua PO", style: textStyling.styleText4(13))));
      widget.add(DropdownMenuItem(value: "1", child: Text("PO Selesai", style: textStyling.styleText4(13))));
      widget.add(DropdownMenuItem(value: "0", child: Text("PO Berjalan", style: textStyling.styleText4(13))));
    }
    return widget;
  }
}
