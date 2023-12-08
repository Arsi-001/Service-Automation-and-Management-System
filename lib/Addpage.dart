import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:s_a_m_s/Constant.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController fNameCont = TextEditingController();
    TextEditingController lNameCont = TextEditingController();
    TextEditingController genderCont = TextEditingController();
    TextEditingController packageCont = TextEditingController();
    TextEditingController feestatusCont = TextEditingController();
    TextEditingController platformCont = TextEditingController();
    TextEditingController numberCont = TextEditingController();
    TextEditingController startdateCont = TextEditingController();
    TextEditingController addressCont = TextEditingController();

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
                            crudTxtfield(
                              title: "Member ID",
                              controller: fNameCont,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            crudTxtfield(
                              title: "First Name",
                              controller: fNameCont,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            crudTxtfield(
                              title: "Last Name",
                              controller: lNameCont,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            crudTxtfield(
                              title: "Gender",
                              controller: genderCont,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            crudTxtfield(
                              title: "Package",
                              controller: packageCont,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            crudTxtfield(
                              title: "Age",
                              controller: feestatusCont,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            crudTxtfield(
                              title: "Platform",
                              controller: platformCont,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            crudTxtfield(
                              title: "Number",
                              controller: numberCont,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            crudTxtfield(
                              title: "Starting Date",
                              controller: startdateCont,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            crudTxtfield(
                              title: "Address",
                              controller: addressCont,
                            ),
                            SizedBox(
                              width: 40,
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
                                  final gender = genderCont.text;
                                  
                                  final package = packageCont.text;
                                  final feestatus = feestatusCont.text;
                                  final platform = platformCont.text;
                                  final number = numberCont.text;
                                  final startdate = startdateCont.text;
                                  final address = addressCont.text;

                                  addMember(
                                    fname: firstname,
                                    lname: lastname,
                                    gender: gender,
                                    package: package,
                                    platform: platform,
                                    number: number,
                                    startdate: startdate,
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
    required String gender,
    required String package,
    required String platform,
    required String number,
    required String address,
    required String startdate,
  }) async {
    final docUser = FirebaseFirestore.instance
        .collection("/Platform/Gym/TestGym/Information/Members")
        .doc("TG-M-02");

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
  crudTxtfield({
    required this.title,
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
          width: 250,
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
