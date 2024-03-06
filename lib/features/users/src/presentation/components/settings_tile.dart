import 'package:flutter/material.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';

class SettingsTile extends StatelessWidget {
  final String text;
  final Widget? leadingIcon;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.text,
    this.leadingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        maxLines: 1,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: leadingIcon,
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: Palette.primaryColor,
        size: 12,
      ),
      textColor: Palette.primaryColor,
      iconColor: Palette.primaryColor,
      tileColor: Palette.scaffoldBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      minLeadingWidth: 24,
    
      onTap: onTap,
    );
  }
}
