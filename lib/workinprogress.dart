import 'package:flutter/material.dart';
import 'package:s_a_m_s/login.dart';

class Placeholder extends StatelessWidget {
  const Placeholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logo(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Pages In Progress!",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Montserrat", fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
