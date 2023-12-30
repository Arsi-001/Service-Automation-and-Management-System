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
import 'package:s_a_m_s/alt_Dash.dart';
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
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
        ),
        primaryColor: Colors.white,
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(
          seedColor: MainShade,

          // ···
          brightness: Brightness.light,
        ),
      ),
      navigatorKey: navigatorKey,
      scrollBehavior: MyCustomScrollBehavior(),
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale =
            mediaQueryData.copyWith(textScaler: const TextScaler.linear(1.0));
        return MediaQuery(
          data: scale,
          child: child!,
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
  final AltDash _altDash = const AltDash();
  final Dash _dash = const Dash();

  final user = FirebaseAuth.instance.currentUser!;
  Future getcolname() async {
    try {
      var colName = await FirebaseFirestore.instance
          .collection("ClientLoginInfo")
          .where("uid", isEqualTo: user.uid.toString())
          .get();
      colname = colName.docs.first["collectionName"];
      clientName = colName.docs.first["clientName"];
      initials = colName.docs.first["initials"];
      return colName.docs.first;
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

  Widget _showPage = new AltDash();
  Widget _pageSelect(int page) {
    switch (page) {
      case 1:
        return _membertable;
      case 2:
        return _altDash;

      default:
        return SizedBox(
          height: 500,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Logo(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Pages In Progress!",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 24),
                ),
              ],
            ),
          ),
        );
        ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: getcolname(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(colname);
              print("this:" + "$initials");
              return Scaffold(
                backgroundColor: DarkShade,
                // appBar: PreferredSize(
                //     preferredSize: const Size.fromHeight(NavSize),
                //     child: ResponsiveLayout(
                //       Desktop: DesktopHeader(
                //         colname: "snapshot.data",
                //         callback: (index) {
                //           setState(() {
                //             _showPage = _pageSelect(index);
                //           });
                //         },
                //       ),
                //       Mobile: const Center(),
                //       Tablet: const Center(),
                //     )),
                body: SingleChildScrollView(
                  child: SizedBox(
                    height: 1080,
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: multigradient,
                          ),
                        ),
                        Column(
                          children: [
                            DesktopHeader(
                                colname: "snapshot.data",
                                callback: (index) {
                                  setState(() {
                                    _showPage = _pageSelect(index);
                                  });
                                }),
                            ResponsiveLayout(
                              Desktop: _showPage,
                              Mobile: Placeholder(),
                              Tablet: Placeholder(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return ProgressBar();
            }
          }),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkShade,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Logo(),
          SizedBox(
            height: 30,
          ),
          CircularProgressIndicator(
            color: MainShade,
          )
        ]),
      ),
    );
  }
}
