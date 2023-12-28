import 'dart:async';
import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/Crud%20operation/Attendace.dart';
import 'package:s_a_m_s/Crud%20operation/popUp/pop_dialog.dart';
import 'package:s_a_m_s/SharedComponent.dart';
import 'package:unicons/unicons.dart';

class AltDash extends StatefulWidget {
  const AltDash({super.key});

  @override
  State<AltDash> createState() => _AltDashState();
}

class _AltDashState extends State<AltDash> {
  TextEditingController activitycont = TextEditingController();

  Future addMember({
    required id,
  }) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await membercol.doc("TG-M-$id").get();

      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        final docUser = activitycol.doc(data?["ID"]);

        final json = {
          "Name": data?["First name"] + " " + data?["Last name"],
          "Fee Status": data?["Fee Status"],
          "Package": data?["Package"],
          "Platform": data?["Platform"],
          "Time In": "${DateFormat.jm().format(DateTime.now())}",
          "Defaulter": data?["Defaulter"]
        };
        await docUser.set(json);
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

  // int endTime = closingTimeToday.millisecondsSinceEpoch -
  //     DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
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
                                      "Test Gym".toUpperCase(),
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
                                            .where("Defaulter", isEqualTo: true)
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
                          stream: activitycol.snapshots(),
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
                                        "ACTIVITY TRACKER",
                                        style: TextStyle(
                                            fontFamily: "Lato",
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
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
                                            color: Colors.white10,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "TG-M-",
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
                                                    decorationColor: MainShade,
                                                    color: MainShade,
                                                    fontFamily: "Lato"),
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.white,
                                                            width: 1))),
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
                                          addMember(id: activitycont.text);
                                          activitycont.clear();
                                        },

                                        // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          backgroundColor: Colors.white,
                                          elevation: 12.0,
                                        ),
                                        child: const Text(
                                          'Check in',
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                              color: MainShade,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 10),
                                        decoration: BoxDecoration(
                                            color: MainShade,
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
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: ListView.builder(
                                        itemCount:
                                            streamSnapshot.data?.docs.length,
                                        itemBuilder: (context, i) {
                                          final DocumentSnapshot
                                              documentSnapshot =
                                              streamSnapshot.data!.docs[i];
                                          return ActivityProfileBubble(
                                            id: documentSnapshot.id,
                                            name: documentSnapshot["Name"],
                                            feestatus:
                                                documentSnapshot["Fee Status"],
                                            package:
                                                documentSnapshot["Package"],
                                            platform:
                                                documentSnapshot["Platform"],
                                            defaulters:
                                                documentSnapshot["Defaulter"],
                                            timein: documentSnapshot["Time In"]
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
                )
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
              flex: 1,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                      height: 700,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  Color.fromARGB(26, 75, 75, 75).withAlpha(80)),
                          borderRadius: BorderRadius.circular(16),
                          gradient: darkGlassMorphismGradient()),
                      child: Center()),
                ),
              ))
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
