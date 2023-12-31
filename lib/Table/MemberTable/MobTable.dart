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
import 'package:s_a_m_s/Crud%20operation/updatePage.dart';
import 'package:s_a_m_s/main.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:unicons/unicons.dart';

class MobTable extends StatefulWidget {
  MobTable({super.key, required this.sw});
  final double sw;

  @override
  State<MobTable> createState() => _MobTableState();
}

class _MobTableState extends State<MobTable> {
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 10.0, sigmaY: 10.0),
                                  child: Container(
                                    height: 200,
                                    width: widget.sw * 0.80,
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
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 4.0),
                                child: SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () => Navigator.of(context).push(
                                        HeroDialogRoute(builder: (context) {
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
                                                BorderRadius.circular(12.0),
                                            side: BorderSide(color: MainShade)),
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
                                    vertical: 10, horizontal: 4.0),
                                child: SizedBox(
                                  width: 120,
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
                                          side: BorderSide(color: MainShade),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
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
                                      'Defaulter',
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
                                            return TableRow(
                                                context: context,
                                                documentsnap: documentSnapshot,
                                                membersclass: membercol,
                                                rowColor: LightShade,
                                                id: documentSnapshot["ID"],
                                                sw: widget.sw,
                                                age: documentSnapshot["Age"],
                                                member: documentSnapshot[
                                                        "First name"] +
                                                    " " +
                                                    documentSnapshot[
                                                        "Last name"],
                                                gender:
                                                    documentSnapshot["Gender"],
                                                package:
                                                    documentSnapshot["Package"],
                                                feestatus: documentSnapshot[
                                                    "Fee Status"],
                                                platform: documentSnapshot[
                                                    "Platform"],
                                                startingDate: documentSnapshot[
                                                    "Start Date"],
                                                contact: documentSnapshot[
                                                    "Phone Number"],
                                                email:
                                                    documentSnapshot["Email"],
                                                address: documentSnapshot[
                                                    "Address"]);
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

class TableRow extends StatelessWidget {
  TableRow({
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
    final jsonpaid = {"Fee Status": "Paid"};
    final jsonunpaid = {"Fee Status": "Unpaid"};
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
