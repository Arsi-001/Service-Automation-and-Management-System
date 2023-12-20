import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//const DarkBlu = Color(0xFF202342);
const DarkBlu = Color(0xFF00264D);

//const lightBlu = Color(0xFF2D325A);
const lightBlu = Color(0xFF02386E);

const lightGreen = Color(0xFFE3FFA8);

const ultraLightBlue = Color(0xFF7497FF);

//const Blu = Color(0xFF4C7BFF);
const Blu = Color(0xFF0052A2);

const lightRed = Color(0xFFF75165);

const lightPurple = Color(0xFF7133FF);

//2D325A E3FFA8 7497FF 4C7BFF F86173 7133FF

const glassmorphGreen = LinearGradient(
    begin: Alignment(-0.3, 0.8),
    end: Alignment(0.3, -0.1),
    colors: [
      Color.fromRGBO(227, 255, 168, 0.7),
      Color.fromRGBO(227, 255, 168, 1)
    ]);

const glassmorphBlu = LinearGradient(
    begin: Alignment(-0.3, 0.8),
    end: Alignment(0.3, -0.1),
    colors: [
      Color.fromRGBO(76, 123, 255, 0.65),
      Color.fromRGBO(76, 124, 255, 1)
    ]);

const glassmorphRed = LinearGradient(
    begin: Alignment(-0.3, 0.8),
    end: Alignment(0.3, -0.1),
    colors: [Color.fromRGBO(247, 81, 101, 0.7), Color(0xFFF75165)]);
const glassmorphpurple = LinearGradient(
    begin: Alignment(-0.3, 0.8),
    end: Alignment(0.3, -0.1),
    colors: [
      Color.fromRGBO(113, 51, 255, 0.7),
      Color.fromRGBO(113, 51, 255, 1)
    ]);
const glassmorph = LinearGradient(
    begin: Alignment(-0.3, 0.8),
    end: Alignment(0.3, -0.1),
    colors: [
      Color.fromRGBO(255, 255, 255, 0),
      Color.fromRGBO(255, 255, 255, 0.17)
    ]);

var InsideRowW = 0;
// Text(
//                           "Total Members: 10",
//                           style: TextStyle(
//                               fontFamily: "Montserrat",
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white70,
//                               fontSize: 22.sp),
//                         );

var navIconSize = 30;

const Dtxt = 12.0;
const DbuttonH = 40;
const NavSize = 100.0;
const String heroAddTodo = 'add-todo-hero';

final userinfo = FirebaseAuth.instance.currentUser!;
String? colname = "TGym";
CollectionReference clientcol =
    FirebaseFirestore.instance.collection("$colname");
bool Splashon = false;
String? clientplat = "GYM";
final membercol =
    FirebaseFirestore.instance.collection("/$colname/$clientplat/Members");
CollectionReference activitycol =
    FirebaseFirestore.instance.collection("/$colname/$clientplat/Activity");
final defaultercol = FirebaseFirestore.instance
    .collection("/$colname/$clientplat/Members")
    .where("Defaulters", isEqualTo: true);
