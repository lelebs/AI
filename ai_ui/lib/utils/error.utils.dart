import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showDialogError(context, bool isDismissible, text, {buttonText = 'Ok'}) {
  showDialog(
    context: context ,
    barrierDismissible: isDismissible,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(text),
        actions: <Widget>[
          FlatButton(
            child: Text(buttonText),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}