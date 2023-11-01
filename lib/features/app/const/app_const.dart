


import 'package:fluttertoast/fluttertoast.dart';
import 'package:whatsapp_clone_app/features/app/theme/style.dart';

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: tabColor,
      textColor: whiteColor,
      fontSize: 16.0);
}
