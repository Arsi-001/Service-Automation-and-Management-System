import 'dart:js_interop';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/Crud%20operation/AssignLocker.dart';
import 'package:s_a_m_s/Crud%20operation/popUp/pop_dialog.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:unicons/unicons.dart';
import 'package:rxdart/rxdart.dart';

class RoundedFuncButton extends StatelessWidget {
  const RoundedFuncButton({
    super.key,
    required this.buttcol,
    required this.buttbordercol,
    required this.buttTxt,
    required this.buttTxtcol,
    required this.butticon,
    required this.buttfont,
    required this.buttheight,
    required this.iconhere,
    required this.func,
  });

  final func,
      iconhere,
      buttcol,
      buttbordercol,
      buttfont,
      buttheight,
      butticon,
      buttTxt,
      buttTxtcol;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => func(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: buttbordercol, width: 2),
            color: buttcol,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: buttheight,
        child: Row(
          children: [
            iconhere
                ? Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      butticon,
                      color: Colors.white70,
                    ),
                  )
                : SizedBox(
                    width: 0,
                  ),
            Expanded(
              child: Center(
                child: Text(
                  buttTxt,
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                      fontSize: buttfont),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Activity_Info extends StatelessWidget {
  const Activity_Info({
    required this.sh,
    required this.Sw,
    super.key,
  });
  final sh, Sw;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 700,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
          decoration: BoxDecoration(
              color: LightShade,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: Sw < 400 ? 30 : 50,
          child:
              TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
            return Row(
              children: [
                Text(
                  "${DateFormat.EEEE().format(DateTime.now())}".toUpperCase(),
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16),
                ),
                Spacer(),
                Text(
                  "${DateFormat.MMMM().format(DateTime.now())}".toUpperCase() +
                      "  " +
                      "${DateFormat.d().format(DateTime.now())}",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                Spacer(),
                Text(
                  "${DateFormat.Hms().format(DateTime.now())}".toUpperCase(),
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16),
                )
              ],
            );
          }),
        ),
        SizedBox(
          height: 12,
        ),
        Expanded(
          child: StreamBuilder(
              stream: activitycol.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return Container(
                    width: 700,
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                    decoration: BoxDecoration(
                      color: LightShade,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Sw < 630 ? 0 : 30)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Text(
                                  "ACTIVITY TRACKER",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white70,
                                      fontSize: Dtxt + 4),
                                )),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: MainShade,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text(
                                    "Attendance: " +
                                        (streamSnapshot.data?.docs.length)
                                            .toString(),
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        // fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
                              child: ElevatedButton(
                                onPressed: () => Navigator.of(context)
                                    .push(HeroDialogRoute(builder: (context) {
                                  return LockerPopUp(
                                    memberid: "DDD",
                                  );
                                })),
                                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: Colors.white,
                                  elevation: 12.0,
                                ),
                                child: const Text(
                                  'Check in',
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 1,
                              color: Color.fromARGB(58, 128, 128, 128),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                              itemCount: streamSnapshot.data?.docs.length,
                              itemBuilder: (context, i) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[i];
                                return DeskActivityProfileBubble(
                                  mode: "M",
                                  locker: "",
                                  id: documentSnapshot.id,
                                  name: documentSnapshot["Name"],
                                  feestatus: documentSnapshot["Fee Status"],
                                  package: documentSnapshot["Package"],
                                  platform: documentSnapshot["Platform"],
                                  defaulters: documentSnapshot["Defaulter"],
                                  timein:
                                      documentSnapshot["Time In"].toString(),
                                  sw: Sw,
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ],
    );
  }
}

class Main_Info extends StatelessWidget {
  const Main_Info({
    required this.Sw,
    required this.Sh,
    super.key,
  });
  final double Sw, Sh;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 300,
                height: 300,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                decoration: const BoxDecoration(
                    gradient: glassmorphGreen,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      UniconsLine.dumbbell,
                      size: 140,
                      // size: Sw < 630
                      //     ? Sw < 400
                      //         ? 50
                      //         : 100
                      //     : 150,
                      color: DarkShade,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "PLATFORM",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w200,
                          color: DarkShade,
                          letterSpacing: 5,
                          fontSize: 16
                          // Sw > 1800
                          //     ? 16
                          //     : Sw < 400
                          //         ? Dtxt - 4
                          //         : Dtxt
                          ),
                    ),
                    Text(
                      clientplat!,
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          color: DarkShade,
                          letterSpacing: 5,
                          fontSize: 28
                          // Sw > 1800
                          //     ? 28
                          //     : Sw < 400
                          //         ? Dtxt
                          //         : Dtxt + 10
                          ),
                    )
                  ],
                )),
            SizedBox(
              width: 20,
            ),
            Container(
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    StreamBuilder(
                        stream: membercol.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Big2Txt(
                              Sw: Sw,
                              Sh: Sh,
                              Txt1: (snapshot.data!.docs.length).toString(),
                              Txt2: "TOTAL MEMBER",
                              col: Colors.blue,
                            );
                          } else {
                            return Big2Txt(
                              Sw: Sw,
                              Sh: Sh,
                              Txt1: ("0").toString(),
                              Txt2: "TOTAL MEMBER",
                              col: Colors.blue,
                            );
                          }
                        }),
                    Spacer(),
                    StreamBuilder(
                        stream: staffcol.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Big2Txt(
                              Sw: Sw,
                              Sh: Sh,
                              Txt1: (snapshot.data!.docs.length).toString(),
                              Txt2: "STAFF MEMBER",
                              col: Colors.purple,
                            );
                          } else {
                            return Big2Txt(
                              Sw: Sw,
                              Sh: Sh,
                              Txt1: ("0").toString(),
                              Txt2: "STAFF MEMBER",
                              col: Colors.purple,
                            );
                          }
                        }),
                    Spacer(),
                    Big2Txt(
                      Sw: Sw,
                      Sh: Sh,
                      Txt1: "3",
                      Txt2: "FEE DEFAULTER",
                      col: Colors.redAccent,
                    ),
                  ],
                )),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            miniShowCaseBubble(
              sh: Sh,
              sw: Sw,
              bubcolor: glassmorphBlu,
              titletxt: "NEW MEMBERS",
              titlevalue: "13",
              icontxt: UniconsLine.user,
            ),
            const SizedBox(
              width: 16,
            ),
            miniShowCaseBubble(
              sh: Sh,
              sw: Sw,
              bubcolor: glassmorphpurple,
              titletxt: "BRANCHES",
              titlevalue: "3",
              icontxt: UniconsLine.building,
            ),
            const SizedBox(
              width: 16,
            ),
            miniShowCaseBubble(
              sh: Sh,
              sw: Sw,
              bubcolor: glassmorphRed,
              titletxt: "TILL CLOSING",
              titlevalue: "05:32:46",
              icontxt: UniconsLine.clock,
            ),
          ],
        ),
        // SizedBox(
        //   height: 20,
        // ),
        // Container(
        //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
        //   decoration: BoxDecoration(
        //       color: lightBlu,
        //       borderRadius: BorderRadius.all(Radius.circular(20))),
        //   height: Sw < 400 ? 30 : 50,
        //   child: Row(
        //     children: [
        //       Text(
        //         "FRIDAY",
        //         style: TextStyle(
        //             fontFamily: "Montserrat",
        //             fontWeight: FontWeight.w600,
        //             color: Colors.white,
        //             fontSize: Sw < 630
        //                 ? Sw < 400
        //                     ? Dtxt - 4
        //                     : Dtxt
        //                 : Dtxt + 4),
        //       ),
        //       Spacer(),
        //       Text(
        //         "4TH OF MARCH",
        //         style: TextStyle(
        //             fontFamily: "Montserrat",
        //             color: Colors.white,
        //             fontWeight: FontWeight.w600,
        //             fontSize: Sw < 630
        //                 ? Sw < 400
        //                     ? Dtxt - 4
        //                     : Dtxt
        //                 : Dtxt + 4),
        //       ),
        //       Spacer(),
        //       Text(
        //         "11:05:45",
        //         style: TextStyle(
        //             fontFamily: "Montserrat",
        //             fontWeight: FontWeight.w600,
        //             color: Colors.white,
        //             fontSize: Sw < 630
        //                 ? Sw < 400
        //                     ? Dtxt - 4
        //                     : Dtxt
        //                 : Dtxt + 4),
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class Big2Txt extends StatelessWidget {
  const Big2Txt({
    super.key,
    required this.Sw,
    required this.Sh,
    required this.Txt1,
    required this.Txt2,
    required this.col,
  });

  final Sw, col, Txt1, Txt2, Sh;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Txt1,
          style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: col,
              height: 1,
              fontSize: 48
              //  Sw < 1370
              //     ? Sw < 630
              //         ? Sw < 450
              //             ? Sw < 310
              //                 ? 20
              //                 : 26
              //             : 30
              //         : 44
              //     : 48
              ),
        ),
        Text(
          Txt2,
          style: TextStyle(
              fontFamily: "Montserrat",
              color: Colors.white,
              letterSpacing: 2,
              fontSize: 32
              // Sw < 1370
              //     ? Sw < 630
              //         ? Sw < 450
              //             ? Sw < 310
              //                 ? 12
              //                 : 14
              //             : 18
              //         : 24
              //     : 32
              ),
        ),
      ],
    );
  }
}

