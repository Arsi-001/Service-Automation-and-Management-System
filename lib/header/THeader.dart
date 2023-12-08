import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:s_a_m_s/Constant.dart';
import 'package:unicons/unicons.dart';

class TabHeader extends StatefulWidget {
  const TabHeader({super.key});

  @override
  State<TabHeader> createState() => _TabHeaderState();
}

class _TabHeaderState extends State<TabHeader> {
  @override
  Widget build(BuildContext context) {
    var Sw = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                "DASH+$Sw",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: Sw < 500 ? 14 : 25),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Sw < 400
                      ? const SizedBox(
                          width: 0,
                        )
                      : Container(
                          height: 25,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Image.asset(
                            "assets/images/profile_pic.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: Sw < 400 ? 25 : 30,
                    decoration: BoxDecoration(
                        color: lightBlu,
                        border: Border.all(color: Colors.blue),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Sw < 400 ? 60 : 100,
                            child: Text(
                              "Garrison Officer Mess",
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white70,
                                  fontSize: Sw < 400 ? 8 : 12),
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: Colors.white70,
                            size: Sw < 500 ? 20 : 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          Container(
            height: Sw < 500
                ? Sw < 400
                    ? 30
                    : 35
                : 40,
            width: Sw < 500 ? 220 : 300,
            decoration: BoxDecoration(
                color: lightBlu,
                border: Border.all(color: Colors.white12),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: GNav(
                selectedIndex: 2,
                rippleColor:
                    Colors.transparent, // tab button ripple color when pressed

                haptic: true, // haptic feedback

                // tab button border
                // tab button border
                // tab button shadow
                curve: Curves.easeIn, // tab animation curves
                duration:
                    const Duration(milliseconds: 300), // tab animation duration
                gap: Sw < 500
                    ? 5
                    : 8, // the tab button gap between icon and text
                color: Colors.white70, // unselected icon color
                activeColor: Colors.white, // selected icon and text color
                iconSize: Sw < 500 ? 14 : 18, // tab button icon size

                // selected tab background color
                padding: EdgeInsets.symmetric(
                    horizontal: Sw < 500 ? 5 : 10,
                    vertical: 0), // navigation bar padding
                tabs: [
                  GButton(
                    icon: UniconsLine.user_md,
                    text: 'STAFF',
                    textStyle: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: Sw < 500 ? 8 : 12),
                  ),
                  GButton(
                    icon: UniconsLine.user,
                    text: 'MEMBER',
                    textStyle: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: Sw < 500 ? 8 : 12),
                  ),
                  GButton(
                    icon: UniconsLine.estate,
                    text: 'HOME',
                    textStyle: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: Sw < 500 ? 8 : 12),
                  ),
                  GButton(
                    icon: UniconsLine.database,
                    text: 'RECORDS',
                    textStyle: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: Sw < 500 ? 8 : 12),
                  ),
                  GButton(
                    icon: UniconsLine.info_circle,
                    text: 'ABOUT',
                    textStyle: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: Sw < 500 ? 8 : 12),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
