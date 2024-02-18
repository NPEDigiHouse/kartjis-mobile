import 'package:flutter/material.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';

class SettingsTile extends StatelessWidget {
  final String text;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.text,
    this.leadingIcon,
    this.trailingIcon,
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
      leading: Icon(leadingIcon),
      trailing: Icon(trailingIcon),
      textColor: primaryColor,
      iconColor: primaryColor,
      tileColor: scaffoldBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      minLeadingWidth: 24,
      onTap: onTap,
    );
  }
}
