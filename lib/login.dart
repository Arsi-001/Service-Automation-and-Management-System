import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:s_a_m_s/Addpage.dart';
import 'package:s_a_m_s/Constant.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController Uname = new TextEditingController();
    TextEditingController Upass = new TextEditingController();

    return Scaffold(
      backgroundColor: DarkBlu,
      body: Center(
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  image: AssetImage("xcxcx"),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
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
                  crudTxtfield(
                    title: "Username",
                    widht: 340,
                    controller: Uname,
                    txtinput: TextInputType.text,
                    format: [FilteringTextInputFormatter.singleLineFormatter],
                  ),
                  crudTxtfield(
                    title: "Password",
                    widht: 340,
                    controller: Upass,
                    txtinput: TextInputType.text,
                    format: [FilteringTextInputFormatter.singleLineFormatter],
                  ),
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: ElevatedButton(
                      onPressed: () {},
                      // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),

                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color: Colors.blueAccent)),
                          backgroundColor: Blu,
                          elevation: 12.0,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text('LOGIN'),
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
