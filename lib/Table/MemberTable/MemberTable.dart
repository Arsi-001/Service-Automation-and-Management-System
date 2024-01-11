import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:s_a_m_s/Crud%20operation/Addpage.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/Responsive.dart';
import 'package:s_a_m_s/SharedComponent.dart';
import 'package:s_a_m_s/Crud%20operation/popUp/crudpopup.dart';
import 'package:s_a_m_s/Crud%20operation/popUp/pop_dialog.dart';
import 'package:s_a_m_s/Crud%20operation/UpdatePage.dart';
import 'package:s_a_m_s/Table/MemberTable/MobTable.dart';
import 'package:s_a_m_s/Table/MemberTable/TabTable.dart';
import 'package:s_a_m_s/main.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:unicons/unicons.dart';

class TableInfo extends StatelessWidget {
  TableInfo({super.key});

  ScrollController con = ScrollController();

  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;

    return ResponsiveLayout(
      Desktop: DeskTable(
        sw: sw,
      ),
      Tablet: TabTable(sw: sw),
      Mobile: MobTable(sw: sw),
    );
  }
}

class DeskTable extends StatefulWidget {
  DeskTable({super.key, required this.sw});
  final double sw;

  @override
  State<DeskTable> createState() => _DeskTableState();
}

class _DeskTableState extends State<DeskTable> {
  ScrollController con = ScrollController();

  bool isdefaulter = false;
  String result = "";
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();

  @override
  Widget build(BuildContext context) {
    print("THIS IS THE COLLECTION: " + "$membercol");
    return SizedBox(
      height: 1080 - 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: StreamBuilder(
            stream: isdefaulter
                ? membercol.where("Defaulter", isEqualTo: true).snapshots()
                : membercol.orderBy("idnum", descending: false).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 1400,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 10.0, sigmaY: 10.0),
                                  child: Container(
                                    height: 200,
                                    width: 350,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                    26, 104, 104, 104)
                                                .withAlpha(80)),
                                        borderRadius: BorderRadius.circular(16),
                                        gradient: darkGlassMorphismGradient()),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          UniconsLine.dumbbell,
                                          size: 60,
                                          color: Colors.white70,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          (streamSnapshot.data?.docs.length)
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w200,
                                              color: Colors.white70,
                                              letterSpacing: 5,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "MEMBERS",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white70,
                                              letterSpacing: 5,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: widget.sw < 930 ? 0 : 1,
                                  child: SizedBox()),
                              Expanded(
                                flex: widget.sw < 1090 ? 5 : 2,
                                child: SizedBox(
                                  height: 100,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Container(
                                          width: 150,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).push(
                                                    HeroDialogRoute(
                                                        builder: (context) {
                                              return AddUser(
                                                mode: "Members",
                                                modeletter: "M",
                                                colref: membercol,
                                              );
                                            })),
                                            // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    side: BorderSide(
                                                        color: MainShade)),
                                                backgroundColor: MainShade,
                                                elevation: 12.0,
                                                textStyle: const TextStyle(
                                                    color: Colors.white)),
                                            child: const Text(
                                              'Add Member',
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Container(
                                          width: 200,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                isdefaulter
                                                    ? isdefaulter = false
                                                    : isdefaulter = true;
                                              });

                                              // if (isdefaulter == false) {
                                              //   isdefaulter = true;
                                              // } else {
                                              //   isdefaulter = false;
                                              // }
                                            },
                                            // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: MainShade),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  // side: BorderSide(
                                                  //     color:
                                                  //         Colors.blueAccent)
                                                ),
                                                backgroundColor: isdefaulter
                                                    ? Colors.red
                                                    : MainShade,
                                                elevation: 12.0,
                                                textStyle: const TextStyle(
                                                    color: Colors.white)),
                                            child: const Text(
                                              'Defaulter Table',
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //   flex: 2,
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.symmetric(
                                      //         horizontal: 8.0),
                                      //     child: RoundedFuncButton(
                                      //       func: null,
                                      //       buttTxt: "SEARCH MEMBER",
                                      //       buttTxtcol: Colors.white,
                                      //       buttbordercol: Blu,
                                      //       buttcol: lightBlu,
                                      //       buttfont: widget.sw < 630
                                      //           ? widget.sw < 300
                                      //               ? 8
                                      //               : 10
                                      //           : Dtxt,
                                      //       buttheight: DbuttonH,
                                      //       butticon: null,
                                      //       iconhere: false,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RawScrollbar(
                            thickness: 10,
                            thumbColor: MainShade,
                            trackColor: Colors.white12,
                            trackBorderColor: Colors.white30,
                            thumbVisibility: true,
                            trackVisibility: true,
                            controller: con,
                            child: SingleChildScrollView(
                              controller: con,
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                height: 500,
                                width: 1400,
                                decoration: BoxDecoration(
                                    color: LightShade,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Column(
                                  children: [
                                    TableHeaderRow(
                                      sw: widget.sw,
                                      rowColor: Colors.white10,
                                    ),
                                    Container(
                                        height: 400,
                                        child: ListView.builder(
                                          itemCount: streamSnapshot.data!.docs
                                              .length, //number of rows
                                          itemBuilder: (context, index) {
                                            final DocumentSnapshot
                                                documentSnapshot =
                                                streamSnapshot
                                                    .data!.docs[index];
                                            return MTableRow(
                                                context: context,
                                                documentsnap: documentSnapshot,
                                                membersclass: membercol,
                                                rowColor: LightShade,
                                                id: documentSnapshot["id"],
                                                sw: widget.sw,
                                                age: documentSnapshot["age"],
                                                member: documentSnapshot[
                                                        "firstName"] +
                                                    " " +
                                                    documentSnapshot[
                                                        "lastName"],
                                                gender:
                                                    documentSnapshot["gender"],
                                                package:
                                                    documentSnapshot["package"],
                                                feestatus: documentSnapshot[
                                                    "feeStatus"],
                                                platform: documentSnapshot[
                                                    "platform"],
                                                startingDate: documentSnapshot[
                                                    "startDate"],
                                                contact: documentSnapshot[
                                                    "phoneNumber"],
                                                email:
                                                    documentSnapshot["email"],
                                                address: documentSnapshot[
                                                    "address"]);
                                          },
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                );
              } else {
                return const ProgressBar();
              }
            }),
      ),
    );
  }
}

