import 'package:flutter/material.dart';
import 'package:s_a_m_s/Addpage.dart';
import 'package:s_a_m_s/Constant.dart';
import 'package:s_a_m_s/updatePage.dart';

class AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const AddTodoPopupCard({
    Key? key,
  }) : super(key: key);
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
            width: 1000,
            child: Material(
                color: lightBlu,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                child: AddUser()),
          ),
        ),
      ),
    );
  }
}
