import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:s_a_m_s/Crud%20operation/Addpage.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/SharedComponent.dart';
import 'package:s_a_m_s/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var SizeScreenW = MediaQuery.of(context).size.width;
    TextEditingController Uname = TextEditingController();
    TextEditingController Upass = TextEditingController();

    Future<void> authuser() async {
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: Uname.text.trim(), password: Upass.text.trim());
      } on FirebaseAuthException catch (e) {
        print(e);
      }

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }

    @override
    void dispose() {
      Uname.dispose();
      Upass.dispose();
      super.dispose();
    }

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/loginbg3.png",
              ),
              fit: BoxFit.cover)
          //gradient: Logingradient
          ),
      child: Container(
        color: Color.fromARGB(150, 0, 0, 0),
        child: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo(),
                    // Padding(
                    //   padding: const EdgeInsets.all(20.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         "Service Automation And Management System",
                    //         style: TextStyle(
                    //             fontSize: SizeScreenW < 600 ? 16 : 24,
                    //             //  fontWeight: FontWeight.w600,
                    //             color: Colors.white,
                    //             overflow: TextOverflow.visible,
                    //             fontFamily: "Montserrat"),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 40,
                    // ),
                    SizeScreenW < 900
                        ? SizeScreenW < 280
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 43, 43, 43),
                                        border: Border.all(
                                            color: MainShade, width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Image.asset(
                                      "assets/images/sams_logo.png",
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "SAMS",
                                    style: TextStyle(
                                        letterSpacing: 6,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 48,
                                        color: Colors.white),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 43, 43, 43),
                                        border: Border.all(
                                            color: MainShade, width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Image.asset(
                                      "assets/images/sams_logo.png",
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "SAMS",
                                    style: TextStyle(
                                        letterSpacing: 6,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 48,
                                        color: Colors.white),
                                  ),
                                ],
                              )
                        : SizedBox(
                            width: 1,
                          ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizeScreenW < 930
                            ? SizedBox(
                                width: 1,
                              )
                            : Container(
                                width: 450,
                                height: 550,
                                decoration: BoxDecoration(
                                    //border: Border.all(color: Colors.white, width: 2),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 550,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/loginnew.png"),
                                              opacity: 0.5,
                                              fit: BoxFit.fitHeight)),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 30),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 55,
                                                width: 55,
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 43, 43, 43),
                                                    border: Border.all(
                                                        color: MainShade,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Image.asset(
                                                  "assets/images/sams_logo.png",
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "SAMS",
                                                    style: TextStyle(
                                                        letterSpacing: 6,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 48,
                                                        color: Colors.black87),
                                                  ),
                                                  // Text(
                                                  //   "Service Automation And Management System",
                                                  //   style: TextStyle(
                                                  //       fontFamily: "Montserrat",
                                                  //       // fontWeight: FontWeight.bold,
                                                  //       fontSize: 12,
                                                  //       color: Colors.black54),
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          // Text(
                                          //   "Sams Provides Comfort,",
                                          //   style: TextStyle(
                                          //       letterSpacing: 0,
                                          //       fontFamily: "Montserrat",
                                          //       // fontWeight: FontWeight.bold,
                                          //       fontSize: 16,
                                          //       color: Colors.black54),
                                          // ),
                                          // SizedBox(
                                          //   height: 8,
                                          // ),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.start,
                                          //   children: [
                                          //     Text(
                                          //       "Management At It's Finest",
                                          //       style: TextStyle(
                                          //           letterSpacing: 0,
                                          //           fontFamily: "Montserrat",
                                          //           // fontWeight: FontWeight.bold,
                                          //           fontSize: 16,
                                          //           color: Colors.black54),
                                          //     ),
                                          //   ],
                                          // ),
                                          SizedBox(
                                            height: 280,
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ClipRRect(
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              width:
                                  SizeScreenW < 550 ? SizeScreenW * 0.90 : 450,
                              height: 550,
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeScreenW < 630 ? 30 : 60,
                                  vertical: 60),
                              decoration: BoxDecoration(
                                  //border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  gradient: darkGlassMorphismGradient()),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "LOGIN",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Please enter your credentials.",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            color: Colors.white54,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white12,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextFormField(
                                          controller: Uname,
                                          textInputAction: TextInputAction.next,
                                          style: TextStyle(
                                              fontSize: 14,
                                              height: 2.0,
                                              color: Colors.white),
                                          decoration: InputDecoration(
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsetsDirectional.only(
                                                      bottom: 5, start: 10.0),
                                              icon: Icon(
                                                Icons.email,
                                                color:
                                                    MainShade.withOpacity(0.8),
                                              ),
                                              // label: Text(
                                              //   "Email Address",
                                              //   style: TextStyle(
                                              //       color: Colors.black87),
                                              // ),
                                              hintText: "Email Address",
                                              hintStyle: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12)),
                                          validator: (value) {
                                            if (value == "") {
                                              return "Field Cannot be empty";
                                            }
                                            if (value != "") {
                                              final RegExp emailRegex = RegExp(
                                                  r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
                                              if (emailRegex
                                                  .hasMatch(value.toString())) {
                                              } else {
                                                return "Invalid Format";
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white12,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: TextFormField(
                                      controller: Upass,
                                      textInputAction: TextInputAction.next,
                                      obscureText: true,
                                      style: TextStyle(
                                          fontSize: 14,
                                          height: 2.0,
                                          color: Colors.white),
                                      decoration: InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          contentPadding:
                                              EdgeInsetsDirectional.only(
                                                  bottom: 5, start: 10.0),
                                          icon: Icon(
                                            Icons.key,
                                            color: MainShade.withOpacity(0.8),
                                          ),
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12)),
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: SizeScreenW < 600
                                        ? MainAxisAlignment.center
                                        : MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              authuser();
                                            }
                                          },
                                          // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),

                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  side: BorderSide(
                                                      color: MainShade)),
                                              backgroundColor: MainShade,
                                              elevation: 12.0,
                                              textStyle: const TextStyle(
                                                  color: Colors.red)),
                                          child: const Text(
                                            'LOGIN',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Lato",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: MainShade, width: 4),
          color: const Color.fromARGB(255, 39, 39, 39),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Image.asset(
        "assets/images/sams_logo.png",
        fit: BoxFit.contain,
      ),
    );
  }
}
