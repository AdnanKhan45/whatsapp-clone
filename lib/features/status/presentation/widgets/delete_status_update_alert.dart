
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/features/app/theme/style.dart';

deleteStatusUpdate(BuildContext context, {required VoidCallback onTap}) {
  // set up the button

  Widget cancelButton = TextButton(
    child: const Text("Cancel", style: TextStyle(color: tabColor),),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget deleteButton = TextButton(
    onPressed: onTap,
    child: const Text("Delete", style: TextStyle(color: tabColor),),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: backgroundColor,
    title: const Text("Delete 1 status update"),
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