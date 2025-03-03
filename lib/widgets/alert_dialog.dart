
import 'package:flutter/cupertino.dart';

class MyAlertDialog {
  static void showMyDialog({
    required BuildContext context,
    required String title,
    required String message,
    required Function() tapNo,
    required Function() tapYes,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder:
          (BuildContext context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  tapNo();
                },
                child: const Text('No'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  tapYes();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
    );
  }
}
