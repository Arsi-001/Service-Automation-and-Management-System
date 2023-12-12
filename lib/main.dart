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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyAH-au6V0Hdbw_rdWxB3ne3p11rvMNHBfg",
    projectId: "sams-36804",
    messagingSenderId: "903493121484",
    appId: "1:903493121484:web:d1310e8db6c3610cbb5969",
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
  final TableInfo _membertable = new TableInfo();
  final AddUser _addmember = new AddUser();
  final Dash _dash = Dash();

  Widget _showPage = new Dash();
  Widget _pageSelect(int page) {
    switch (page) {
      case 0:
        return _addmember;
      case 1:
        return _membertable;
      case 2:
        return _dash;

      default:
        return new Container(
          child: Center(
            child: Text(
              "Page Down, Sorry for the trouble",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: DarkBlu,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(NavSize),
            child: ResponsiveLayout(
              Desktop: DesktopHeader(
                callback: (index) {
                  setState(() {
                    _showPage = _pageSelect(index);
                  });
                },
              ),
              Mobile: TabHeader(),
              Tablet: TabHeader(),
            )),
        body: Dash(),
      ),
    );
  }
}
