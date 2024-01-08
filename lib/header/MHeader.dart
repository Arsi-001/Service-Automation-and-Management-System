import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:unicons/unicons.dart';

class MobHeader extends StatefulWidget {
  final Function(int i) callback;

  MobHeader({
    super.key,
    required this.callback,
  });

  @override
  State<MobHeader> createState() => _MobHeaderState();
}

class _MobHeaderState extends State<MobHeader> {
  @override
  Widget build(BuildContext context) {
    var SizeScreenW = MediaQuery.of(context).size.width;

    var headeritems = [clientName!.toUpperCase(), "Settings", "Logout"];

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 0, horizontal: SizeScreenW < 430 ? 0 : 40),
      child: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            // Expanded(
            //   flex: 1,
            //   child: Text(
            //     SizeScreenW.toString() + "DASh",
            //     style: TextStyle(
            //         fontFamily: "Montserrat",
            //         fontWeight: FontWeight.w600,
            //         color: Colors.white,
            //         fontSize: 30),
            //   ),
            // ),
            Container(
              height: 50,
              //  width: SizeScreenW < 430 ? 280 : 350,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  // color: lightBlu,
                  //border: Border.all(color: Colors.white12),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: GNav(
                  onTabChange: (index) {
                    widget.callback(index);
                  },
                  selectedIndex: 2,
                  rippleColor: Colors
                      .transparent, // tab button ripple color when pressed

                  haptic: true, // haptic feedback

                  // tab button border
                  // tab button border
                  // tab button shadow
                  curve: Curves.easeIn, // tab animation curves
                  duration:
                      Duration(milliseconds: 300), // tab animation duration
                  gap: 4, // the tab button gap between icon and text
                  color: Colors.black54, // unselected icon color
                  activeColor: Colors.white, // selected icon and text color
                  iconSize: SizeScreenW < 460 ? 20 : 24, // tab button icon size
                  textSize: 10,
                  textStyle: TextStyle(
                    fontSize: SizeScreenW < 440 ? 10 : 14,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  // selected tab background color
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeScreenW < 350
                          ? 0
                          : SizeScreenW < 480
                              ? 16
                              : 18,
                      vertical: 5), // navigation bar padding
                  tabs: [
                    GButton(
                      icon: UniconsLine.user_md,
                      text: 'STAFF',
                    ),
                    GButton(
                      icon: UniconsLine.user,
                      text: 'MEMBER',
                    ),
                    GButton(
                      icon: UniconsLine.estate,
                      text: 'HOME',
                    ),
                    GButton(
                      icon: UniconsLine.database,
                      text: 'RECORDS',
                    ),
                    GButton(
                      icon: UniconsLine.info_circle,
                      text: 'ABOUT',
                    )
                  ]),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Text(
            //     SizeScreenW.toString() + "DASh" + widget.colname + userinfo.uid,
            //     style: TextStyle(
            //         fontFamily: "Montserrat",
            //         fontWeight: FontWeight.w600,
            //         color: Colors.white,
            //         fontSize: 16),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: SizeScreenW < 430 ? 40.0 : 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        border: Border.all(color: MainShade, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 43, 43, 43),
                              border: Border.all(color: MainShade, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Image.asset(
                            "assets/images/sams_logo.png",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    icon: Icon(Icons.arrow_drop_down_rounded),
                                    // icon: Icon(
                                    //   UniconsLine.setting,
                                    //   color: Colors.white,
                                    // ),
                                    iconEnabledColor: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    onChanged: (value) {
                                      if (value == "Logout") {
                                        FirebaseAuth.instance.signOut();
                                      }
                                    },
                                    dropdownColor: DarkShade,
                                    value: clientName!.toUpperCase(),
                                    style: TextStyle(
                                        fontFamily: "Lato",
                                        color: Colors.white,
                                        overflow: TextOverflow.clip),
                                    items: headeritems.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: TextStyle(
                                            fontFamily: "Lato",
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
