import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Main Theme Settings

const DarkShade = Color(0xFF080808);
const LightShade = Color.fromARGB(255, 25, 25, 25);
//const MainShade = Blu_alt;
const MainShade = Color(0xFFFF7F01);
const ThemeItemcolbackground = Colors.black87;

//Main Theme Settings

// Limbo Theme
const DarkSgrey = Color(0xFF080808);
const Lightgrey = Color(0xFF141414);
const grey = Color(0xFF676767);
// Limbo Theme

//Calm Blue Theme
const DarkBlu = Color(0xFF00264D);
const lightBlu = Color(0xFF02386E);
const Blu = Color(0xFF0052A2);
//Calm Blue Theme

//Alt Calm Blue Theme
const DarkBlu_alt = Color(0xFF202342);
const lightBlu_alt = Color(0xFF2D325A);
const Blu_alt = Color(0xFF4C7BFF);
//Alt Calm Blue Theme

// Misc Color Items
const lightGreen = Color(0xFFE3FFA8);
const ultraLightBlue = Color(0xFF7497FF);
const lightRed = Color(0xFFF75165);
const lightPurple = Color(0xFF7133FF);
//Misc Color Items

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

var Logingradient = LinearGradient(
    begin: Alignment(0.1, 0.8),
    end: Alignment(0.3, -0.1),
    colors: [
      Color.fromARGB(158, 120, 120, 120),
      Color.fromARGB(147, 200, 200, 200)
    ]);
// var multigradient = LinearGradient(
//     begin: Alignment(0.1, 0.8),
//     end: Alignment(0.3, -0.1),
//     colors: [Blu, Color.fromARGB(255, 29, 102, 163)]);
bool lockerOn = false;
var multigradient = LinearGradient(
    begin: Alignment(0.1, 0.8),
    end: Alignment(0.3, -0.1),
    colors: [
      Color.fromARGB(255, 255, 149, 43),
      Color.fromARGB(255, 252, 121, 70)
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
const glassmorphblack = LinearGradient(
    begin: Alignment(-0.3, 0.8),
    end: Alignment(0.3, -0.1),
    colors: [Color.fromRGBO(56, 56, 56, 0.682), Color.fromRGBO(49, 49, 49, 1)]);
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
String? colname = "TGym1";
String? initials = "TG";
CollectionReference clientcol =
    FirebaseFirestore.instance.collection("$colname");
bool Splashon = false;
String? clientplat = "GYM";
var membercol =
    FirebaseFirestore.instance.collection("/$colname/$clientplat/Members");
var activitycol =
    FirebaseFirestore.instance.collection("/$colname/$clientplat/Activity");
var packagecol =
    FirebaseFirestore.instance.collection("/$colname/$clientplat/Packages");
var defaultercol = FirebaseFirestore.instance
    .collection("/$colname/$clientplat/Members")
    .where("Defaulters", isEqualTo: true);
DateFormat currentmonth = DateFormat.MMM();
DateFormat currentyear = DateFormat.y();
var recordscol = FirebaseFirestore.instance.collection(
    "/$colname/$clientplat/Records/${currentyear.format(DateTime.now())}/${currentmonth.format(DateTime.now())}/");
var staffcol =
    FirebaseFirestore.instance.collection("/$colname/$clientplat/Staff");

var clientName = "Test";

LinearGradient darkGlassMorphismGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      DarkShade.withOpacity(0.8), // Dark color with 80% opacity
      DarkShade.withOpacity(0.6), // Slightly lighter color
    ],
    stops: const [0.1, 0.9],
  );
}
