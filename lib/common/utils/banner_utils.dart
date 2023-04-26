import 'package:flutter/material.dart';
import 'package:kartjis_mobile_app/common/utils/keys.dart';

class BannerUtils {
  static MaterialBanner createMaterialBanner({
    required String contentText,
    Color? foregroundColor,
    Color? backgroundColor,
    IconData? leadingIcon,
  }) {
    return MaterialBanner(
      backgroundColor: backgroundColor,
      content: Text(
        contentText,
        style: TextStyle(color: foregroundColor),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            scaffoldMessengerKey.currentState!.hideCurrentMaterialBanner();
          },
          child: Text(
            'Ok',
            style: TextStyle(color: foregroundColor),
          ),
        ),
      ],
      leading: Icon(
        leadingIcon,
        color: foregroundColor,
      ),
      leadingPadding: const EdgeInsetsDirectional.only(end: 12.0),
    );
  }
}
