import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:s_a_m_s/Crud%20operation/Addpage.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/Crud%20operation/updatePage.dart';
import 'package:s_a_m_s/SharedComponent.dart';

class LockerPopUp extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  final memberid;
  LockerPopUp({
    Key? key,
    required this.memberid,
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
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            height: 200,
            width: 250,
            decoration: BoxDecoration(
                color: LightShade,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Material(
                color: LightShade,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assign Locker",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontSize: 14),
                    ),
                    Divider(
                      color: Colors.white12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 55,
                        //   // decoration: BoxDecoration(
                        //   //     border: Border.all(color: Colors.white)),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Text(
                        //         "Locker Number",
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 14,
                        //             fontFamily: "Montserrat"),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        crudTxtfield(
                          txtinput: TextInputType.text,
                          format: [
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                          widht: 200,
                          title: "Locker Number",
                          controller: idcont,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: ElevatedButton(
                            onPressed: () {
                              addMember(
                                id: memberid,
                                locker: idcont.text,
                              );

                              Navigator.pop(context);
                            },
                            // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),

                            style: ElevatedButton.styleFrom(
                                backgroundColor: MainShade,
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
                          width: 80,
                          height: 30,
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
    required locker,
  }) async {
    try {
      final docUser = activitycol.doc("$id");

      final json = {"Locker": locker};
      print(locker);
      print(id);
      await docUser.update(json);
      lockerOn = true;
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
