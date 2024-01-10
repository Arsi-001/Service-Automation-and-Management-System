import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/SharedComponent.dart';

class UpdateUser extends StatefulWidget {
  var docsnap;
  final Mode;
  UpdateUser({super.key, required this.docsnap, required this.Mode});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  String? Selectedgender = "Male";
  String? selectedpackage = "0";
  String? selectedplatform = "0";
  String initials = "";
  TextEditingController fNameCont = TextEditingController();
  TextEditingController lNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController numberCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
  TextEditingController ageCont = TextEditingController();
  TextEditingController desigCont = TextEditingController();
  var genders = ["Male", "Female"];

  late DateTime selectedDate;
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  int userIDnum = 0;
  String userID = "";

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
    selectedplatform = widget.docsnap["Platform"];
    selectedpackage = widget.Mode == "S"
        ? widget.docsnap["Designation"]
        : widget.docsnap["Package"];
    widget.Mode == "S" ? desigCont.text = widget.docsnap["Designation"] : "";
    Selectedgender = widget.docsnap["Gender"];
    fNameCont.text = widget.docsnap["First name"];
    lNameCont.text = widget.docsnap["Last name"];
    emailCont.text = widget.docsnap["Email"];
    addressCont.text = widget.docsnap["Address"];
    numberCont.text = widget.docsnap["Phone Number"];
    ageCont.text = widget.docsnap["Age"];
    selectedDate = (widget.docsnap['Date'] as Timestamp).toDate();
    ;
    super.initState();
  }

  @override
  void dispose() {
    fNameCont.dispose();
    lNameCont.dispose();
    emailCont.dispose();
    numberCont.dispose();
    addressCont.dispose();
    desigCont.dispose();

    ageCont.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Center(
        child: Hero(
          tag: heroAddTodo,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: SizedBox(
                height: 700,
                width: 1100,
                child: Material(
                  color: Colors.black87.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Column(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 40),
                                decoration: BoxDecoration(
                                    border: Border.all(color: MainShade),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Text(
                                                "Member ID",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.white12,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Center(
                                                child: Text(
                                                  widget.docsnap.id,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        crudTxtfield(
                                          txtinput: TextInputType.text,
                                          format: [
                                            FilteringTextInputFormatter
                                                .singleLineFormatter
                                          ],
                                          widht: 250,
                                          title: "First Name",
                                          controller: fNameCont,
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        crudTxtfield(
                                          txtinput: TextInputType.text,
                                          format: [
                                            FilteringTextInputFormatter
                                                .singleLineFormatter
                                          ],
                                          widht: 250,
                                          title: "Last Name",
                                          controller: lNameCont,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        crudTxtfield(
                                          txtinput: TextInputType.number,
                                          format: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          widht: 250,
                                          title: "Number",
                                          controller: numberCont,
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        crudTxtfield(
                                          txtinput: TextInputType.emailAddress,
                                          format: [
                                            FilteringTextInputFormatter
                                                .singleLineFormatter
                                          ],
                                          widht: 250,
                                          title: "Email",
                                          controller: emailCont,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        crudTxtfield(
                                          txtinput: TextInputType.text,
                                          format: [
                                            FilteringTextInputFormatter
                                                .singleLineFormatter
                                          ],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        crudTxtfield(
                                          txtinput: TextInputType.text,
                                          format: [
                                            FilteringTextInputFormatter
                                                .singleLineFormatter
                                          ],
                                          widht: 175,
                                          title: "Age",
                                          controller: ageCont,
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        widget.Mode == "S"
                                            ? crudTxtfield(
                                                title: "Designation",
                                                widht: 250,
                                                controller: desigCont,
                                                txtinput: TextInputType.text,
                                                format: [
                                                  FilteringTextInputFormatter
                                                      .singleLineFormatter
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Package",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "/$colname/$clientplat/Packages")
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        List<DropdownMenuItem>
                                                            packageslist = [];
                                                        if (!snapshot.hasData) {
                                                          return CircularProgressIndicator();
                                                        } else {
                                                          final packages =
                                                              snapshot
                                                                  .data?.docs
                                                                  .toList();

                                                          packageslist.add(
                                                              DropdownMenuItem(
                                                                  value: "0",
                                                                  child: Text(
                                                                      "Select Package")));
                                                          for (var data
                                                              in packages!) {
                                                            packageslist.add(
                                                                DropdownMenuItem(
                                                                    value: data[
                                                                        "name"],
                                                                    child: Text(
                                                                      data[
                                                                          "name"],
                                                                    )));
                                                          }
                                                        }
                                                        return Container(
                                                          height: 50,
                                                          width: 175,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .white12,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                          child: Center(
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButtonFormField(
                                                                decoration:
                                                                    InputDecoration(
                                                                        border: InputBorder
                                                                            .none,
                                                                        errorMaxLines:
                                                                            1,
                                                                        errorStyle:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                        )),
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                      "0") {
                                                                    return "Please select a valid option";
                                                                  }
                                                                },
                                                                value:
                                                                    selectedpackage,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                                items:
                                                                    packageslist,
                                                                dropdownColor:
                                                                    Colors
                                                                        .white12,
                                                                onChanged:
                                                                    (clientvalue) {
                                                                  setState(() {
                                                                    selectedpackage =
                                                                        clientvalue;
                                                                  });
                                                                },
                                                              ),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Platform",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("/$colname")
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  List<DropdownMenuItem>
                                                      packageslist = [];
                                                  if (!snapshot.hasData) {
                                                    return CircularProgressIndicator();
                                                  } else {
                                                    final packages = snapshot
                                                        .data?.docs.reversed
                                                        .toList();
                                                    for (var data
                                                        in packages!) {
                                                      packageslist.add(
                                                          DropdownMenuItem(
                                                              value: "0",
                                                              child: Text(
                                                                  "Select Platform")));
                                                      packageslist.add(
                                                          DropdownMenuItem(
                                                              value: data.id,
                                                              child: Text(
                                                                  data.id)));
                                                    }
                                                  }
                                                  return Container(
                                                    height: 50,
                                                    width: 175,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white12,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                errorMaxLines:
                                                                    1,
                                                                errorStyle:
                                                                    TextStyle(
                                                                  fontSize: 10,
                                                                )),
                                                        validator: (value) {
                                                          if (value == "0") {
                                                            return "Please select a valid option";
                                                          }
                                                        },
                                                        dropdownColor:
                                                            Colors.white12,
                                                        value: selectedplatform,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        items: packageslist,
                                                        onChanged:
                                                            (clientvalue) {
                                                          setState(() {
                                                            selectedplatform =
                                                                clientvalue;
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Starting Date",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Container(
                                              width: 175,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: Colors.white12,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white12),
                                                onPressed: () =>
                                                    _selectDate(context),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "${selectedDate.toLocal()}"
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Gender",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 175,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white12,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  dropdownColor: Colors.white12,
                                                  value: Selectedgender,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  items: genders
                                                      .map((String items) {
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                final firstname =
                                                    fNameCont.text;

                                                final lastname = lNameCont.text;

                                                final package = selectedpackage;
                                                final designation =
                                                    desigCont.text;
                                                final platform =
                                                    selectedplatform;
                                                final number = numberCont.text;

                                                final address =
                                                    addressCont.text;

                                                final email = emailCont.text;
                                                final selectD = dateFormat
                                                    .format(selectedDate);

                                                widget.Mode == "S"
                                                    ? updateStaff(
                                                        time: "6:00 PM",
                                                        age: ageCont.text,
                                                        email: email,
                                                        idnum: userIDnum,
                                                        id: widget.docsnap.id,
                                                        fname: firstname,
                                                        lname: lastname,
                                                        gender: Selectedgender,
                                                        desig: designation,
                                                        platform: platform,
                                                        number: number,
                                                        startdate: selectD,
                                                        address: address,
                                                        date: selectedDate)
                                                    : updateMember(
                                                        age: ageCont.text,
                                                        email: email,
                                                        idnum: userIDnum,
                                                        id: widget.docsnap.id,
                                                        fname: firstname,
                                                        lname: lastname,
                                                        gender: Selectedgender,
                                                        package: package,
                                                        platform: platform,
                                                        number: number,
                                                        startdate: selectD,
                                                        address: address,
                                                        date: selectedDate);

                                                setState(() {});
                                                Navigator.pop(context);
                                              }
                                            },
                                            // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),

                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: MainShade,
                                                elevation: 12.0,
                                                textStyle: const TextStyle(
                                                    color: Colors.white)),
                                            child: const Text('Update Member'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 219, 15, 0),
                                                elevation: 12.0,
                                                textStyle: const TextStyle(
                                                    color: Colors.white)),
                                            child: const Text('Cancel'),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future updateStaff(
      {required String fname,
      required String lname,
      required String email,
      required String? gender,
      required String desig,
      required String? platform,
      required String number,
      required String address,
      required String startdate,
      required String age,
      required DateTime date,
      required time,
      required id,
      required idnum}) async {
    final docUser = FirebaseFirestore.instance
        .collection("/$colname/$clientplat/Staff")
        .doc(id);

    final json = {
      "Fee Status": "Paid",
      "First name": fname,
      "Last name": lname,
      "Gender": gender,
      "Age": age,
      "Designation": desig,
      "Platform": platform,
      "Phone Number": number,
      "Email": email,
      "Address": address,
      "Start Date": startdate,
      "Start Time": time,
      "Date": date
    };
    await docUser.update(json);
  }

  Future updateMember(
      {required String fname,
      required String lname,
      required String email,
      required String? gender,
      required String? package,
      required String? platform,
      required String number,
      required String address,
      required String startdate,
      required String age,
      required DateTime date,
      required id,
      required idnum}) async {
    final docUser = FirebaseFirestore.instance
        .collection("/$colname/$clientplat/Members")
        .doc(id);

    final json = {
      "Fee Status": "Paid",
      "First name": fname,
      "Last name": lname,
      "Gender": gender,
      "Age": age,
      "Package": package,
      "Platform": platform,
      "Phone Number": number,
      "Email": email,
      "Address": address,
      "Start Date": startdate,
      "Date": date
    };
    await docUser.update(json);
  }
}
