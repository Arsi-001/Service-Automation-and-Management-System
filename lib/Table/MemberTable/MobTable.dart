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
import 'package:s_a_m_s/Table/MemberTable/MemberTable.dart';
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
                                            return
                                      MTableRow(
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

