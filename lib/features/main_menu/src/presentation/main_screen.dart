import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/features/event/src/presentation/pages/event/event_page.dart';
import 'package:kartjis_mobile_app/features/home/src/presentation/pages/home/home_page.dart';
import 'package:kartjis_mobile_app/features/ticket/src/presentation/pages/ticket_page.dart';
import 'package:kartjis_mobile_app/features/users/src/presentation/pages/user_profile/profile_page.dart';

import '../../../../cores/core.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final PageController _pageController;
  late final ValueNotifier<int> _selectedIndex;

  final List<Widget> _pages = <Widget>[];

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _selectedIndex = ValueNotifier(0);

    _pages.addAll([
      const HomePage(),
      const EventPage(),
      const TicketPage(),
      const ProfilePage(),
    ]);
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
    _selectedIndex.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        clipBehavior: Clip.none,
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) => _selectedIndex.value = index,
      ),
      bottomNavigationBar: _BottomNavBar(
        selectedIndex: _selectedIndex,
        pageController: _pageController,
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final ValueNotifier<int> selectedIndex;
  final PageController pageController;

  const _BottomNavBar({
    required this.selectedIndex,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, selectedIndex, child) {
        return BottomNavigationBar(
          elevation: 0,
          currentIndex: selectedIndex,
          backgroundColor: Palette.scaffoldBackgroundColor,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: Palette.secondaryColor,
          selectedLabelStyle: TextStyle(
            color: Palette.secondaryColor,
            fontWeight: FontWeight.w600,
          ),
          unselectedItemColor: Palette.primaryTextColor,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                KartjisIcons.home,
              ),
              activeIcon: SvgPicture.asset(
                KartjisIcons.home,
                color: Palette.secondaryColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                KartjisIcons.search,
              ),
              activeIcon: SvgPicture.asset(
                KartjisIcons.search,
                color: Palette.secondaryColor,
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                KartjisIcons.ticket,
              ),
              activeIcon: SvgPicture.asset(
                KartjisIcons.ticket,
                color: Palette.secondaryColor,
              ),
              label: 'Tickets',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                KartjisIcons.profile,
              ),
              activeIcon: SvgPicture.asset(
                KartjisIcons.profile,
                color: Palette.secondaryColor,
              ),
              label: 'Me',
            ),
          ],
          onTap: (index) {
            this.selectedIndex.value = index;
            pageController.jumpToPage(index);
          },
        );
      },
    );
  }
}