class TableHeaderRow extends StatelessWidget {
  const TableHeaderRow({
    super.key,
    required this.rowColor,
    required this.sw,
  });
  final rowColor, sw;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sw < 630 ? 40 : 60,
      decoration: BoxDecoration(
          color: rowColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(0))),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: const TableCell(
                LineTru: false,
                Titlecolor: Colors.white70,
                Title: "ID",
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              //  padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const TableCell(
                LineTru: false,
                Titlecolor: Colors.white70,
                Title: "MEMBER",
              ),
            ),
          ),
          const Expanded(
            flex: 2,
            child: TableCell(
              LineTru: false,
              Titlecolor: Colors.white70,
              Title: "GENDER",
            ),
          ),
          const Expanded(
            flex: 2,
            child: TableCell(
              LineTru: false,
              Titlecolor: Colors.white70,
              Title: "AGE",
            ),
          ),
          const Expanded(
            flex: 3,
            child: TableCell(
              LineTru: false,
              Titlecolor: Colors.white70,
              Title: "PACKAGE",
            ),
          ),
          const Expanded(
            flex: 2,
            child: TableCell(
              LineTru: false,
              Titlecolor: Colors.white70,
              Title: "FEE",
            ),
          ),
          const Expanded(
            flex: 3,
            child: TableCell(
              LineTru: false,
              Titlecolor: Colors.white70,
              Title: "PLATFORM",
            ),
          ),
          const Expanded(
            flex: 3,
            child: TableCell(
              LineTru: false,
              Titlecolor: Colors.white70,
              Title: "NUMBER",
            ),
          ),
          const Expanded(
            flex: 3,
            child: TableCell(
              LineTru: false,
              Titlecolor: Colors.white70,
              Title: "EMAIL",
            ),
          ),
          const Expanded(
            flex: 2,
            child: TableCell(
              LineTru: false,
              Titlecolor: Colors.white70,
              Title: "JOINING",
            ),
          ),
          const Expanded(
            flex: 4,
            child: TableCell(
              LineTru: false,
              Titlecolor: Colors.white70,
              Title: "ADDRESS",
            ),
          ),
          const Expanded(
            flex: 3,
            child: TableCell(
              LineTru: false,
              Titlecolor: Colors.white70,
              Title: "ACTION",
            ),
          ),
        ],
      ),
    );
  }
}

