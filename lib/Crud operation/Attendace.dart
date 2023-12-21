import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:s_a_m_s/Crud%20operation/Addpage.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/Crud%20operation/updatePage.dart';
import 'package:s_a_m_s/SharedComponent.dart';

class AttendacePopUp extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  AttendacePopUp({
    Key? key,
  }) : super(key: key);
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  TextEditingController idcont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Center(
        child: Hero(
          tag: heroAddTodo,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            height: 200,
            width: 300,
            decoration: BoxDecoration(
                color: lightBlu,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Material(
                color: lightBlu,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Attendance Mode",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontSize: 14),
                    ),
                    crudTxtfield(
                      txtinput: TextInputType.text,
                      format: [FilteringTextInputFormatter.singleLineFormatter],
                      widht: 100,
                      title: "ID Number",
                      controller: idcont,
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
                            onPressed: () => addMember(
                              id: idcont.text,
                            ),
                            // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),

                            style: ElevatedButton.styleFrom(
                                backgroundColor: Blu,
                                elevation: 12.0,
                                textStyle:
                                    const TextStyle(color: Colors.white)),
                            child: const Text('Confirm'),
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
                            onPressed: () => Navigator.pop(context),
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
                )),
          ),
        ),
      ),
    );
  }

  Future addMember({
    required id,
  }) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await membercol.doc("TG-M-$id").get();

      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        final docUser = activitycol.doc(data?["ID"]);

        final json = {
          "Name": data?["First name"] + " " + data?["Last name"],
          "Fee Status": data?["Fee Status"],
          "Package": data?["Package"],
          "Platform": data?["Platform"],
          "Time In": "${DateFormat.jm().format(DateTime.now())}",
          "Defaulter": data?["Defaulter"]
        };
        await docUser.set(json);
      } else {
        print('Document $id does not exist in the collection.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
