import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/main.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final user = FirebaseAuth.instance.currentUser!;

  List<Map<String, dynamic>> documentList = [];
  Future getcolname() async {
    try {
      final ref = FirebaseFirestore.instance
          .collection("ClientLoginInfo")
          .doc(user.uid);
      final snap = await ref.get();
      Map<String, dynamic> json;
      if (snap.exists) {
        return snap.data()!;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  late bool fadeIn;
  @override
  void initState() {
    super.initState();
    fadeIn = false;

    // Set a timer to trigger the fade in after a short delay
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        fadeIn = true;
      });

      // Set a timer to trigger the fade out after 4 seconds
      Timer(Duration(seconds: 4), () {
        setState(() {
          fadeIn = false;
          Splashon = false;
        });

        // Set a delay before navigating to the next page
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Homepage(),
            ),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkBlu,
      body: FutureBuilder(
          future: getcolname(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final Map<String, dynamic> documentSnapshot = snapshot.data!;
              return Center(
                child: AnimatedOpacity(
                  opacity: fadeIn ? 1.0 : 0.0,
                  duration: Duration(seconds: 500),
                  child: Text(
                    "WELCOME, ${documentSnapshot["Name"].trim()}",
                    textScaleFactor: 5,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 228, 228, 228),
                      fontFamily: "Montserrat",
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
