import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartjis_mobile_app/cores/components/adv_column.dart';
import 'package:kartjis_mobile_app/cores/components/section_divider.dart';
import 'package:kartjis_mobile_app/cores/components/sliver_sized_box.dart';
import 'package:kartjis_mobile_app/cores/core.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/cores/styles/text_style.dart';
import 'package:kartjis_mobile_app/features/users/src/presentation/components/settings_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: textTheme.titleMedium?.copyWith(
              color: Palette.primaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Palette.scaffoldBackgroundColor,
          elevation: 0,
        ),
        backgroundColor: Palette.scaffoldBackgroundColor,
        body: const CustomScrollView(
          slivers: [
            _ProfileHeader(),
            SliverSizedBox(
              height: 16,
            ),
            SliverToBoxAdapter(child: SectionDivider()),
            _ProfileMenu(),
            SliverToBoxAdapter(child: SectionDivider()),
            SliverSizedBox(
              height: 32,
            ),
            _LogOutButton(),
            SliverSizedBox(
              height: 32,
            ),
            _ProfileFooter(),
            SliverSizedBox(
              height: 16,
            ),
          ],
        ));
  }
}

class _ProfileFooter extends StatelessWidget {
  const _ProfileFooter();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AdvColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'App Version : 1.0.0',
            style: textTheme.bodySmall
                ?.copyWith(color: Palette.secondaryTextColor),
          ),
          Text(
            '© 2023 CV. Kartjis.Id',
            style: textTheme.bodySmall
                ?.copyWith(color: Palette.secondaryTextColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Terms & Conditions',
                style: textTheme.bodySmall?.copyWith(
                    color: Palette.secondaryTextColor,
                    decoration: TextDecoration.underline),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Privacy Policy',
                style: textTheme.bodySmall?.copyWith(
                    color: Palette.secondaryTextColor,
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Palette.secondaryColor,
                  ),
                ),
                side: BorderSide(color: Palette.secondaryColor)),
            child: Text(
              'Log Out',
              style: textTheme.titleMedium?.copyWith(
                color: Palette.secondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              shape: BoxShape.circle,
              color: Palette.primaryTextColor,
              image: const DecorationImage(
                image: AssetImage('assets/img/avatar1.jpg'),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Jessy',
            style: textTheme.bodyLarge?.copyWith(
              color: Palette.primaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text('phantom26isn@gmail.com'),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.location_solid,
                color: Palette.primaryColor,
                size: 14,
              ),
              Text(
                'Makassar',
                style: textTheme.bodySmall,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  const _ProfileMenu();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AdvColumn(
        divider: Container(
          height: 1,
          color: Palette.dividerColor,
        ),
        children: [
          SettingsTile(
            text: 'Edit Profile',
            leadingIcon: SvgPicture.asset(KartjisIcons.profile),
          ),
          SettingsTile(
            text: 'App Settings',
            leadingIcon: SvgPicture.asset(KartjisIcons.device),
          ),
          SettingsTile(
            text: 'Get Help',
            leadingIcon: SvgPicture.asset(KartjisIcons.chat),
          ),
          SettingsTile(
            text: 'Rate Us',
            leadingIcon: SvgPicture.asset(KartjisIcons.star),
          ),
        ],
      ),
    );
  }
}
