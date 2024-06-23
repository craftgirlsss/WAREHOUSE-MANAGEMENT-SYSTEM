import 'package:flutter/material.dart';

Future showMyDialog({context, String? title, String? content, Function()? onPressed}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? 'Unknown'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content ?? 'No content'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,  
              child: const Text('YA'),
            ),
            TextButton(
              child: const Text('TIDAK'),
              onPressed: () {
                Navigator.of(context).pop();
              },  
            ),
          ],
        );
      },
    );
  }