class MTableRow extends StatelessWidget {
  MTableRow({
    super.key,
    required this.rowColor,
    required this.id,
    required this.member,
    required this.gender,
    required this.package,
    required this.feestatus,
    required this.platform,
    required this.startingDate,
    required this.contact,
    required this.email,
    required this.sw,
    required this.address,
    required this.documentsnap,
    required this.context,
    required this.membersclass,
    required this.age,
  });
  final rowColor,
      id,
      sw,
      member,
      gender,
      package,
      feestatus,
      platform,
      startingDate,
      contact,
      email,
      context,
      documentsnap,
      membersclass,
      address,
      age;
  TextEditingController _nameController = TextEditingController();

  Future<void> _delete([String? documentSnapshotid]) async {
    await membersclass.doc(documentSnapshotid).delete();
    try {
      await activitycol.doc(documentSnapshotid).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _feestatus([String? documentSnapshotid, String? status]) async {
    final jsonpaid = {"feeStatus": "Paid"};
    final jsonunpaid = {"feeStatus": "Unpaid"};
    await membersclass
        .doc(documentSnapshotid)
        .update(status == "Paid" ? jsonunpaid : jsonpaid);
    try {
      await activitycol
          .doc(documentSnapshotid)
          .update(status == "Paid" ? jsonunpaid : jsonpaid);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border:
            const Border(bottom: BorderSide(color: Colors.white24, width: 0.5)),
        color: rowColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              decoration: const BoxDecoration(
                  color: MainShade,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(10))),
              child: Center(
                child: TableCell(
                  LineTru: false,
                  Titlecolor: Colors.white,
                  Title: id,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              // padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TableCell(
                LineTru: true,
                Titlecolor: Colors.white70,
                Title: member,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: gender,
            ),
          ),
          Expanded(
            flex: 2,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: age,
            ),
          ),
          Expanded(
            flex: 3,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: package,
            ),
          ),
          Expanded(
            flex: 2,
            child: TableCell(
              LineTru: true,
              Titlecolor: feestatus == "Paid" ? Colors.green : Colors.red,
              Title: feestatus,
            ),
          ),
          Expanded(
            flex: 3,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: platform,
            ),
          ),
          Expanded(
            flex: 3,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: contact,
            ),
          ),
          Expanded(
            flex: 3,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: email,
            ),
          ),
          Expanded(
            flex: 2,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: startingDate,
            ),
          ),
          Expanded(
            flex: 4,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: address,
            ),
          ),
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => _feestatus(documentsnap.id, feestatus),
                    icon: Icon(
                      UniconsLine.dollar_sign_alt,
                      color: feestatus == "Paid" ? Colors.green : MainShade,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context)
                        .push(HeroDialogRoute(builder: (context) {
                      return UpdateUser(
                        docsnap: documentsnap,
                        Mode:"M"
                      );
                    })),
                    icon: Icon(
                      UniconsLine.edit,
                      color: Colors.white70,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _delete(documentsnap.id),
                    icon: Icon(
                      UniconsLine.trash,
                      color: Colors.red,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class TableCell extends StatelessWidget {
  const TableCell({
    super.key,
    required this.Titlecolor,
    required this.Title,
    required this.LineTru,
  });
  final Title, Titlecolor, LineTru;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: LineTru
              ? const Border(right: BorderSide(color: Colors.white30))
              : null),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          Title,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: Titlecolor,
              overflow: TextOverflow.fade,
              fontSize: 12),
        ),
      ),
    );
  }
}