class Billing_Packages_Info extends StatelessWidget {
  const Billing_Packages_Info({
    super.key,
    required this.SizeScreenw,
    required this.SizeScreenh,
  });

  final double SizeScreenw, SizeScreenh;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(
                vertical: 20.0, horizontal: SizeScreenw < 630 ? 20 : 40),
            decoration: BoxDecoration(
                color: LightShade,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            height: SizeScreenw > 1800 ? 380 : 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  SizeScreenw.toString() + "--" + SizeScreenh.toString(),
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                      fontSize: Dtxt + 4),
                )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: Colors.white24,
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "INCOME RECIEVED",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: lightGreen,
                      fontSize: SizeScreenw < 630 ? 10 : 14),
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          incomeinfoRow(
                            Sw: SizeScreenw,
                            PlatInfo: "GYM (GOM)",
                            PlatVal: "250,000",
                            color: ultraLightBlue,
                          ),
                          incomeinfoRow(
                            Sw: SizeScreenw,
                            PlatInfo: "GYM (GOM)",
                            PlatVal: "250,000",
                            color: ultraLightBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "INCOME PENDING",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: ultraLightBlue,
                      fontSize: SizeScreenw < 630 ? 10 : 14),
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          incomeinfoRow(
                            Sw: SizeScreenw,
                            PlatInfo: "GYM (GOM)",
                            PlatVal: "250,000",
                            color: ultraLightBlue,
                          ),
                          incomeinfoRow(
                            Sw: SizeScreenw,
                            PlatInfo: "GYM (GOM)",
                            PlatVal: "250,000",
                            color: ultraLightBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RoundedFuncButton(
                func: null,
                buttTxt: "BUTTON",
                buttTxtcol: Colors.white,
                buttbordercol: MainShade,
                buttcol: LightShade,
                buttfont: SizeScreenw < 630
                    ? SizeScreenw < 300
                        ? 8
                        : 10
                    : Dtxt,
                buttheight: DbuttonH,
                butticon: null,
                iconhere: false,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: RoundedFuncButton(
                func: null,
                buttTxt: "BUTTON",
                buttTxtcol: Colors.white,
                buttbordercol: MainShade,
                buttcol: LightShade,
                buttfont: SizeScreenw < 630
                    ? SizeScreenw < 300
                        ? 8
                        : 10
                    : Dtxt,
                buttheight: DbuttonH,
                butticon: null,
                iconhere: false,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: RoundedFuncButton(
                func: null,
                buttTxt: "BUTTON",
                buttTxtcol: Colors.white,
                buttbordercol: MainShade,
                buttcol: LightShade,
                buttfont: SizeScreenw < 630
                    ? SizeScreenw < 300
                        ? 8
                        : 10
                    : Dtxt,
                buttheight: DbuttonH,
                butticon: null,
                iconhere: false,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "PACKAGES",
          style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: Colors.white70,
              fontSize: Dtxt),
        ),
        Container(
          height: SizeScreenw < 630 ? 190 : 350,
          child: ListView(
            children: [
              PackageViewBubble(
                Sw: SizeScreenw,
              ),
              PackageViewBubble(
                Sw: SizeScreenw,
              ),
              PackageViewBubble(
                Sw: SizeScreenw,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SDeskActivityProfileBubble extends StatelessWidget {
  SDeskActivityProfileBubble({
    super.key,
    required this.id,
    required this.sw,
    required this.name,
    required this.platform,
    required this.timein,
    required this.time,
    required this.designation,
  });

  final sw, name, time, platform, timein, designation, id;

  Future<void> _deletemember([String? documentSnapshotid]) async {
    var json = {"Time Out": DateFormat.jm().format(DateTime.now())};
    await activitycol.doc(documentSnapshotid).delete();
    try {
      await recordscol.doc(documentSnapshotid).update(json);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: LightShade,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Container(
              height: 36,
              decoration: BoxDecoration(
                  color: MainShade,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Image.asset(
                "assets/images/profile_pic.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                      fontSize: Dtxt),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "$platform - $designation".toUpperCase(),
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: MainShade,
                      fontSize: Dtxt - 3),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Text(
                      "TIME - ",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          fontSize: Dtxt - 3),
                    ),
                    Text(
                      "$time".toUpperCase(),
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          fontSize: Dtxt - 3),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Container(
              height: 30,
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(color: Colors.white24, width: 2))),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Center(
                child: Text(
                  timein,
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                      fontSize: sw < 910 ? Dtxt - 2 : Dtxt),
                ),
              ),
            ),
            IconButton(
                onPressed: () => _deletemember(id),
                icon: Icon(Icons.exit_to_app, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class DeskActivityProfileBubble extends StatelessWidget {
  DeskActivityProfileBubble({
    super.key,
    required this.id,
    required this.sw,
    required this.name,
    required this.package,
    required this.platform,
    required this.timein,
    required this.feestatus,
    required this.locker,
    required this.defaulters,
    required this.mode,
  });

  final sw,
      name,
      package,
      platform,
      timein,
      feestatus,
      defaulters,
      id,
      locker,
      mode;

  Future<void> _deletemember([String? documentSnapshotid]) async {
    var json = {"Time Out": DateFormat.jm().format(DateTime.now())};
    await activitycol.doc(documentSnapshotid).delete();
    try {
      await recordscol.doc(documentSnapshotid).update(json);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: LightShade,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Container(
              height: 36,
              decoration: BoxDecoration(
                  color: MainShade,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Image.asset(
                "assets/images/profile_pic.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                      fontSize: Dtxt),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "$platform - $package Package".toUpperCase(),
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: MainShade,
                      fontSize: Dtxt - 3),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Text(
                      mode == "S" ? "TIME - " : "FEE - ",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          fontSize: Dtxt - 3),
                    ),
                    Text(
                      "$feestatus".toUpperCase(),
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          color: feestatus == "Paid"
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          fontSize: Dtxt - 3),
                    ),
                    Text(
                      locker == "" ? "" : " - Locker $locker ".toUpperCase(),
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          fontSize: Dtxt - 3),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Container(
              height: 30,
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(color: Colors.white24, width: 2))),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Center(
                child: Text(
                  timein,
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                      fontSize: sw < 910 ? Dtxt - 2 : Dtxt),
                ),
              ),
            ),
            IconButton(
                onPressed: () => Navigator.of(context)
                        .push(HeroDialogRoute(builder: (context) {
                      return LockerPopUp(
                        memberid: id,
                      );
                    })),
                icon: Icon(
                  Icons.door_back_door,
                  color: Colors.white,
                )),
            Center(
                child: Icon(Icons.monetization_on_outlined,
                    color: defaulters ? Colors.redAccent : Colors.greenAccent)),
            IconButton(
                onPressed: () => _deletemember(id),
                icon: Icon(Icons.exit_to_app, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class MobActivityProfileBubble extends StatelessWidget {
  const MobActivityProfileBubble({
    super.key,
    required this.id,
    required this.sw,
    required this.name,
    required this.package,
    required this.platform,
    required this.timein,
    required this.feestatus,
    required this.locker,
    required this.defaulters,
  });

  final sw, name, package, platform, timein, feestatus, defaulters, id, locker;

  Future<void> _deletemember([String? documentSnapshotid]) async {
    var json = {"Time Out": DateFormat.jm().format(DateTime.now())};

    /// await recordscol.doc(documentSnapshotid).update(json);
    await activitycol.doc(documentSnapshotid).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      child: Container(
        width: 220,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: LightShade,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                      color: MainShade,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Image.asset(
                    "assets/images/profile_pic.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          fontSize: Dtxt),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "$platform - $package Package".toUpperCase(),
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          color: MainShade,
                          fontSize: Dtxt - 3),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          "FEE - ",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                              fontSize: Dtxt - 3),
                        ),
                        Text(
                          "$feestatus".toUpperCase(),
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              color: feestatus == "Paid"
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                              fontSize: Dtxt - 3),
                        ),
                        locker == ""
                            ? Text("")
                            : Text(
                                " - Locker $locker".toUpperCase(),
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white70,
                                    fontSize: Dtxt - 3),
                              )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context)
                            .push(HeroDialogRoute(builder: (context) {
                          return LockerPopUp(
                            memberid: id,
                          );
                        })),
                    icon: Icon(
                      Icons.door_back_door,
                      color: Colors.white,
                    )),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.monetization_on_outlined,
                      color:
                          defaulters ? Colors.redAccent : Colors.greenAccent),
                ),
                IconButton(
                    onPressed: () => _deletemember(id),
                    icon: Icon(Icons.exit_to_app, color: Colors.white70)),
                Spacer(),
                Text(
                  timein,
                  style: TextStyle(
                      color: Colors.white70,
                      fontFamily: "Montserrat",
                      fontSize: 12),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class miniShowCaseBubble extends StatelessWidget {
  const miniShowCaseBubble({
    super.key,
    required this.titletxt,
    required this.titlevalue,
    required this.icontxt,
    required this.bubcolor,
    required this.sh,
    required this.sw,
  });
  final titletxt, titlevalue, icontxt, bubcolor, sh, sw;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
          gradient: bubcolor,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icontxt,
            size: 100,
            color: Colors.white70,
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                titlevalue,
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    fontSize: 24),
              ),
              SizedBox(
                height: 05,
              ),
              Text(
                titletxt,
                style: TextStyle(
                    fontFamily: "Montserrat",
                    //  fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    color: Colors.white70,
                    fontSize: 14),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PackageViewBubble extends StatelessWidget {
  const PackageViewBubble({
    super.key,
    required this.Sw,
  });
  final Sw;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: LightShade,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: Sw < 630
              ? Sw < 400
                  ? 50
                  : 60
              : 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: Sw < 630
                      ? Sw < 400
                          ? 30
                          : 40
                      : 60,
                  decoration: BoxDecoration(
                      color: lightRed,
                      borderRadius: BorderRadius.all(
                          Radius.circular(Sw < 630 ? 10 : 20))),
                  child: Center(
                    child: Icon(
                      UniconsLine.dumbbell,
                      color: Colors.black,
                      size: Sw < 630
                          ? Sw < 400
                              ? 20
                              : 30
                          : 40,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "GOLD",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          fontSize: Sw < 630 ? Dtxt : Dtxt + 4),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "PACKAGE",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          fontSize: Sw < 630 ? Dtxt : Dtxt + 4),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.white70,
                  size: Sw < 630 ? 30 : 40,
                ),
              )
            ],
          )),
    );
  }
}

