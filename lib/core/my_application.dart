import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:fluttertoast/fluttertoast.dart';

class MyApplication {
  static double hightClc(BuildContext context, int myHeight) {
    return MediaQuery.of(context).size.height * myHeight / 844;
  }

  static double widthClc(BuildContext context, int myWidth) {
    return MediaQuery.of(context).size.width * myWidth / 390;
  }

  static navigateTo(Widget page, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: ((context) => page)));
  }

  static navigateToRemove(BuildContext context, Widget widget, {data}) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (Route<dynamic> route) => false,
      );

  static navigateToReplace(Widget page, BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => page)));
  }

  static showToastView({
    required String message,
  }) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.pink,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future showAppDialog(BuildContext context, Widget content,
      {bool withPadding = true}) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true, // Close the dialog when clicking outside
      barrierLabel: '',
      barrierColor: Colors.black54, // Background color behind the dialog
      transitionDuration:
          const Duration(milliseconds: 400), // Animation duration
      pageBuilder: (context, anim1, anim2) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(withPadding ? 30 : 0),
            content: content);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(
              CurvedAnimation(parent: anim1, curve: Curves.easeOut),
            ),
            child: child,
          ),
        );
      },
    );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dialog from closing by tapping outside
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async =>
              false, // Prevent dialog from closing on back button
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Text("loading"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
