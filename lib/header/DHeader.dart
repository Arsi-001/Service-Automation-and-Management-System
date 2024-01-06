import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/Responsive.dart';
import 'package:s_a_m_s/header/MHeader.dart';
import 'package:unicons/unicons.dart';

class Header extends StatelessWidget {
  final Function(int i) callback;
  Header({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      Desktop: DesktopHeader(
        callback: callback,
      ),
      Tablet: DesktopHeader(
        callback: callback,
      ),
      Mobile: MobHeader(
        callback: callback,
      ),
    );
  }
}

class DesktopHeader extends StatefulWidget {
  final Function(int i) callback;

  DesktopHeader({
    super.key,
    required this.callback,
  });

  @override
  State<DesktopHeader> createState() => _DesktopHeaderState();
}

class _DesktopHeaderState extends State<DesktopHeader> {
  @override
  Widget build(BuildContext context) {
    var SizeScreenW = MediaQuery.of(context).size.width;

    var headeritems = [clientName!.toUpperCase(), "Settings", "Logout"];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 350,
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
                        duration: Duration(
                            milliseconds: 300), // tab animation duration
                        gap: 8, // the tab button gap between icon and text
                        color: Colors.black54, // unselected icon color
                        activeColor:
                            Colors.white, // selected icon and text color
                        iconSize: 24, // tab button icon size
                      
                        // selected tab background color
                        padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5), // navigation bar padding
                        tabs: [
                          GButton(
                            icon: UniconsLine.user_md,
                            text: 'STAFF',
                            textStyle: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          GButton(
                            icon: UniconsLine.user,
                            text: 'MEMBER',
                            textStyle: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          GButton(
                            icon: UniconsLine.estate,
                            text: 'HOME',
                            textStyle: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          GButton(
                            icon: UniconsLine.database,
                            text: 'RECORDS',
                            textStyle: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          GButton(
                            icon: UniconsLine.info_circle,
                            text: 'ABOUT',
                            textStyle: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          )
                        ]),
                  ),
                ],
              ),
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
            Container(
              decoration: BoxDecoration(
                  color: Colors.black26,
                  border: Border.all(color: MainShade, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 43, 43, 43),
                        border: Border.all(color: MainShade, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
            )
          ],
        ),
      ),
    );
  }
}
