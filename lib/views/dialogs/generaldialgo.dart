import 'package:flutter/material.dart';
import 'package:tictactoe_client/views/utils.dart';

Dialog Function(BuildContext, String, String, String, String, Widget)
    generaldialog = (BuildContext context, String title, String text, String ok,
        String no, Widget specialwidget) {
  return Dialog(
    child: Container(
      height: SCREEN_HEIGHT * 0.7,
      width: SCREEN_WIDTH * 0.8,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(
                  right: SCREEN_WIDTH * 0.3, top: SCREEN_HEIGHT * 0.05),
              child: Text(title)),
          Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
          SizedBox(
            height: SCREEN_HEIGHT * 0.05,
          ),
          Container(
              margin: EdgeInsets.only(left: SCREEN_WIDTH * 0.1),
              child: Text(text)),
          SizedBox(
            height: SCREEN_HEIGHT * 0.05,
          ),
          Container(
              width: SCREEN_WIDTH * 0.7,
              height: SCREEN_HEIGHT * 0.25,
              child: specialwidget),
          SizedBox(
            height: SCREEN_HEIGHT * 0.05,
          ),
          Container(
            margin: EdgeInsets.only(left: SCREEN_WIDTH * 0.1),
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(ok)),
                SizedBox(
                  width: SCREEN_WIDTH * 0.3,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(no))
              ],
            ),
          ),
        ],
      ),
    ),
  );
};