class incomeinfoRow extends StatelessWidget {
  const incomeinfoRow({
    super.key,
    required this.PlatInfo,
    required this.PlatVal,
    required this.color,
    required this.Sw,
  });
  final PlatInfo, PlatVal, color, Sw;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            PlatInfo,
            style: TextStyle(
                fontFamily: "Montserrat",
                color: Colors.white,
                fontSize: Sw < 630 ? 10 : Dtxt),
          ),
          Text(
            "RS " + "$PlatVal",
            style: TextStyle(
                fontFamily: "Montserrat",
                color: color,
                fontSize: Sw < 630 ? 10 : Dtxt),
          )
        ],
      ),
    );
  }
}

class crudTxtfield extends StatelessWidget {
  final controller;
  final title;
  final widht;
  final txtinput;
  final format;
  crudTxtfield({
    required this.title,
    required this.widht,
    required this.controller,
    required this.txtinput,
    required this.format,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontFamily: "Montserrat",
                fontSize: 14,
                //fontWeight: FontWeight.w600
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: TextFormField(
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                  errorMaxLines: 1,
                  errorStyle: TextStyle(
                    fontSize: 10,
                  )),
              keyboardType: txtinput,
              inputFormatters: format,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (title == "First Name" ||
                    title == "Last Name" ||
                    title == "Username" ||
                    title == "Password") {
                  if (value == "") {
                    return "Name Required";
                  }
                }

                if (title == "Email") {
                  if (value != "") {
                    final RegExp emailRegex = RegExp(
                        r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
                    if (emailRegex.hasMatch(value.toString())) {
                    } else {
                      return "Invalid Format";
                    }
                  }
                }
              },
              controller: controller,
              cursorColor: MainShade,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
