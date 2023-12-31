
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/features/app/theme/style.dart';

displayAlertDialog(BuildContext context, {required VoidCallback onTap, required String confirmTitle, required String content}) {
  // set up the button

  Widget cancelButton = TextButton(
    child: const Text("Cancel", style: TextStyle(color: tabColor),),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget deleteButton = TextButton(
    onPressed: onTap,
    child: Text(confirmTitle, style: const TextStyle(color: tabColor),),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: backgroundColor,
    content: Text(content),
    actions: [cancelButton, deleteButton],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}