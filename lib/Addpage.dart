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
  @override
  Widget build(BuildContext context) {
    var genders = ["Male", "Female"];

    TextEditingController fNameCont = TextEditingController();
    TextEditingController lNameCont = TextEditingController();
    TextEditingController genderCont = TextEditingController();
    TextEditingController feestatusCont = TextEditingController();
    TextEditingController numberCont = TextEditingController();
    TextEditingController startdateCont = TextEditingController();
    TextEditingController addressCont = TextEditingController();

    DateTime selectedDate = DateTime.now();

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
                                Container(
                                    height: 40,
                                    width: 100,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: DarkBlu,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Center(
                                        child: Text(
                                      "$initials" + "-" + "M-" + "3",
                                      style: TextStyle(color: Colors.white),
                                    )))
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
                                        .collection("/TGym/GYM/packages")
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
                                    fname: firstname,
                                    lname: lastname,
                                    gender: Selectedgender,
                                    package: package,
                                    platform: platform,
                                    number: number,
                                    startdate: selectedDate,
                                    address: address,
                                  );
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

  Future addMember({
    required String fname,
    required String lname,
    required String? gender,
    required String? package,
    required String? platform,
    required String number,
    required String address,
    required DateTime startdate,
  }) async {
    final docUser = FirebaseFirestore.instance
        .collection("/TGym/GYM/Members")
        .doc("TG-M-01");

    final json = {
      "First name": fname,
      "last name": lname,
      "gender": gender,
      "package": package,
      "platform": platform,
      "number": number,
      "address": address,
      "startdate": startdate,
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
