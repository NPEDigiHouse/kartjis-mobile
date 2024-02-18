import 'package:flutter/material.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/cores/utils/keys.dart';

class Utilities {
  static Future<void> popPage({
    required BuildContext context,
    bool withDelay = false,
  }) async {
    if (withDelay) {
      // show transparent barrier
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: scaffoldBackgroundColor.withOpacity(0),
        builder: (context) => const SizedBox.expand(),
      );

      // hide material banner if exist
      scaffoldMessengerKey.currentState!.hideCurrentMaterialBanner();

      // proccess
      await Future.delayed(const Duration(milliseconds: 500), () {
        // close barrier
        navigatorKey.currentState!.pop();
      }).then((_) {
        // back to previous page
        navigatorKey.currentState!.pop();
      });
    } else {
      // back to previous page
      navigatorKey.currentState!.pop();
    }
  }
}
