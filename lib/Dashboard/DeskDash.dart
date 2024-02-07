import 'dart:async';
import 'dart:math';

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';
//import 'package:pie_chart/pie_chart.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/Crud%20operation/Addpage.dart';
import 'package:s_a_m_s/Crud%20operation/popUp/pop_dialog.dart';
import 'package:s_a_m_s/Dashboard/MobDash.dart';
import 'package:s_a_m_s/Responsive.dart';
import 'package:s_a_m_s/SharedComponent.dart';
import 'package:s_a_m_s/weeklychceker.dart';
import 'package:unicons/unicons.dart';

class Dash extends StatelessWidget {
  const Dash({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      Desktop: DeskDash(),
      Tablet: DeskDash(),
      Mobile: MobDash(),
    );
  }
}

class DeskDash extends StatefulWidget {
  const DeskDash({super.key});

  @override
  State<DeskDash> createState() => _DeskDashState();
}

class _DeskDashState extends State<DeskDash> {
  TextEditingController activitycont = TextEditingController();

  Future<List<DocumentSnapshot>> getData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('/$colname/$clientplat/Packages')
        .get();

    return snapshot.docs;
  }

  Future<List<PieChartSectionData>> getSections(
      List<DocumentSnapshot> data) async {
    List<PieChartSectionData> sections = [];

    for (var document in data) {
      var snap = await FirebaseFirestore.instance
          .collection('/$colname/$clientplat/Members')
          .where("package", isEqualTo: document["name"])
          .get();
      print(document["name"]);

      String packageName = document['name'];
      int subscribers = snap.docs.length;

      sections.add(
        PieChartSectionData(
          titlePositionPercentageOffset: 1.5,
          value: subscribers.toDouble(),
          title: packageName, // Display data on the chart
          color: getBrightRandomColor(),
          titleStyle: const TextStyle(color: Colors.white),
        ),
      );
    }

    return sections;
  }

  Color getBrightRandomColor() {
    Random random = Random();
    int minBrightness = 192; // Adjust as needed

    int red = minBrightness + random.nextInt(256 - minBrightness);
    int green = minBrightness + random.nextInt(256 - minBrightness);
    int blue = minBrightness + random.nextInt(256 - minBrightness);

    return Color.fromRGBO(red, green, blue, 1.0);
  }

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  DateFormat dateformat2 = DateFormat.d();
  String mode = "M";
  Future addActiveMember({
    required id,
  }) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await membercol.doc("$initials-M-$id").get();

      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        final docUser = activitycol.doc(data?["ID"]);
        final docUser2 = recordscol.doc(data?["ID"]);

        final json = {
          "name": data?["firstName"] + " " + data?["lastName"],
          "feeStatus": data?["feeStatus"],
          "package": data?["package"],
          "platform": data?["platform"],
          "timeIn": DateFormat.jm().format(DateTime.now()),
          "defaulter": data?["defaulter"],
          "date": dateFormat.format(DateTime.now()),
          "day": (dateformat2.format(DateTime.now())),
          "locker": "",
          "status": "Member",
          "idnum": int.parse(id),
        };

        await docUser.set(json);
        await docUser2.set(json);
      } else {
        print('Document $id does not exist in the collection.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future addActiveStaff({
    required id,
  }) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await staffcol.doc("$initials-S-$id").get();

      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        final docUser = activitycol.doc(data?["ID"]);
        final docUser2 = recordscol.doc(data?["ID"]);

        final json = {
          "name": data?["firstName"] + " " + data?["lastName"],
          "designation": data?["designation"],
          "platform": data?["platform"],
          "status": "Staff",
          "timeIn": DateFormat.jm().format(DateTime.now()),
          "date": dateFormat.format(DateTime.now()),
          "day": (dateformat2.format(DateTime.now())),
          "idnum": int.parse(id),
        };

        await docUser.set(json);
        await docUser2.set(json);
      } else {
        print('Document $id does not exist in the collection.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Specify your gym's closing time
  final int closingHour = 1; // 5:00 PM
  final int closingMinute = 0;
  int touchedIndex = -1;
  // int endTime = closingTimeToday.millisecondsSinceEpoch -
  //     DateTime.now().millisecondsSinceEpoch;
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 6,
    // "Xamarin": 2,
    // "Ionic": 2,
  };
  Map<String, double> dataMap2 = {
    "Male": 5,
    "Female": 2,
  };
  @override
  Widget build(BuildContext context) {
    var SizeScreenW = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    DateTime closingTimeToday =
        DateTime(now.year, now.month, now.day, closingHour, closingMinute);

    // If the closing time for today has already passed, calculate the closing time for tomorrow
    if (now.isAfter(closingTimeToday)) {
      closingTimeToday = closingTimeToday.add(Duration(days: 1));
    }

    int remainingTime = closingTimeToday.millisecondsSinceEpoch;
    int endtime = remainingTime;
    // If closing time for today has already passed, set the remaining time to 0
    // int remainingTime = closingTimeToday.millisecondsSinceEpoch -
    //     DateTime.now().millisecondsSinceEpoch;

    // int remainingTime = DateTime.now().isBefore(closingTimeToday)
    //     ? closingTimeToday.millisecondsSinceEpoch -
    //         DateTime.now().millisecondsSinceEpoch
    //     : 0;

    // Duration remainingDuration = closingTimeToday.difference(DateTime.now());
    // int remainingTime = remainingDuration.inMilliseconds > 0
    //     ? remainingDuration.inMilliseconds
    //     : 0;
    // print(remainingTime);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 30),
                            height: 200,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(26, 104, 104, 104)
                                        .withAlpha(80)),
                                borderRadius: BorderRadius.circular(16),
                                gradient: darkGlassMorphismGradient()),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      clientName.toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Lato",
                                          fontSize: 24),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              color: MainShade,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Center(
                                            child: Icon(
                                              UniconsLine.dumbbell,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        SizedBox(
                                          height: 45,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "PLATFORM",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 12,
                                                    fontFamily: "Lato"),
                                              ),
                                              Text(
                                                clientplat!.toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: "Lato"),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    StreamBuilder(
                                        stream: membercol.snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return infobubble(
                                              txt: "TOTAL MEMBERS",
                                              value:
                                                  (snapshot.data!.docs.length)
                                                      .toString(),
                                            );
                                          } else {
                                            return infobubble(
                                              txt: "TOTAL MEMBERS",
                                              value: "0",
                                            );
                                          }
                                        }),
                                    StreamBuilder(
                                        stream: staffcol.snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return infobubble(
                                              txt: "TOTAL STAFF",
                                              value:
                                                  (snapshot.data!.docs.length)
                                                      .toString(),
                                            );
                                          } else {
                                            return infobubble(
                                              txt: "TOTAL STAFF",
                                              value: "0",
                                            );
                                          }
                                        }),
                                    StreamBuilder(
                                        stream: membercol
                                            .where("defaulter", isEqualTo: true)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return infobubble(
                                              txt: "FEE DEFAULTERS",
                                              value:
                                                  (snapshot.data!.docs.length)
                                                      .toString(),
                                            );
                                          } else {
                                            return infobubble(
                                              txt: "FEE DEFAULTERS",
                                              value: "0",
                                            );
                                          }
                                        }),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Closing Till".toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 12,
                                                  fontFamily: "Lato"),
                                            ),

                                            SizedBox(
                                              width: 5,
                                            ),
                                            // Icon(
                                            //   Icons.person_rounded,
                                            //   color: Colors.white54,
                                            // ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Center(
                                          child: CountdownTimer(
                                            onEnd: () => print("GYM CLOSED"),
                                            endWidget: Text(
                                              "00:00:00".toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontFamily: "Lato"),
                                            ),
                                            endTime: endtime,
                                            textStyle: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                                fontFamily: "Lato"),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      height: 500,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(26, 104, 104, 104)
                                  .withAlpha(80)),
                          borderRadius: BorderRadius.circular(16),
                          gradient: darkGlassMorphismGradient()),
                      child: StreamBuilder(
                          stream: activitycol
                              .where("status",
                                  isEqualTo: mode == "S" ? "Staff" : "Member")
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            if (streamSnapshot.hasData) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Activity Tracker",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            color: Colors.white70,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        height: 1,
                                        color:
                                            Color.fromARGB(58, 128, 128, 128),
                                      ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                            //color: Colors.white10,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (mode == "M") {
                                                      mode = "S";
                                                    } else {
                                                      mode = "M";
                                                    }
                                                  });
                                                },
                                                icon: Icon(Icons.refresh,
                                                    color: MainShade)),
                                            Text(
                                              "$initials" + "-$mode-",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontFamily: "Lato"),
                                            ),
                                            SizedBox(
                                              width: 40,
                                              child: TextField(
                                                controller: activitycont,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    decorationColor: MainShade,
                                                    color: MainShade,
                                                    fontFamily: "Lato"),
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 5),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color: MainShade,
                                                              width: 1.0),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          mode == "S"
                                              ? addActiveStaff(
                                                  id: activitycont.text)
                                              : addActiveMember(
                                                  id: activitycont.text);
                                          activitycont.clear();
                                        },

                                        // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          backgroundColor: MainShade,
                                          elevation: 12.0,
                                        ),
                                        child: const Text(
                                          'Check in',
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Text(
                                          "Attendance: " +
                                              (streamSnapshot.data?.docs.length)
                                                  .toString(),
                                          style: TextStyle(
                                              fontFamily: "Lato",
                                              // fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      child: ListView.builder(
                                        itemCount:
                                            streamSnapshot.data?.docs.length,
                                        itemBuilder: (context, i) {
                                          final DocumentSnapshot
                                              documentSnapshot =
                                              streamSnapshot.data!.docs[i];

                                          return mode == "S"
                                              ? SDeskActivityProfileBubble(
                                                  id: documentSnapshot.id,
                                                  sw: 1080,
                                                  name:
                                                      documentSnapshot["name"],
                                                  platform: documentSnapshot[
                                                      "platform"],
                                                  timein: documentSnapshot[
                                                      "timeIn"],
                                                  time: documentSnapshot[
                                                      "timeIn"],
                                                  designation: documentSnapshot[
                                                      "designation"])
                                              : DeskActivityProfileBubble(
                                                  mode: mode,
                                                  id: documentSnapshot.id,
                                                  locker: documentSnapshot[
                                                      "locker"],
                                                  name:
                                                      documentSnapshot["name"],
                                                  feestatus: documentSnapshot[
                                                      "feeStatus"],
                                                  package: documentSnapshot[
                                                      "package"],
                                                  platform: documentSnapshot[
                                                      "platform"],
                                                  defaulters: documentSnapshot[
                                                      "defaulter"],
                                                  timein:
                                                      documentSnapshot["timeIn"]
                                                          .toString(),
                                                  sw: 1080,
                                                );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizeScreenW > 1200
                    ? SizedBox(
                        width: 1,
                      )
                    : ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                              width: 550,
                              padding: EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromARGB(26, 75, 75, 75)
                                          .withAlpha(80)),
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: darkGlassMorphismGradient()),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Statistics",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontFamily: "Montserrat",
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          height: 1,
                                          color: Colors.white12,
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 30),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              height: 250,
                                              child: FutureBuilder<
                                                  List<DocumentSnapshot>>(
                                                future: getData(),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return CircularProgressIndicator();
                                                  } else if (snapshot
                                                          .hasError ||
                                                      snapshot.data == null) {
                                                    return Text(
                                                        'Error: ${snapshot.error ?? "Failed to load data"}');
                                                  } else {
                                                    return FutureBuilder<
                                                        List<
                                                            PieChartSectionData>>(
                                                      future: getSections(
                                                          snapshot.data!),
                                                      builder: (context,
                                                          sectionsSnapshot) {
                                                        if (sectionsSnapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return CircularProgressIndicator();
                                                        } else if (sectionsSnapshot
                                                                .hasError ||
                                                            sectionsSnapshot
                                                                    .data ==
                                                                null) {
                                                          return Text(
                                                              'Error: ${sectionsSnapshot.error ?? "Failed to load sections"}');
                                                        } else {
                                                          return PieChart(
                                                            PieChartData(
                                                              sectionsSpace: 8,
                                                              sections:
                                                                  sectionsSnapshot
                                                                      .data!,
                                                              // Other configurations for your pie chart
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    );
                                                  }
                                                },
                                              ),
                                            )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 250,
                                              child: BarChartSample1(),
                                            ))
                                      ],
                                    ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //         child: Container(
                                    //       height: 1,
                                    //       color: Colors.white12,
                                    //     )),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    // Expanded(
                                    //     child: Container(
                                    //   decoration: BoxDecoration(
                                    //       color: Color.fromARGB(59, 27, 27, 27)
                                    //           .withOpacity(0.8),
                                    //       borderRadius:
                                    //           BorderRadius.all(Radius.circular(16))),
                                    //   child: Center(
                                    //     child: Text(
                                    //       "COMING SOON!",
                                    //       style:
                                    //           TextStyle(color: Colors.white, fontSize: 16),
                                    //     ),
                                    //   ),
                                    // )),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Expanded(
                                    //       child: Padding(
                                    //         padding:
                                    //             const EdgeInsets.symmetric(horizontal: 8.0),
                                    //         child: Container(
                                    //           width: 100,
                                    //           height: 40,
                                    //           child: ElevatedButton(
                                    //             onPressed: () {},
                                    //             // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                                    //             style: ElevatedButton.styleFrom(
                                    //                 shape: RoundedRectangleBorder(
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(8.0),
                                    //                     side: BorderSide(color: MainShade)),
                                    //                 backgroundColor: Colors.transparent,
                                    //                 elevation: 12.0,
                                    //                 textStyle: const TextStyle(
                                    //                     color: Colors.white)),
                                    //             child: const Text(
                                    //               'Weekly',
                                    //               style: TextStyle(
                                    //                   fontFamily: "Montserrat",
                                    //                   fontWeight: FontWeight.w600,
                                    //                   color: Colors.white70,
                                    //                   fontSize: 12),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       child: Padding(
                                    //         padding:
                                    //             const EdgeInsets.symmetric(horizontal: 8.0),
                                    //         child: Container(
                                    //           width: 100,
                                    //           height: 40,
                                    //           child: ElevatedButton(
                                    //             onPressed: () {},
                                    //             // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                                    //             style: ElevatedButton.styleFrom(
                                    //                 shape: RoundedRectangleBorder(
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(8.0),
                                    //                     side: BorderSide(color: MainShade)),
                                    //                 backgroundColor: Colors.transparent,
                                    //                 elevation: 12.0,
                                    //                 textStyle: const TextStyle(
                                    //                     color: Colors.white)),
                                    //             child: const Text(
                                    //               'Monthly',
                                    //               style: TextStyle(
                                    //                   fontFamily: "Montserrat",
                                    //                   fontWeight: FontWeight.w600,
                                    //                   color: Colors.white70,
                                    //                   fontSize: 12),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     Expanded(
                                    //       child: Padding(
                                    //         padding:
                                    //             const EdgeInsets.symmetric(horizontal: 8.0),
                                    //         child: Container(
                                    //           width: 100,
                                    //           height: 40,
                                    //           child: ElevatedButton(
                                    //             onPressed: () {},
                                    //             // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                                    //             style: ElevatedButton.styleFrom(
                                    //                 shape: RoundedRectangleBorder(
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(8.0),
                                    //                     side: BorderSide(color: MainShade)),
                                    //                 backgroundColor: Colors.transparent,
                                    //                 elevation: 12.0,
                                    //                 textStyle: const TextStyle(
                                    //                     color: Colors.white)),
                                    //             child: const Text(
                                    //               'Yearly',
                                    //               style: TextStyle(
                                    //                   fontFamily: "Montserrat",
                                    //                   fontWeight: FontWeight.w600,
                                    //                   color: Colors.white70,
                                    //                   fontSize: 12),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              )),
                        ),
                      )
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          SizeScreenW < 1200
              ? SizedBox(
                  width: 1,
                )
              : ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                        width: 550,
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(26, 75, 75, 75)
                                    .withAlpha(80)),
                            borderRadius: BorderRadius.circular(16),
                            gradient: darkGlassMorphismGradient()),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Statistics",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontFamily: "Montserrat",
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    height: 1,
                                    color: Colors.white12,
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 30),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        height: 250,
                                        child: FutureBuilder<
                                            List<DocumentSnapshot>>(
                                          future: getData(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.hasError ||
                                                snapshot.data == null) {
                                              return Text(
                                                  'Error: ${snapshot.error ?? "Failed to load data"}');
                                            } else {
                                              return FutureBuilder<
                                                  List<PieChartSectionData>>(
                                                future:
                                                    getSections(snapshot.data!),
                                                builder: (context,
                                                    sectionsSnapshot) {
                                                  if (sectionsSnapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return CircularProgressIndicator();
                                                  } else if (sectionsSnapshot
                                                          .hasError ||
                                                      sectionsSnapshot.data ==
                                                          null) {
                                                    return Text(
                                                        'Error: ${sectionsSnapshot.error ?? "Failed to load sections"}');
                                                  } else {
                                                    return PieChart(
                                                      PieChartData(
                                                        sectionsSpace: 8,
                                                        sections:
                                                            sectionsSnapshot
                                                                .data!,
                                                        // Other configurations for your pie chart
                                                      ),
                                                    );
                                                  }
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        height: 250,
                                        child: BarChartSample1(),
                                      ))
                                ],
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //         child: Container(
                              //       height: 1,
                              //       color: Colors.white12,
                              //     )),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Expanded(
                              //     child: Container(
                              //   decoration: BoxDecoration(
                              //       color: Color.fromARGB(59, 27, 27, 27)
                              //           .withOpacity(0.8),
                              //       borderRadius:
                              //           BorderRadius.all(Radius.circular(16))),
                              //   child: Center(
                              //     child: Text(
                              //       "COMING SOON!",
                              //       style:
                              //           TextStyle(color: Colors.white, fontSize: 16),
                              //     ),
                              //   ),
                              // )),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Expanded(
                              //       child: Padding(
                              //         padding:
                              //             const EdgeInsets.symmetric(horizontal: 8.0),
                              //         child: Container(
                              //           width: 100,
                              //           height: 40,
                              //           child: ElevatedButton(
                              //             onPressed: () {},
                              //             // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                              //             style: ElevatedButton.styleFrom(
                              //                 shape: RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.circular(8.0),
                              //                     side: BorderSide(color: MainShade)),
                              //                 backgroundColor: Colors.transparent,
                              //                 elevation: 12.0,
                              //                 textStyle: const TextStyle(
                              //                     color: Colors.white)),
                              //             child: const Text(
                              //               'Weekly',
                              //               style: TextStyle(
                              //                   fontFamily: "Montserrat",
                              //                   fontWeight: FontWeight.w600,
                              //                   color: Colors.white70,
                              //                   fontSize: 12),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: Padding(
                              //         padding:
                              //             const EdgeInsets.symmetric(horizontal: 8.0),
                              //         child: Container(
                              //           width: 100,
                              //           height: 40,
                              //           child: ElevatedButton(
                              //             onPressed: () {},
                              //             // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                              //             style: ElevatedButton.styleFrom(
                              //                 shape: RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.circular(8.0),
                              //                     side: BorderSide(color: MainShade)),
                              //                 backgroundColor: Colors.transparent,
                              //                 elevation: 12.0,
                              //                 textStyle: const TextStyle(
                              //                     color: Colors.white)),
                              //             child: const Text(
                              //               'Monthly',
                              //               style: TextStyle(
                              //                   fontFamily: "Montserrat",
                              //                   fontWeight: FontWeight.w600,
                              //                   color: Colors.white70,
                              //                   fontSize: 12),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: Padding(
                              //         padding:
                              //             const EdgeInsets.symmetric(horizontal: 8.0),
                              //         child: Container(
                              //           width: 100,
                              //           height: 40,
                              //           child: ElevatedButton(
                              //             onPressed: () {},
                              //             // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                              //             style: ElevatedButton.styleFrom(
                              //                 shape: RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.circular(8.0),
                              //                     side: BorderSide(color: MainShade)),
                              //                 backgroundColor: Colors.transparent,
                              //                 elevation: 12.0,
                              //                 textStyle: const TextStyle(
                              //                     color: Colors.white)),
                              //             child: const Text(
                              //               'Yearly',
                              //               style: TextStyle(
                              //                   fontFamily: "Montserrat",
                              //                   fontWeight: FontWeight.w600,
                              //                   color: Colors.white70,
                              //                   fontSize: 12),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        )),
                  ),
                )
        ],
      ),
    );
  }
}

class infobubble extends StatelessWidget {
  const infobubble({
    super.key,
    required this.txt,
    required this.value,
  });
  final txt, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              txt,
              style: TextStyle(
                  color: Colors.white54, fontSize: 12, fontFamily: "Lato"),
            ),
            SizedBox(
              width: 5,
            ),
            // Icon(
            //   Icons.person_rounded,
            //   color: Colors.white54,
            // ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          value,
          style:
              TextStyle(color: Colors.white, fontSize: 30, fontFamily: "Lato"),
        ),
      ],
    );
  }
}

class ColorBubble extends StatelessWidget {
  const ColorBubble(
      {super.key,
      required this.icon,
      required this.txt,
      required this.value,
      required this.gradient});
  final icon, txt, value, gradient;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 210,
      decoration: BoxDecoration(
          // gradient: gradient,
          border: Border.all(color: lightGreen),
          color: LightShade,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60,
            color: lightGreen,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            value,
            style: TextStyle(
                color: lightGreen,
                fontSize: 16,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(txt,
              style: TextStyle(
                  color: lightGreen, fontSize: 14, fontFamily: "Lato"))
        ],
      ),
    );
  }
}
