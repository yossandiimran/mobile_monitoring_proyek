// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, no_logic_in_create_state, avoid_print, avoid_unnecessary_containers, unnecessary_null_comparison, invalid_use_of_visible_for_testing_member
part of '../../header.dart';

class StatusVendor extends StatefulWidget {
  final objParam;
  const StatusVendor(this.objParam);
  @override
  StatusVendorState createState() => StatusVendorState(objParam);
}

class StatusVendorState extends State<StatusVendor> {
  bool isLoading = true;
  var statusData;
  final objParam;
  StatusVendorState(this.objParam);

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
        appBar: widget.appBarTitle(context, "Status Permintaan", Colors.transparent),
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
                  padding: EdgeInsets.only(top: 10),
                  height: global.getHeight(context) - (kToolbarHeight * 1.4),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                    color: Colors.blueGrey.shade50,
                  ),
                  child: !isLoading
                      ? ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(overscroll: false),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                for (var i = 0; i < statusData.length; i++)
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                                    decoration: widget.decCont2(defWhite, 15, 15, 15, 15),
                                    child: Container(
                                      child: Table(
                                        columnWidths: const <int, TableColumnWidth>{
                                          0: IntrinsicColumnWidth(),
                                          1: FixedColumnWidth(30),
                                          2: FlexColumnWidth(),
                                        },
                                        children: [
                                          TableRow(
                                            children: <Widget>[
                                              getTableCell("Nama Vendor", 2),
                                              getTableCell(":", 2),
                                              getTableCell(statusData[i]["nama_vendor"], 1),
                                            ],
                                          ),
                                          TableRow(
                                            children: <Widget>[
                                              getTableCell("Kode Vendor", 2),
                                              getTableCell(":", 2),
                                              getTableCell(statusData[i]["kode_vendor"], 1),
                                            ],
                                          ),
                                          TableRow(
                                            children: <Widget>[
                                              getTableCell("No Rekening", 2),
                                              getTableCell(":", 2),
                                              getTableCell(statusData[i]["no_rekening_1"], 1),
                                            ],
                                          ),
                                          TableRow(
                                            children: <Widget>[
                                              getTableCell("Kode Bank", 2),
                                              getTableCell(":", 2),
                                              getTableCell(statusData[i]["kode_bank_1"], 1),
                                            ],
                                          ),
                                          TableRow(
                                            children: <Widget>[
                                              getTableCell("Atas Nama", 2),
                                              getTableCell(":", 2),
                                              getTableCell(statusData[i]["atas_nama_1"], 1),
                                            ],
                                          ),
                                          TableRow(
                                            children: <Widget>[
                                              getTableCell("Status", 2),
                                              getTableCell(":", 2),
                                              TableCell(
                                                child: Row(children: [
                                                  getIconStatus(statusData[i]["status"]),
                                                  getTextStatus(statusData[i]["status"]),
                                                ]),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        )
                      : Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  getIconStatus(status) {
    if (status == 1) {
      return Icon(Icons.access_time_rounded, color: defOrange);
    } else if (status == 2) {
      return Icon(Icons.check_circle_outline_rounded, color: defGreen);
    } else if (status == 3) {
      return Icon(Icons.remove_circle_outline_rounded, color: defRed);
    }
  }

  getTextStatus(status) {
    if (status == 1) {
      return Text(" Dalam Pengecekan", style: textStyling.styleText5(14, defOrange));
    } else if (status == 2) {
      return Text(" Disetujui", style: textStyling.styleText5(14, defGreen));
    } else if (status == 3) {
      return Text(" Ditolak", style: textStyling.styleText5(14, defRed));
    }
  }

  getTableCell(title, style) {
    return TableCell(
      child: Text(
        "  $title",
        textAlign: TextAlign.left,
        style: style == 1 ? textStyling.nunitoBold(16, defBlack1) : textStyling.styleText6(16, defBlack1),
      ),
    );
  }

  getDataService() async {
    statusData = await VendorService(context: context).getStatusVendor();
    if (statusData != "err") setState(() => isLoading = false);
  }
}
