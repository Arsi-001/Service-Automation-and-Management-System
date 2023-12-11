import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/Responsive.dart';
import 'package:s_a_m_s/SharedComponent.dart';
import 'package:unicons/unicons.dart';

class TableInfo extends StatefulWidget {
  const TableInfo({super.key});

  @override
  State<TableInfo> createState() => _TableInfoState();
}

class _TableInfoState extends State<TableInfo> {
  Map<String, dynamic> json = {};

  Stream<List> readmember() => FirebaseFirestore.instance
      .collection("/TGym/GYM/Members")
      .snapshots()
      .map((event) => event.docs.map((e) => json = e.data()).toList());

  ScrollController con = ScrollController();
  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;
    return StreamBuilder<Object>(
        stream: readmember(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ResponsiveLayout(
              Desktop: Dtable(
                  name: (json["First name"]),
                  gender: json["Gender"],
                  package: json["Package"],
                  feestatus: json["Fee Status"],
                  id: json["ID"],
                  platform: json["Platform"],
                  startingDate: json["Start Date"],
                  contact: json["Phone Number"],
                  email: json["Email"],
                  address: json["Email"],
                  sw: sw,
                  con: con),
              Tablet: Ttable(
                sw: sw,
                con: con,
              ),
              Mobile: Mtable(sw: sw, con: con),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class Dtable extends StatelessWidget {
  const Dtable({
    super.key,
    required this.sw,
    required this.con,
    required this.name,
    required this.gender,
    required this.package,
    required this.feestatus,
    required this.id,
    required this.platform,
    required this.startingDate,
    required this.contact,
    required this.email,
    required this.address,
  });
  final name,
      package,
      feestatus,
      gender,
      id,
      platform,
      startingDate,
      contact,
      email,
      address;
  final double sw;
  final ScrollController con;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 1080 - 150,
        width: 1920,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: sw >= 1700
                      ? 1600
                      : sw <= 1368
                          ? 1300
                          : 1400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TBInfoBubble(),
                      Expanded(flex: sw < 930 ? 0 : 1, child: SizedBox()),
                      Expanded(
                        flex: sw < 1090 ? 5 : 2,
                        child: Container(
                          height: 100,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: RoundedFuncButton(
                                    func: null,
                                    buttTxt: "ADD",
                                    buttTxtcol: Colors.white,
                                    buttbordercol: Blu,
                                    buttcol: lightBlu,
                                    buttfont: sw < 630
                                        ? sw < 300
                                            ? 8
                                            : 10
                                        : Dtxt,
                                    buttheight: DbuttonH,
                                    butticon: null,
                                    iconhere: false,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: RoundedFuncButton(
                                    func: null,
                                    buttTxt: "DELETE",
                                    buttTxtcol: Colors.white,
                                    buttbordercol: Blu,
                                    buttcol: lightBlu,
                                    buttfont: sw < 630
                                        ? sw < 300
                                            ? 8
                                            : 10
                                        : Dtxt,
                                    buttheight: DbuttonH,
                                    butticon: null,
                                    iconhere: false,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: RoundedFuncButton(
                                    func: null,
                                    buttTxt: "UPDATE",
                                    buttTxtcol: Colors.white,
                                    buttbordercol: Blu,
                                    buttcol: lightBlu,
                                    buttfont: sw < 630
                                        ? sw < 300
                                            ? 8
                                            : 10
                                        : Dtxt,
                                    buttheight: DbuttonH,
                                    butticon: null,
                                    iconhere: false,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: RoundedFuncButton(
                                    func: null,
                                    buttTxt: "SEARCH MEMBER",
                                    buttTxtcol: Colors.white,
                                    buttbordercol: Blu,
                                    buttcol: lightBlu,
                                    buttfont: sw < 630
                                        ? sw < 300
                                            ? 8
                                            : 10
                                        : Dtxt,
                                    buttheight: DbuttonH,
                                    butticon: null,
                                    iconhere: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RawScrollbar(
                  thickness: 10,
                  thumbColor: Blu,
                  trackColor: Colors.white12,
                  trackBorderColor: Colors.white30,
                  thumbVisibility: true,
                  trackVisibility: true,
                  controller: con,
                  child: SingleChildScrollView(
                    controller: con,
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 500,
                      width: sw >= 1700
                          ? 1600
                          : sw <= 1368
                              ? 1300
                              : 1400,
                      decoration: BoxDecoration(
                          color: lightBlu,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          TableHeaderRow(
                            sw: sw,
                            rowColor: Blu,
                          ),
                          Container(
                            height: 420,
                            child: ListView(
                              children: [
                                TableRow(
                                  sw: sw,
                                  id: id,
                                  member: name,
                                  gender: gender,
                                  package: package,
                                  feestatus: feestatus,
                                  platform: platform,
                                  startingDate: startingDate,
                                  contact: contact,
                                  email: email,
                                  address: email,
                                  rowColor: Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

class Ttable extends StatelessWidget {
  const Ttable({
    super.key,
    required this.sw,
    required this.con,
  });

  final double sw;
  final ScrollController con;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 1920,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TBInfoBubble(),
                    Expanded(flex: sw < 930 ? 0 : 1, child: SizedBox()),
                    Expanded(
                      flex: sw < 1090 ? 5 : 2,
                      child: Container(
                        height: 200,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RoundedFuncButton(
                                      func: null,
                                      buttTxt: "ADD",
                                      buttTxtcol: Colors.white,
                                      buttbordercol: Blu,
                                      buttcol: lightBlu,
                                      buttfont: sw < 630
                                          ? sw < 300
                                              ? 8
                                              : 10
                                          : Dtxt,
                                      buttheight: DbuttonH,
                                      butticon: null,
                                      iconhere: false,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RoundedFuncButton(
                                      func: null,
                                      buttTxt: "DELETE",
                                      buttTxtcol: Colors.white,
                                      buttbordercol: Blu,
                                      buttcol: lightBlu,
                                      buttfont: sw < 630
                                          ? sw < 300
                                              ? 8
                                              : 10
                                          : Dtxt,
                                      buttheight: DbuttonH,
                                      butticon: null,
                                      iconhere: false,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RoundedFuncButton(
                                      func: null,
                                      buttTxt: "UPDATE",
                                      buttTxtcol: Colors.white,
                                      buttbordercol: Blu,
                                      buttcol: lightBlu,
                                      buttfont: sw < 630
                                          ? sw < 300
                                              ? 8
                                              : 10
                                          : Dtxt,
                                      buttheight: DbuttonH,
                                      butticon: null,
                                      iconhere: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RoundedFuncButton(
                                  func: null,
                                  buttTxt: "SEARCH",
                                  buttTxtcol: Colors.white,
                                  buttbordercol: Blu,
                                  buttcol: lightBlu,
                                  buttfont: sw < 630
                                      ? sw < 300
                                          ? 8
                                          : 10
                                      : Dtxt,
                                  buttheight: DbuttonH,
                                  butticon: null,
                                  iconhere: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                RawScrollbar(
                  thickness: 10,
                  thumbColor: Blu,
                  trackColor: Colors.white12,
                  trackBorderColor: Colors.white30,
                  thumbVisibility: true,
                  trackVisibility: true,
                  controller: con,
                  child: SingleChildScrollView(
                    controller: con,
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: sw >= 1700
                          ? 1600
                          : sw <= 1368
                              ? 1300
                              : 1400,
                      decoration: BoxDecoration(
                          color: lightBlu,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          TableHeaderRow(
                            sw: sw,
                            rowColor: Blu,
                          ),
                          Container(
                            height: 420,
                            child: ListView(
                              children: [
                                TableRow(
                                  sw: sw,
                                  id: "TG-M-001",
                                  member: "ARSALAN AAMIR",
                                  gender: "MALE",
                                  package: "GOLD",
                                  feestatus: "UNPAID",
                                  platform: "GYM",
                                  startingDate: "02-12-2022",
                                  contact: "03222321683",
                                  email: "arsalnaamir@gmail.com",
                                  address:
                                      "Flat 30-H, Askari V, Malir cantt, Karachi, Paksitan",
                                  rowColor: Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

class Mtable extends StatelessWidget {
  const Mtable({
    super.key,
    required this.sw,
    required this.con,
  });

  final double sw;
  final ScrollController con;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 1920,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TBInfoBubble(),
                    Container(
                      height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RoundedFuncButton(
                                      func: null,
                                      buttTxt: "ADD",
                                      buttTxtcol: Colors.white,
                                      buttbordercol: Blu,
                                      buttcol: lightBlu,
                                      buttfont: sw < 630
                                          ? sw < 300
                                              ? 8
                                              : 10
                                          : Dtxt,
                                      buttheight: DbuttonH,
                                      butticon: null,
                                      iconhere: false,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RoundedFuncButton(
                                      func: null,
                                      buttTxt: "DELETE",
                                      buttTxtcol: Colors.white,
                                      buttbordercol: Blu,
                                      buttcol: lightBlu,
                                      buttfont: sw < 630
                                          ? sw < 300
                                              ? 8
                                              : 10
                                          : Dtxt,
                                      buttheight: DbuttonH,
                                      butticon: null,
                                      iconhere: false,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RoundedFuncButton(
                                      func: null,
                                      buttTxt: "UPDATE",
                                      buttTxtcol: Colors.white,
                                      buttbordercol: Blu,
                                      buttcol: lightBlu,
                                      buttfont: sw < 630
                                          ? sw < 300
                                              ? 8
                                              : 10
                                          : Dtxt,
                                      buttheight: DbuttonH,
                                      butticon: null,
                                      iconhere: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RoundedFuncButton(
                              func: null,
                              buttTxt: "SEARCH MEMBER",
                              buttTxtcol: Colors.white,
                              buttbordercol: Blu,
                              buttcol: lightBlu,
                              buttfont: sw < 630
                                  ? sw < 300
                                      ? 8
                                      : 10
                                  : Dtxt,
                              buttheight: DbuttonH,
                              butticon: null,
                              iconhere: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                RawScrollbar(
                  thickness: 10,
                  thumbColor: Blu,
                  trackColor: Colors.white12,
                  trackBorderColor: Colors.white30,
                  thumbVisibility: true,
                  trackVisibility: true,
                  controller: con,
                  child: SingleChildScrollView(
                    controller: con,
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: sw >= 1700
                          ? 1600
                          : sw <= 1368
                              ? 1300
                              : 1400,
                      decoration: BoxDecoration(
                          color: lightBlu,
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      child: Column(
                        children: [
                          TableHeaderRow(
                            sw: sw,
                            rowColor: Blu,
                          ),
                          Container(
                            height: 420,
                            child: ListView(
                              children: [
                                TableRow(
                                  sw: sw,
                                  id: "TG-M-001",
                                  member: "ARSALAN AAMIR",
                                  gender: "MALE",
                                  package: "GOLD",
                                  feestatus: "UNPAID",
                                  platform: "GYM",
                                  startingDate: "02-12-2022",
                                  contact: "03222321683",
                                  email: "arsalnaamir@gmail.com",
                                  address:
                                      "Flat 30-H, Askari V, Malir cantt, Karachi, Paksitan",
                                  rowColor: Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

class TBInfoBubble extends StatelessWidget {
  const TBInfoBubble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 350,
      decoration: BoxDecoration(
          color: Blu, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            UniconsLine.dumbbell,
            size: 60,
            color: DarkBlu,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "250",
            style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w200,
                color: DarkBlu,
                letterSpacing: 5,
                fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "MEMBERS",
            style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
                color: DarkBlu,
                letterSpacing: 5,
                fontSize: 16),
          )
        ],
      ),
    );
  }
}

class TableHeaderRow extends StatelessWidget {
  const TableHeaderRow({
    super.key,
    required this.rowColor,
    required this.sw,
  });
  final rowColor, sw;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sw < 630 ? 40 : 60,
      decoration: BoxDecoration(
          color: rowColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(0))),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              child: const TableCell(
                LineTru: true,
                Titlecolor: Colors.white70,
                Title: "ID",
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              //  padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const TableCell(
                LineTru: true,
                Titlecolor: Colors.white70,
                Title: "MEMBER",
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: "GENDER",
            ),
          ),
          const Expanded(
            flex: 1,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: "PACKAGE",
            ),
          ),
          const Expanded(
            flex: 1,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: "FEE STATUS",
            ),
          ),
          const Expanded(
            flex: 1,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: "PLATFORM",
            ),
          ),
          const Expanded(
            flex: 1,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: "NUMBER",
            ),
          ),
          const Expanded(
            flex: 1,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: "STARTING DATE",
            ),
          ),
          const Expanded(
            flex: 2,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: "ADDRESS",
            ),
          ),
          const Expanded(
            flex: 1,
            child: TableCell(
              LineTru: false,
              Titlecolor: Colors.white70,
              Title: "ACTION",
            ),
          ),
        ],
      ),
    );
  }
}

class TableRow extends StatelessWidget {
  const TableRow({
    super.key,
    required this.rowColor,
    required this.id,
    required this.member,
    required this.gender,
    required this.package,
    required this.feestatus,
    required this.platform,
    required this.startingDate,
    required this.contact,
    required this.email,
    required this.sw,
    required this.address,
  });
  final rowColor,
      id,
      sw,
      member,
      gender,
      package,
      feestatus,
      platform,
      startingDate,
      contact,
      email,
      address;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sw < 630 ? 50 : 80,
      width: 100,
      decoration: BoxDecoration(
        border:
            const Border(bottom: BorderSide(color: Colors.white24, width: 0.5)),
        color: rowColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: sw < 630 ? 30 : 50,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              decoration: const BoxDecoration(
                  color: Blu,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(10))),
              child: Center(
                child: TableCell(
                  LineTru: false,
                  Titlecolor: Colors.white70,
                  Title: id,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TableCell(
                LineTru: true,
                Titlecolor: Colors.white70,
                Title: member,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: gender,
            ),
          ),
          Expanded(
            flex: 1,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: package,
            ),
          ),
          Expanded(
            flex: 1,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.red,
              Title: feestatus,
            ),
          ),
          Expanded(
            flex: 1,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: platform,
            ),
          ),
          Expanded(
            flex: 1,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: contact,
            ),
          ),
          Expanded(
            flex: 1,
            child: TableCell(
              LineTru: true,
              Titlecolor: Colors.white70,
              Title: startingDate,
            ),
          ),
          Expanded(
            flex: 2,
            child: TableCell(
              LineTru: false,
              Titlecolor: Colors.white70,
              Title: address,
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      UniconsLine.edit,
                      color: Colors.white70,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      UniconsLine.trash,
                      color: Colors.red,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class TableCell extends StatelessWidget {
  const TableCell({
    super.key,
    required this.Titlecolor,
    required this.Title,
    required this.LineTru,
  });
  final Title, Titlecolor, LineTru;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          border: LineTru
              ? const Border(right: BorderSide(color: Colors.white12))
              : null),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          Title,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: Titlecolor,
              overflow: TextOverflow.fade,
              fontSize: 12),
        ),
      ),
    );
  }
}
