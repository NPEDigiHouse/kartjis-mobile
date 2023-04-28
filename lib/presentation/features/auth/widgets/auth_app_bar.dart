import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartjis_mobile_app/common/helpers/asset_path.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/common/utils/keys.dart';

class AuthAppBar extends StatelessWidget {
  final bool delayWhenBackButtonPressed;

  const AuthAppBar({
    super.key,
    this.delayWhenBackButtonPressed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () => back(context),
            icon: const Icon(Icons.chevron_left_rounded),
            iconSize: 32,
            color: primaryColor,
            tooltip: 'Back',
          ),
        ),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                AssetPath.getIcon('kartjis_filled.svg'),
                height: 36,
              ),
              const SizedBox(width: 8),
              const Text(
                'KARTJIS',
                style: TextStyle(
                  fontFamily: 'Titillium Web',
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void back(BuildContext context) {
    if (delayWhenBackButtonPressed) {
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
      Future.delayed(const Duration(seconds: 1), () {
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
