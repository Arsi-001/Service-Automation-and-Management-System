import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:s_a_m_s/Constant.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  String? Selectedgender = "Male";
  String? selectedpackage = "0";
  String? selectedplatform = "0";
  String initials = "";
  TextEditingController fNameCont = TextEditingController();
  TextEditingController lNameCont = TextEditingController();
  TextEditingController genderCont = TextEditingController();
  TextEditingController feestatusCont = TextEditingController();
  TextEditingController numberCont = TextEditingController();
  TextEditingController startdateCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
  var genders = ["Male", "Female"];

  DateTime selectedDate = DateTime.now();
  String userIDnum = "";
  String userID = "";
  Future<String?> getID() async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('TGym').doc("GYM").get();

      var snap = await FirebaseFirestore.instance
          .collection('/TGym/GYM/Members')
          .get();
      var mID = snap.docs.last.id;
      var finalID = snapshot.get("initials") + "-M-";
      userIDnum = mID;
      userID = finalID;

      // Check if the document exists
      if (snapshot.exists) {
        // Extract the specific field you want (replace 'your_field' with the actual field name)
        return finalID + (int.parse(mID) + 1).toString();
      } else {
        return null; // Document doesn't exist
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null; // Handle errors
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 180, vertical: 40),
      child: Center(
        child: Column(
          children: [
            Expanded(
                child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                    decoration: BoxDecoration(
                        color: lightBlu,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Member ID",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                FutureBuilder<String?>(
                                    future: getID(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else if (snapshot.data == null) {
                                        return Text(
                                            'ID not found or field is null.');
                                      } else {
                                        return Container(
                                          height: 40,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: DarkBlu,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Center(
                                            child: Text(
                                              '${snapshot.data}',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      }
                                    })
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            crudTxtfield(
                              widht: 250,
                              title: "First Name",
                              controller: fNameCont,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            crudTxtfield(
                              widht: 250,
                              title: "Last Name",
                              controller: lNameCont,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            crudTxtfield(
                              widht: 250,
                              title: "Number",
                              controller: numberCont,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            crudTxtfield(
                              widht: 250,
                              title: "Email",
                              controller: startdateCont,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            crudTxtfield(
                              widht: 540,
                              title: "Address",
                              controller: addressCont,
                            ),
                            SizedBox(
                              width: 40,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Package",
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  height: 6,
                                ),
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("/TGym/GYM/Packages")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      List<DropdownMenuItem> packageslist = [];
                                      if (!snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      } else {
                                        final packages =
                                            snapshot.data?.docs.toList();

                                        packageslist.add(DropdownMenuItem(
                                            value: "0",
                                            child: Text("Select Package")));
                                        for (var data in packages!) {
                                          packageslist.add(DropdownMenuItem(
                                              value: data.id,
                                              child: Text(
                                                data["name"],
                                              )));
                                        }
                                      }
                                      return Container(
                                        height: 40,
                                        width: 175,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                            color: DarkBlu,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            value: selectedpackage,
                                            style:
                                                TextStyle(color: Colors.white),
                                            items: packageslist,
                                            dropdownColor: DarkBlu,
                                            onChanged: (clientvalue) {
                                              setState(() {
                                                selectedpackage = clientvalue;
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Platform",
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  height: 6,
                                ),
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("/TGym")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      List<DropdownMenuItem> packageslist = [];
                                      if (!snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      } else {
                                        final packages = snapshot
                                            .data?.docs.reversed
                                            .toList();
                                        for (var data in packages!) {
                                          packageslist.add(DropdownMenuItem(
                                              value: "0",
                                              child: Text("Select Platform")));
                                          packageslist.add(DropdownMenuItem(
                                              value: data.id,
                                              child: Text(data.id)));
                                        }
                                      }
                                      return Container(
                                        height: 40,
                                        width: 175,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                            color: DarkBlu,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            dropdownColor: DarkBlu,
                                            value: selectedplatform,
                                            style:
                                                TextStyle(color: Colors.white),
                                            items: packageslist,
                                            onChanged: (clientvalue) {
                                              setState(() {
                                                selectedplatform = clientvalue;
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Starting Date",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Container(
                                  width: 175,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: DarkBlu,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: DarkBlu),
                                    onPressed: () => _selectDate(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${selectedDate.toLocal()}"
                                            .split(' ')[0]),
                                        Icon(
                                          Icons.calendar_month,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Gender",
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  height: 6,
                                ),
                                Container(
                                  height: 40,
                                  width: 175,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: DarkBlu,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      dropdownColor: DarkBlu,
                                      value: Selectedgender,
                                      style: TextStyle(color: Colors.white),
                                      items: genders.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          Selectedgender = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: ElevatedButton(
                                onPressed: () {
                                  final firstname = fNameCont.text;
                                  fNameCont.clear();
                                  final lastname = lNameCont.text;
                                  lNameCont.clear();

                                  final package = selectedpackage;

                                  final platform = selectedplatform;
                                  final number = numberCont.text;

                                  final address = addressCont.text;

                                  addMember(
                                    idnum: userIDnum,
                                    id: userID,
                                    fname: firstname,
                                    lname: lastname,
                                    gender: Selectedgender,
                                    package: package,
                                    platform: platform,
                                    number: number,
                                    startdate: selectedDate,
                                    address: address,
                                  );
                                  setState(() {});
                                },
                                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),

                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Blu,
                                    elevation: 12.0,
                                    textStyle:
                                        const TextStyle(color: Colors.white)),
                                child: const Text('Add Member'),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: ElevatedButton(
                                onPressed: () {},
                                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 219, 15, 0),
                                    elevation: 12.0,
                                    textStyle:
                                        const TextStyle(color: Colors.white)),
                                child: const Text('Cancel'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Future addMember(
      {required String fname,
      required String lname,
      required String? gender,
      required String? package,
      required String? platform,
      required String number,
      required String address,
      required DateTime startdate,
      required id,
      required idnum}) async {
    final docUser = FirebaseFirestore.instance
        .collection("/TGym/GYM/Members")
        .doc((int.parse(idnum) + 1).toString());

    final json = {
      "ID": id + (int.parse(idnum) + 1).toString(),
      "Fee Status": "Paid",
      "First name": fname,
      "Last name": lname,
      "Gender": gender,
      "Package": package,
      "Platform": platform,
      "Phone Number": number,
      "Email": "email",
      "Address": address,
      "Start Date": "startdate",
    };
    await docUser.set(json);
  }
}

class crudTxtfield extends StatelessWidget {
  final controller;
  final title;
  final widht;
  crudTxtfield({
    required this.title,
    required this.widht,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          height: 40,
          width: widht,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: DarkBlu,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextField(
            controller: controller,
            cursorColor: Blu,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
