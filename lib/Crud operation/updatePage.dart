import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/SharedComponent.dart';

class UpdateUser extends StatefulWidget {
  var docsnap;
  UpdateUser({super.key, required this.docsnap});

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
  var genders = ["Male", "Female"];

  late DateTime selectedDate;
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  int userIDnum = 0;
  String userID = "";
  Future<String?> getID() async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('TGym').doc("GYM").get();

      var snap = await FirebaseFirestore.instance
          .collection('/TGym/GYM/Members')
          .orderBy("idnum", descending: false)
          .get();
      var mID = 0;
      if (snap.size != 0) {
        mID = snap.docs.last["idnum"];
      }

      var finalID = snapshot.get("initials") + "-M-";
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

  @override
  void initState() {
    selectedplatform = widget.docsnap["Platform"];
    selectedpackage = widget.docsnap["Package"];
    Selectedgender = widget.docsnap["Gender"];
    fNameCont.text = widget.docsnap["First name"];
    lNameCont.text = widget.docsnap["Last name"];
    emailCont.text = widget.docsnap["Email"];
    addressCont.text = widget.docsnap["Address"];
    numberCont.text = widget.docsnap["Phone Number"];
    selectedDate = (widget.docsnap['Date'] as Timestamp).toDate();
    ;
    super.initState();
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
          child: Container(
            height: 700,
            width: 1100,
            child: Material(
              color: lightBlu,
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
                                color: lightBlu,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                              color: DarkBlu,
                                              borderRadius: BorderRadius.all(
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    crudTxtfield(
                                      txtinput: TextInputType.number,
                                      format: [
                                        FilteringTextInputFormatter.digitsOnly
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Package",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection(
                                                    "/TGym/GYM/Packages")
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              List<DropdownMenuItem>
                                                  packageslist = [];
                                              if (!snapshot.hasData) {
                                                return CircularProgressIndicator();
                                              } else {
                                                final packages = snapshot
                                                    .data?.docs
                                                    .toList();

                                                packageslist.add(
                                                    DropdownMenuItem(
                                                        value: "0",
                                                        child: Text(
                                                            "Select Package")));
                                                for (var data in packages!) {
                                                  packageslist
                                                      .add(DropdownMenuItem(
                                                          value: data["name"],
                                                          child: Text(
                                                            data["name"],
                                                          )));
                                                }
                                              }
                                              return Container(
                                                height: 50,
                                                width: 175,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                decoration: BoxDecoration(
                                                    color: DarkBlu,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Center(
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButtonFormField(
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              errorMaxLines: 1,
                                                              errorStyle:
                                                                  TextStyle(
                                                                fontSize: 10,
                                                              )),
                                                      validator: (value) {
                                                        if (value == "0") {
                                                          return "Please select a valid option";
                                                        }
                                                      },
                                                      value: selectedpackage,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      items: packageslist,
                                                      dropdownColor: DarkBlu,
                                                      onChanged: (clientvalue) {
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
                                            style:
                                                TextStyle(color: Colors.white)),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection("/TGym")
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
                                                for (var data in packages!) {
                                                  packageslist.add(
                                                      DropdownMenuItem(
                                                          value: "0",
                                                          child: Text(
                                                              "Select Platform")));
                                                  packageslist.add(
                                                      DropdownMenuItem(
                                                          value: data.id,
                                                          child:
                                                              Text(data.id)));
                                                }
                                              }
                                              return Container(
                                                height: 50,
                                                width: 175,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                decoration: BoxDecoration(
                                                    color: DarkBlu,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        errorMaxLines: 1,
                                                        errorStyle: TextStyle(
                                                          fontSize: 10,
                                                        )),
                                                    validator: (value) {
                                                      if (value == "0") {
                                                        return "Please select a valid option";
                                                      }
                                                    },
                                                    dropdownColor: DarkBlu,
                                                    value: selectedplatform,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    items: packageslist,
                                                    onChanged: (clientvalue) {
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            onPressed: () =>
                                                _selectDate(context),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Gender",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Container(
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
                                              value: Selectedgender,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              items:
                                                  genders.map((String items) {
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
                                            final firstname = fNameCont.text;

                                            final lastname = lNameCont.text;

                                            final package = selectedpackage;

                                            final platform = selectedplatform;
                                            final number = numberCont.text;

                                            final address = addressCont.text;

                                            final email = emailCont.text;
                                            final selectD =
                                                dateFormat.format(selectedDate);

                                            updateMember(
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
                                            backgroundColor: Blu,
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
                                        onPressed: () => Navigator.pop(context),
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
    );
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
      required DateTime date,
      required id,
      required idnum}) async {
    final docUser =
        FirebaseFirestore.instance.collection("/TGym/GYM/Members").doc(id);

    final json = {
      "Fee Status": "Paid",
      "First name": fname,
      "Last name": lname,
      "Gender": gender,
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
