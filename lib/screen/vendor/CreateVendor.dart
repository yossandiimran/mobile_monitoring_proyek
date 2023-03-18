// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, avoid_print
part of '../../header.dart';

class CreateVendor extends StatefulWidget {
  const CreateVendor({Key? key}) : super(key: key);
  @override
  CreateVendorState createState() => CreateVendorState();
}

class CreateVendorState extends State<CreateVendor> {
  var serverIdx = "0", jenisVendorIdx = "0", compCodeIdx = "0", purchOrgIdx = "0", kodeBankIdx2 = "0";
  var kodeNegaraIdx = "0", kodeBankIdx = "0", lamaPembayaranIdx = "0", mataUangIdx = "0";

  var serverData, jenisVendorData, compCodeData, purchOrgData;
  var kodeNegaraData, kodeBankData, lamaPembayaranData;

  TextEditingController namaVendor = TextEditingController();
  TextEditingController shortTrem = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController noTelpon = TextEditingController();
  TextEditingController noHp = TextEditingController();
  TextEditingController fax = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController noRek = TextEditingController();
  TextEditingController atasNama = TextEditingController();
  TextEditingController noRek2 = TextEditingController();
  TextEditingController atasNama2 = TextEditingController();
  TextEditingController noKtp = TextEditingController();
  TextEditingController noNpwp = TextEditingController();

