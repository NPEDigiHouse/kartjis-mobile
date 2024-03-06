import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartjis_mobile_app/cores/core.dart';
import 'package:kartjis_mobile_app/cores/helpers/app_size.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/cores/styles/text_style.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();

  static const String route = '/explore';
}

class _ExplorePageState extends State<ExplorePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const SizedBox.shrink(),
        flexibleSpace: SafeArea(
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Palette.primaryTextColor,
                ),
              ),
              const Expanded(child: _ReadOnlySearchField()),
            ],
          ),
        ),
        backgroundColor: Palette.scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                KartjisIcons.search,
                width: 80,
                height: 80,
                color: Palette.primaryColor,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Discover Event Near You',
                style: textTheme.titleLarge?.copyWith(
                  color: Palette.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Search for your fave performers, teams, dan shows to see upcoming experiences',
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ReadOnlySearchField extends StatelessWidget {
  const _ReadOnlySearchField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: SizedBox(
        height: 40,
        width: AppSize.getAppWidth(context) - 100,
        child: TextField(
          textInputAction: TextInputAction.search,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.5,
                color: Palette.primaryColor,
              ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            hintText: 'Find event, organizer, or venue',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: Palette.primaryTextColor,
                ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(80),
              borderSide: BorderSide(
                color: Palette.dividerColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(80),
              borderSide: BorderSide(
                color: Palette.primaryColor,
              ),
            ),
            focusColor: Palette.primaryColor,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                KartjisIcons.search,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
