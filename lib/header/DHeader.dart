import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:unicons/unicons.dart';

class DesktopHeader extends StatefulWidget {
  final Function(int i) callback;
  DesktopHeader({super.key, required this.callback});

  @override
  State<DesktopHeader> createState() => _DesktopHeaderState();
}

class _DesktopHeaderState extends State<DesktopHeader> {
  @override
  Widget build(BuildContext context) {
    var SizeScreenW = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
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
                      duration:
                          Duration(milliseconds: 300), // tab animation duration
                      gap: 8, // the tab button gap between icon and text
                      color: Colors.white30, // unselected icon color
                      activeColor: Colors.white, // selected icon and text color
                      iconSize: 24, // tab button icon size
                      textSize: 14,
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
          Expanded(
            flex: 1,
            child: Text(
              SizeScreenW.toString() + "DASh",
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 16),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Image.asset(
                    "assets/images/profile_pic.png",
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 45,
                  width: SizeScreenW < 1080 ? 150 : 200,
                  decoration: BoxDecoration(
                      color: lightBlu,
                      border: Border.all(color: Colors.blue),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Garrison Officer Mess",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white70,
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: Colors.white70,
                            size: 35,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
