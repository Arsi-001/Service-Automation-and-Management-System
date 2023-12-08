import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:s_a_m_s/Addpage.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/Dashboard.dart';
import 'package:s_a_m_s/header/DHeader.dart';
import 'package:s_a_m_s/Responsive.dart';

import 'package:s_a_m_s/Table.dart';
import 'package:s_a_m_s/header/THeader.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyAeLzJRkfSHYwjupVt96SlnNTMez3yb2r4",
    projectId: "sams-6df51",
    messagingSenderId: "182839233683",
    appId: "1:182839233683:web:4facdc2b8923c45f3e5166",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.copyWith(textScaleFactor: 1.0);
        return MediaQuery(
          child: child!,
          data: scale,
        );
      },
      home: const Homepage(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: DarkBlu,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(NavSize),
            child: ResponsiveLayout(
              Desktop: DesktopHeader(),
              Mobile: TabHeader(),
              Tablet: TabHeader(),
            )),
        body: AddUser(),
      ),
    );
  }
}
