import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/SharedComponent.dart';

class AddUser extends StatefulWidget {
  AddUser(
      {super.key,
      required this.mode,
      required this.modeletter,
      required this.colref});
  final mode, modeletter, colref;
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  String? Selectedgender = "Male";
  String? selectedpackage = "0";
  String? selectedplatform = "0";

  TextEditingController fNameCont = TextEditingController();
  TextEditingController lNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController numberCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
  TextEditingController ageCont = TextEditingController();
  TextEditingController desigCont = TextEditingController();

  var genders = ["Male", "Female"];

  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  int userIDnum = 0;
  String userID = "";
  Future<String?> getID() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('$colname')
          .doc("$clientplat")
          .get();

      var snap = await widget.colref.orderBy("idnum", descending: false).get();
      var mID = 0;
      if (snap.size != 0) {
        mID = snap.docs.last["idnum"];
      }

      var finalID = initials! + "-" + "${widget.modeletter}" + "-";
      userIDnum = mID;
      userID = finalID;

      // Check if the document exists
      if (snapshot.exists) {
        // Extract the specific field you want (replace 'your_field' with the actual field name)
        return finalID + (mID + 1).toString();
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

  final _formKey = GlobalKey<FormState>();
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  void dispose() {
    fNameCont.dispose();
    lNameCont.dispose();
    emailCont.dispose();
    numberCont.dispose();
    addressCont.dispose();
    ageCont.dispose();
    desigCont.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sw = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Center(
          child: Hero(
            tag: heroAddTodo,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                  child: SizedBox(
                    width: 900,
                    child: Material(
                      color: Colors.black87.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Form(
                        key: _formKey,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 40),
                          decoration: BoxDecoration(
                              border: Border.all(color: MainShade, width: 0.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: sw < 600
                                  ? [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: const Text(
                                                  "Member ID",
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    //fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              FutureBuilder<String?>(
                                                  future: getID(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                    } else if (snapshot.data ==
                                                        null) {
                                                      return Text(
                                                          'ID not found or field is null.');
                                                    } else {
                                                      return Container(
                                                        height: 50,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.white12,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        child: Center(
                                                          child: Text(
                                                            // '${snapshot.data}',
                                                            sw.toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  })
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          crudTxtfield(
                                            txtinput: TextInputType.text,
                                            format: [
                                              FilteringTextInputFormatter
                                                  .singleLineFormatter
                                            ],
                                            widht: 200,
                                            title: "First Name",
                                            controller: fNameCont,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          crudTxtfield(
                                            txtinput: TextInputType.text,
                                            format: [
                                              FilteringTextInputFormatter
                                                  .singleLineFormatter
                                            ],
                                            widht: 200,
                                            title: "Last Name",
                                            controller: lNameCont,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
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
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          crudTxtfield(
                                            txtinput:
                                                TextInputType.emailAddress,
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
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          crudTxtfield(
                                            txtinput: TextInputType.text,
                                            format: [
                                              FilteringTextInputFormatter
                                                  .singleLineFormatter
                                            ],
                                            widht: sw < 700 ? 200 : 540,
                                            title: "Address",
                                            controller: addressCont,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
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
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      widget.modeletter == "S"
                                          ? Row(
                                              children: [
                                                crudTxtfield(
                                                  title: "Designation",
                                                  widht: 250,
                                                  controller: desigCont,
                                                  txtinput: TextInputType.text,
                                                  format: [
                                                    FilteringTextInputFormatter
                                                        .singleLineFormatter
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Package",
                                                        style: const TextStyle(
                                                          color: Colors.white70,
                                                          fontFamily:
                                                              "Montserrat",
                                                          fontSize: 14,
                                                          //fontWeight: FontWeight.w600
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      StreamBuilder(
                                                          stream: packagecol
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshot) {
                                                            List<DropdownMenuItem>
                                                                packageslist =
                                                                [];
                                                            if (!snapshot
                                                                .hasData) {
                                                              return CircularProgressIndicator();
                                                            } else {
                                                              final packages =
                                                                  snapshot.data
                                                                      ?.docs
                                                                      .toList();

                                                              packageslist.add(
                                                                  DropdownMenuItem(
                                                                      value:
                                                                          "0",
                                                                      child: Text(
                                                                          "Select Package")));
                                                              for (var data
                                                                  in packages!) {
                                                                packageslist.add(
                                                                    DropdownMenuItem(
                                                                        value: data[
                                                                            "name"],
                                                                        child:
                                                                            Text(
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
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10))),
                                                              child: Center(
                                                                child:
                                                                    DropdownButtonHideUnderline(
                                                                  child:
                                                                      DropdownButtonFormField(
                                                                    decoration: InputDecoration(
                                                                        border: InputBorder.none,
                                                                        errorMaxLines: 1,
                                                                        errorStyle: TextStyle(
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
                                                                        DarkShade,
                                                                    onChanged:
                                                                        (clientvalue) {
                                                                      setState(
                                                                          () {
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
                                                ),
                                              ],
                                            ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Platform",
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 14,
                                                  //fontWeight: FontWeight.w600
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection("$colname")
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
                                                                  Radius
                                                                      .circular(
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
                                                                    fontSize:
                                                                        10,
                                                                  )),
                                                          validator: (value) {
                                                            if (value == "0") {
                                                              return "Please select a valid option";
                                                            }
                                                          },
                                                          dropdownColor:
                                                              DarkShade,
                                                          value:
                                                              selectedplatform,
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
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Starting Date",
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 14,
                                                  //fontWeight: FontWeight.w600
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Container(
                                                width: 175,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.white12,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              const Color
                                                                  .fromARGB(31,
                                                                  17, 17, 17)),
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
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Gender",
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 14,
                                                  //fontWeight: FontWeight.w600
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Container(
                                                height: 50,
                                                width: 175,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                decoration: BoxDecoration(
                                                    color: Colors.white12,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    dropdownColor: DarkShade,
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
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 120,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  final firstname =
                                                      fNameCont.text;
                                                  fNameCont.clear();
                                                  final lastname =
                                                      lNameCont.text;
                                                  lNameCont.clear();

                                                  final package =
                                                      selectedpackage;

                                                  final platform =
                                                      selectedplatform;
                                                  final number =
                                                      numberCont.text;
                                                  numberCont.clear();
                                                  final designation =
                                                      desigCont.text;
                                                  final address =
                                                      addressCont.text;
                                                  addressCont.clear();
                                                  final email = emailCont.text;
                                                  final selectD = dateFormat
                                                      .format(selectedDate);
                                                  emailCont.clear();
                                                  final age = ageCont.text;
                                                  ageCont.clear();

                                                  widget.modeletter == "S"
                                                      ? addStaff(
                                                          time: "6:00PM",
                                                          age: age,
                                                          email: email,
                                                          idnum: userIDnum,
                                                          id: userID,
                                                          fname: firstname,
                                                          lname: lastname,
                                                          gender:
                                                              Selectedgender,
                                                          designation:
                                                              designation,
                                                          platform: platform,
                                                          number: number,
                                                          startdate: selectD,
                                                          date: selectedDate,
                                                          address: address,
                                                        )
                                                      : addMember(
                                                          age: age,
                                                          email: email,
                                                          idnum: userIDnum,
                                                          id: userID,
                                                          fname: firstname,
                                                          lname: lastname,
                                                          gender:
                                                              Selectedgender,
                                                          package: package,
                                                          platform: platform,
                                                          number: number,
                                                          startdate: selectD,
                                                          date: selectedDate,
                                                          address: address,
                                                        );
                                                  selectedDate = DateTime.now();
                                                  selectedpackage = "0";
                                                  selectedplatform = "0";
                                                  Selectedgender = "Male";
                                                  setState(() {});
                                                }
                                              },
                                              // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),

                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: MainShade,
                                                  elevation: 12.0,
                                                  textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              child: const Text('Add Member'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 50,
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
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              child: const Text('Cancel'),
                                            ),
                                          ),
                                        ],
                                      )
                                    ]
                                  : [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: const Text(
                                                  "Member ID",
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    //fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              FutureBuilder<String?>(
                                                  future: getID(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator();
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                    } else if (snapshot.data ==
                                                        null) {
                                                      return Text(
                                                          'ID not found or field is null.');
                                                    } else {
                                                      return Container(
                                                        height: 50,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.white12,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        child: Center(
                                                          child: Text(
                                                            // '${snapshot.data}',
                                                            sw.toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  })
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          crudTxtfield(
                                            txtinput: TextInputType.text,
                                            format: [
                                              FilteringTextInputFormatter
                                                  .singleLineFormatter
                                            ],
                                            widht: 200,
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
                                            widht: 200,
                                            title: "Last Name",
                                            controller: lNameCont,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
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
                                            txtinput:
                                                TextInputType.emailAddress,
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
                                      SizedBox(
                                        height: 24,
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
                                            widht: sw < 700 ? 200 : 540,
                                            title: "Address",
                                            controller: addressCont,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
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
                                          widget.modeletter == "S"
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
                                                    Text(
                                                      "Package",
                                                      style: const TextStyle(
                                                        color: Colors.white70,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 14,
                                                        //fontWeight: FontWeight.w600
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    StreamBuilder(
                                                        stream: packagecol
                                                            .snapshots(),
                                                        builder: (context,
                                                            snapshot) {
                                                          List<DropdownMenuItem>
                                                              packageslist = [];
                                                          if (!snapshot
                                                              .hasData) {
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
                                                                      child:
                                                                          Text(
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
                                                                      DarkShade,
                                                                  onChanged:
                                                                      (clientvalue) {
                                                                    setState(
                                                                        () {
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
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Platform",
                                                  style: const TextStyle(
                                                    color: Colors.white70,
                                                    fontFamily: "Montserrat",
                                                    fontSize: 14,
                                                    //fontWeight: FontWeight.w600
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection("$colname")
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      List<DropdownMenuItem>
                                                          packageslist = [];
                                                      if (!snapshot.hasData) {
                                                        return CircularProgressIndicator();
                                                      } else {
                                                        final packages =
                                                            snapshot.data?.docs
                                                                .reversed
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
                                                                  value:
                                                                      data.id,
                                                                  child: Text(
                                                                      data.id)));
                                                        }
                                                      }
                                                      return Container(
                                                        height: 50,
                                                        width: 175,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.white12,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
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
                                                                      fontSize:
                                                                          10,
                                                                    )),
                                                            validator: (value) {
                                                              if (value ==
                                                                  "0") {
                                                                return "Please select a valid option";
                                                              }
                                                            },
                                                            dropdownColor:
                                                                DarkShade,
                                                            value:
                                                                selectedplatform,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
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
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 24,
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
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 14,
                                                  //fontWeight: FontWeight.w600
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Container(
                                                width: 175,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.white12,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              const Color
                                                                  .fromARGB(31,
                                                                  17, 17, 17)),
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
                                              Text(
                                                "Gender",
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontFamily: "Montserrat",
                                                  fontSize: 14,
                                                  //fontWeight: FontWeight.w600
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Container(
                                                height: 50,
                                                width: 175,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                decoration: BoxDecoration(
                                                    color: Colors.white12,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    dropdownColor: DarkShade,
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
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 120,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  final firstname =
                                                      fNameCont.text;
                                                  fNameCont.clear();
                                                  final lastname =
                                                      lNameCont.text;
                                                  lNameCont.clear();

                                                  final package =
                                                      selectedpackage;

                                                  final platform =
                                                      selectedplatform;
                                                  final number =
                                                      numberCont.text;
                                                  numberCont.clear();
                                                  final designation =
                                                      desigCont.text;
                                                  final address =
                                                      addressCont.text;
                                                  addressCont.clear();
                                                  final email = emailCont.text;
                                                  final selectD = dateFormat
                                                      .format(selectedDate);
                                                  emailCont.clear();
                                                  final age = ageCont.text;
                                                  ageCont.clear();

                                                  widget.modeletter == "S"
                                                      ? addStaff(
                                                          time: "6:00PM",
                                                          age: age,
                                                          email: email,
                                                          idnum: userIDnum,
                                                          id: userID,
                                                          fname: firstname,
                                                          lname: lastname,
                                                          gender:
                                                              Selectedgender,
                                                          designation:
                                                              designation,
                                                          platform: platform,
                                                          number: number,
                                                          startdate: selectD,
                                                          date: selectedDate,
                                                          address: address,
                                                        )
                                                      : addMember(
                                                          age: age,
                                                          email: email,
                                                          idnum: userIDnum,
                                                          id: userID,
                                                          fname: firstname,
                                                          lname: lastname,
                                                          gender:
                                                              Selectedgender,
                                                          package: package,
                                                          platform: platform,
                                                          number: number,
                                                          startdate: selectD,
                                                          date: selectedDate,
                                                          address: address,
                                                        );
                                                  selectedDate = DateTime.now();
                                                  selectedpackage = "0";
                                                  selectedplatform = "0";
                                                  Selectedgender = "Male";
                                                  setState(() {});
                                                }
                                              },
                                              // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),

                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: MainShade,
                                                  elevation: 12.0,
                                                  textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              child: const Text('Add Member'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 100,
                                            height: 50,
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
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future addStaff(
      {required String fname,
      required String lname,
      required String email,
      required String age,
      required String? gender,
      required String designation,
      required String? platform,
      required String number,
      required String address,
      required String startdate,
      required DateTime date,
      required id,
      required time,
      required idnum}) async {
    final docUser = FirebaseFirestore.instance
        .collection("/$colname/$clientplat/Staff")
        .doc(id + (idnum + 1).toString());

    final json = {
      "idnum": idnum + 1,
      "id": id + (idnum + 1).toString(),
      "age": age,
      "status": "Staff",
      "firstName": fname,
      "lastName": lname,
      "gender": gender,
      "designation": designation,
      "platform": platform,
      "phoneNumber": number,
      "email": email,
      "address": address,
      "startDate": startdate,
      "startTime": time,
      "defaulter": false,
      "date": date
    };
    await docUser.set(json);
  }

  Future addMember(
      {required String fname,
      required String lname,
      required String email,
      required String age,
      required String? gender,
      required String? package,
      required String? platform,
      required String number,
      required String address,
      required String startdate,
      required DateTime date,
      required id,
      required idnum}) async {
    final docUser = FirebaseFirestore.instance
        .collection("/$colname/$clientplat/Members")
        .doc(id + (idnum + 1).toString());

    final json = {
      "idnum": idnum + 1,
      "id": id + (idnum + 1).toString(),
      "age": age,
      "status": "Member",
      "feeStatus": "Paid",
      "firstName": fname,
      "lastName": lname,
      "gender": gender,
      "package": package,
      "platform": platform,
      "phoneNumber": number,
      "email": email,
      "address": address,
      "startDate": startdate,
      "defaulter": false,
      "date": date
    };
    await docUser.set(json);
  }
}
