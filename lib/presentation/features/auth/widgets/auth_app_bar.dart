import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartjis_mobile_app/common/helpers/asset_path.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/common/utils/utilities.dart';

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
            onPressed: () => Utilities.popPage(
              context: context,
              withDelay: delayWhenBackButtonPressed,
            ),
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
}
