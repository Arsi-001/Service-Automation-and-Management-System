import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:s_a_m_s/Crud%20operation/Addpage.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/Responsive.dart';
import 'package:s_a_m_s/SharedComponent.dart';
import 'package:s_a_m_s/Crud%20operation/crudpopup.dart';
import 'package:s_a_m_s/Crud%20operation/popUp/pop_dialog.dart';
import 'package:s_a_m_s/Crud%20operation/popUp/updatePage.dart';
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

    return Dtable(
      sw: sw,
    );
  }
}

class Dtable extends StatelessWidget {
  Dtable({super.key, required this.sw});
  ScrollController con = ScrollController();
  final double sw;
  final CollectionReference _members =
      FirebaseFirestore.instance.collection('/TGym/GYM/Members');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 1080 - 150,
        width: 1920,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: StreamBuilder(
              stream: _members.orderBy("idnum", descending: false).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return Column(
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
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).push(
                                                    HeroDialogRoute(
                                                        builder: (context) {
                                              return const AddUser();
                                            })),
                                            // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    side: BorderSide(
                                                        color:
                                                            Colors.blueAccent)),
                                                backgroundColor: Blu,
                                                elevation: 12.0,
                                                textStyle: const TextStyle(
                                                    color: Colors.white)),
                                            child: const Text(
                                              'Add Member',
                                              style: TextStyle(
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white70,
                                                  fontSize: 12),
                                            ),
                                          ),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  TableHeaderRow(
                                    sw: sw,
                                    rowColor: Blu,
                                  ),
                                  Container(
                                      height: 400,
                                      child: ListView.builder(
                                        itemCount: streamSnapshot
                                            .data!.docs.length, //number of rows
                                        itemBuilder: (context, index) {
                                          final DocumentSnapshot
                                              documentSnapshot =
                                              streamSnapshot.data!.docs[index];
                                          return TableRow(
                                              context: context,
                                              documentsnap: documentSnapshot,
                                              membersclass: _members,
                                              rowColor: lightBlu,
                                              id: documentSnapshot["ID"],
                                              sw: sw,
                                              member: documentSnapshot[
                                                      "First name"] +
                                                  documentSnapshot["Last name"],
                                              gender:
                                                  documentSnapshot["Gender"],
                                              package:
                                                  documentSnapshot["Package"],
                                              feestatus: documentSnapshot[
                                                  "Fee Status"],
                                              platform:
                                                  documentSnapshot["Platform"],
                                              startingDate: documentSnapshot[
                                                  "Start Date"],
                                              contact: documentSnapshot[
                                                  "Phone Number"],
                                              email: documentSnapshot["Email"],
                                              address:
                                                  documentSnapshot["Address"]);
                                        },
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]);
                } else {
                  return const CircularProgressIndicator(
                    color: Colors.blue,
                  );
                }
              }),
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
  TableRow({
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
    required this.documentsnap,
    required this.context,
    required this.membersclass,
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
      context,
      documentsnap,
      membersclass,
      address;
  TextEditingController _nameController = TextEditingController();

  Future<void> _delete([String? documentSnapshotid]) async {
    await membersclass.doc(documentSnapshotid).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
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
              height: 40,
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
              Titlecolor: feestatus == "Paid" ? Colors.green : Colors.red,
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
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => _delete(documentsnap.id),
                      child: Icon(
                        UniconsLine.dollar_sign_alt,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context)
                          .push(HeroDialogRoute(builder: (context) {
                        return UpdateUser(
                          docsnap: documentsnap,
                        );
                      })),
                      icon: Icon(
                        UniconsLine.edit,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => _delete(documentsnap.id),
                      child: Icon(
                        UniconsLine.trash,
                        color: Colors.red,
                      ),
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
