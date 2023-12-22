import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:s_a_m_s/Crud%20operation/Addpage.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/Dashboard.dart';
import 'package:s_a_m_s/Splashscreen.dart';
import 'package:s_a_m_s/Table/MemberTable.dart';
import 'package:s_a_m_s/Table/StaffTable.dart';
import 'package:s_a_m_s/header/DHeader.dart';
import 'package:s_a_m_s/Responsive.dart';

import 'package:s_a_m_s/login.dart';
import 'package:schedulers/schedulers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyAH-au6V0Hdbw_rdWxB3ne3p11rvMNHBfg",
    projectId: "sams-36804",
    messagingSenderId: "903493121484",
    appId: "1:903493121484:web:d1310e8db6c3610cbb5969",
  ));

  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();
final formKey = GlobalKey<FormState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      navigatorKey: navigatorKey,
      scrollBehavior: MyCustomScrollBehavior(),
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.copyWith(textScaleFactor: 1.0);
        return MediaQuery(
          child: child!,
          data: scale,
        );
      },
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Something Went Wrong!, Please Try Again",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              );
            } else if (snapshot.hasData) {
              if (Splashon) {
                return const Splash();
              } else {
                return const Homepage();
              }
            } else {
              return const LoginPage();
            }
          }),
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
  final TableInfo _membertable = const TableInfo();
  final StaffTableInfo _stafftable = const StaffTableInfo();
  final Dash _dash = const Dash();

  final user = FirebaseAuth.instance.currentUser!;
  Future getcolname() async {
    try {
      var colName = await FirebaseFirestore.instance
          .collection("ClientLoginInfo")
          .where("uid", isEqualTo: user.uid.toString())
          .get();

      return colName.docs.first["collectionName"];
    } catch (e) {
      return "   no found    ";
    }
  }

  @override
  void initState() {
    setState(() {
      Splashon = false;
    });
    super.initState();
  }

  Widget _showPage = new Dash();
  Widget _pageSelect(int page) {
    switch (page) {
      case 0:
        return Placeholder();
      case 1:
        return _membertable;
      case 2:
        return _dash;
      case 3:
        return Placeholder();

      default:
        return Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: getcolname(),
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: DarkBlu,
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(NavSize),
                  child: ResponsiveLayout(
                    Desktop: DesktopHeader(
                      colname: "snapshot.data",
                      callback: (index) {
                        setState(() {
                          _showPage = _pageSelect(index);
                        });
                      },
                    ),
                    Mobile: const Center(),
                    Tablet: const Center(),
                  )),
              body: ResponsiveLayout(
                Desktop: _showPage,
                Mobile: Placeholder(),
                Tablet: Placeholder(),
              ),
            );
          }),
    );
  }
}