  @override
  void initState() {
    getDataService("server");
    getDataService("jenisVendor");
    getDataService("compCode");
    getDataService("purchOrg");
    getDataService("kodeNegara");
    getDataService("kodeBank");
    getDataService("lamaPembayaran");
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
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Server", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: DropdownButton<String>(
                              value: serverIdx,
                              isExpanded: true,
                              items: widget.getItemsDropdown("server", serverData),
                              onChanged: (newValue) async {
                                serverIdx = (int.parse(newValue.toString())).toString();
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Jenis Vendor", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: DropdownButton<String>(
                              value: jenisVendorIdx,
                              isExpanded: true,
                              items: widget.getItemsDropdown("jenisVendor", jenisVendorData),
                              onChanged: (newValue) async {
                                jenisVendorIdx = (int.parse(newValue.toString())).toString();
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Company Code", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: DropdownButton<String>(
                              value: compCodeIdx,
                              isExpanded: true,
                              items: widget.getItemsDropdown("compCode", compCodeData),
                              onChanged: (newValue) async {
                                compCodeIdx = (int.parse(newValue.toString())).toString();
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Purch Org", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: DropdownButton<String>(
                              value: purchOrgIdx,
                              isExpanded: true,
                              items: widget.getItemsDropdown("purchOrg", purchOrgData),
                              onChanged: (newValue) async {
                                purchOrgIdx = (int.parse(newValue.toString())).toString();
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Nama Vendor", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: namaVendor,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Nama Vendor",
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Short Trem", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              controller: shortTrem,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Short Trem",
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Alamat", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              keyboardType: TextInputType.streetAddress,
                              controller: alamat,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Alamat",
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Kode Negara", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: DropdownButton<String>(
                              value: kodeNegaraIdx,
                              isExpanded: true,
                              items: widget.getItemsDropdown("kodeNegara", kodeNegaraData),
                              onChanged: (newValue) async {
                                kodeNegaraIdx = (int.parse(newValue.toString())).toString();
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  No Telpon", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: noTelpon,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "No Telpon",
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  No Hp", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: noHp,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "No Hp",
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Fax", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: fax,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Fax",
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  E-Mail", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "E-Mail",
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Kode Bank", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: DropdownButton<String>(
                              value: kodeBankIdx,
                              isExpanded: true,
                              items: widget.getItemsDropdown("kodeBank", kodeBankData),
                              onChanged: (newValue) async {
                                kodeBankIdx = (int.parse(newValue.toString())).toString();
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  No Rek", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              controller: noRek,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "No Rek",
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Atas Nama", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              controller: atasNama,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Atas Nama",
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Kode Bank 2", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: DropdownButton<String>(
                              value: kodeBankIdx2,
                              isExpanded: true,
                              items: widget.getItemsDropdown("kodeBank", kodeBankData),
                              onChanged: (newValue) async {
                                kodeBankIdx2 = (int.parse(newValue.toString())).toString();
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  No Rek 2", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              controller: noRek2,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "No Rek 2",
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Atas Nama 2", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              controller: atasNama2,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Atas Nama 2",
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Lama Pembayaran", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: DropdownButton<String>(
                              value: lamaPembayaranIdx,
                              isExpanded: true,
                              items: widget.getItemsDropdown("lamaPembayaran", lamaPembayaranData),
                              onChanged: (newValue) async {
                                lamaPembayaranIdx = (int.parse(newValue.toString())).toString();
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  Kurs", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: DropdownButton<String>(
                              value: mataUangIdx,
                              isExpanded: true,
                              items: widget.getItemsDropdown("mataUang", "mataUang"),
                              onChanged: (newValue) async {
                                mataUangIdx = newValue!;
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  No KTP", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              controller: noKtp,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "No KTP",
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text("  No NPWP", textAlign: TextAlign.left),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                            margin: EdgeInsets.only(top: 5),
                            decoration: widget.decCont(Colors.white, 15, 15, 15, 15),
                            width: global.getWidth(context),
                            child: TextFormField(
                              controller: noNpwp,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "No NPWP",
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
                                    pushLanjutkan();
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
                          SizedBox(height: global.getHeight(context) / 2),
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

  getDataService(selection) async {
    var obj;
    if (selection == "server") {
      obj = {"url": "server"};
      serverData = await MasterService(context: context, objParam: obj).getMasterService();
    } else if (selection == "jenisVendor") {
      obj = {"url": "jenis-vendor"};
      jenisVendorData = await MasterService(context: context, objParam: obj).getMasterService();
    } else if (selection == "compCode") {
      obj = {"url": "company"};
      compCodeData = await MasterService(context: context, objParam: obj).getMasterService();
    } else if (selection == "purchOrg") {
      obj = {"url": "purch-org"};
      purchOrgData = await MasterService(context: context, objParam: obj).getMasterService();
    } else if (selection == "kodeNegara") {
      obj = {"url": "negara"};
      kodeNegaraData = await MasterService(context: context, objParam: obj).getMasterService();
    } else if (selection == "kodeBank") {
      obj = {"url": "bank"};
      kodeBankData = await MasterService(context: context, objParam: obj).getMasterService();
    } else if (selection == "lamaPembayaran") {
      obj = {"url": "pembayaran"};
      lamaPembayaranData = await MasterService(context: context, objParam: obj).getMasterService();
    }
    setState(() {});
  }

  pushLanjutkan() {
    if (alamat.text.length > 60) {
      return alert.alertWarning(context: context, text: "Alamat maksimal 60 karakter");
    }
    if (noKtp.text.length > 20) {
      return alert.alertWarning(context: context, text: "No KTP maksimal 20 karakter");
    }
    if (noNpwp.text.length > 20) {
      return alert.alertWarning(context: context, text: "No NPWP maksimal 20 karakter");
    }

    if (serverIdx == "0" ||
        jenisVendorIdx == "0" ||
        compCodeIdx == "0" ||
        purchOrgIdx == "0" ||
        kodeNegaraIdx == "0" ||
        kodeBankIdx == "0" ||
        lamaPembayaranIdx == "0" ||
        mataUangIdx == "0") {
      return alert.alertWarning(context: context, text: "Form Belum Lengkap");
    }

    var objParam = {
      "namaVendor": namaVendor.text,
      "shortTrem": shortTrem.text,
      "alamat": alamat.text,
      "noTelpon": noTelpon.text,
      "noHp": noHp.text,
      "fax": fax.text,
      "email": email.text,
      "noRek": noRek.text,
      "atasNama": atasNama.text,
      "noRek2": noRek2.text,
      "atasNama2": atasNama2.text,
      "noKtp": noKtp.text,
      "noNpwp": noNpwp.text,
      "serverData": serverData[int.parse(serverIdx) - 1],
      "jenisVendorData": jenisVendorData[int.parse(jenisVendorIdx) - 1],
      "compCodeData": compCodeData[int.parse(compCodeIdx) - 1],
      "purchOrgData": purchOrgData[int.parse(purchOrgIdx) - 1],
      "kodeNegaraData": kodeNegaraData[int.parse(kodeNegaraIdx) - 1],
      "kodeBankData": kodeBankData[int.parse(kodeBankIdx) - 1],
      "kodeBankData2": kodeBankData[int.parse(kodeBankIdx2) - 1],
      "lamaPembayaranData": lamaPembayaranData[int.parse(lamaPembayaranIdx) - 1],
      "kurs": mataUangIdx,
    };

    Navigator.pushNamed(context, '/createVendorUpload', arguments: objParam);
  }
}
