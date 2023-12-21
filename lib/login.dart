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
        backgroundColor: DarkBlu,
        body: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Blu,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Icon(
                      Icons.toys_outlined,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Service Automation And Management System",
                      style: TextStyle(
                          fontSize: 24,
                          //  fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: "Montserrat"),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 380,
                    height: 400,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    decoration: BoxDecoration(
                        color: lightBlu,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                          ],
                        ),
                        Container(
                          child: TextFormField(
                            controller: Uname,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                                fontSize: 14, height: 2.0, color: Colors.white),
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.blue,
                                ),
                                label: Text(
                                  "Email Address",
                                  style: TextStyle(color: Colors.white70),
                                ),
                                hintText: "johndoe@gmail.com",
                                hintStyle: TextStyle(
                                    color: Colors.white30, fontSize: 10)),
                            validator: (value) {
                              if (value == "") {
                                return "Field Cannot be empty";
                              }
                              if (value != "") {
                                final RegExp emailRegex = RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
                                if (emailRegex.hasMatch(value.toString())) {
                                } else {
                                  return "Invalid Format";
                                }
                              }
                            },
                          ),
                        ),
                        TextFormField(
                          controller: Upass,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          style: TextStyle(
                              fontSize: 14, height: 2.0, color: Colors.white),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.key,
                              color: Colors.blue,
                            ),
                            label: Text(
                              "Password",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                authuser();
                              }
                            },
                            // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),

                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(color: Colors.blueAccent)),
                                backgroundColor: Blu,
                                elevation: 12.0,
                                textStyle: const TextStyle(color: Colors.red)),
                            child: const Text('LOGIN'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
