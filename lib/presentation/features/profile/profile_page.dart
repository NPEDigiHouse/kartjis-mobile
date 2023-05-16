import 'package:flutter/material.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/common/utils/keys.dart';
import 'package:kartjis_mobile_app/presentation/features/profile/widgets/settings_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: scaffoldBackgroundColor,
        foregroundColor: primaryColor,
        leading: IconButton(
          onPressed: () => navigatorKey.currentState!.pop(),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
          ),
        ),
        title: const Text('My Account'),
        titleSpacing: 0,
        titleTextStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          color: primaryColor,
          fontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                const SizedBox(
                  width: double.infinity,
                  height: 200,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: <Color>[
                          primaryColor,
                          primaryTextColor,
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 8,
                          spreadRadius: 1,
                          color: Colors.black.withOpacity(.1),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Richard Enrico Sulieanto',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '+62 821 9824 6668',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SettingsTile(
              text: 'Account',
              leadingIcon: Icons.person_2_rounded,
              trailingIcon: Icons.chevron_right_rounded,
              onTap: () {},
            ),
            const Divider(
              height: 0,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            SettingsTile(
              text: 'Languange',
              leadingIcon: Icons.language_rounded,
              trailingIcon: Icons.chevron_right_rounded,
              onTap: () {},
            ),
            const Divider(
              height: 0,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            SettingsTile(
              text: 'Location',
              leadingIcon: Icons.navigation_rounded,
              trailingIcon: Icons.chevron_right_rounded,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            SettingsTile(
              text: 'Kartjis Guide',
              leadingIcon: Icons.lightbulb_rounded,
              trailingIcon: Icons.chevron_right_rounded,
              onTap: () {},
            ),
            const Divider(
              height: 0,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            SettingsTile(
              text: 'Help',
              leadingIcon: Icons.help_rounded,
              trailingIcon: Icons.chevron_right_rounded,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            SettingsTile(
              text: 'Exit',
              leadingIcon: Icons.exit_to_app_rounded,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
