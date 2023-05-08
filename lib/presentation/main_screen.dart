import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartjis_mobile_app/common/helpers/asset_path.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/presentation/features/event/event_page.dart';
import 'package:kartjis_mobile_app/presentation/features/home/home_page.dart';
import 'package:kartjis_mobile_app/presentation/features/ticket/ticket_page.dart';

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
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        pageController: _pageController,
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final ValueNotifier<int> selectedIndex;
  final PageController pageController;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 16,
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0.0, -1.0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        child: ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (context, selectedIndex, child) {
            return BottomNavigationBar(
              elevation: 0,
              currentIndex: selectedIndex,
              backgroundColor: scaffoldBackgroundColor,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedLabelStyle: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                color: dividerColor,
                fontWeight: FontWeight.w400,
              ),
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AssetPath.getIcon('home_unselected.svg'),
                  ),
                  activeIcon: SvgPicture.asset(
                    AssetPath.getIcon('home_selected.svg'),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AssetPath.getIcon('events_unselected.svg'),
                  ),
                  activeIcon: SvgPicture.asset(
                    AssetPath.getIcon('events_selected.svg'),
                  ),
                  label: 'Events',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AssetPath.getIcon('ticket_unselected.svg'),
                  ),
                  activeIcon: SvgPicture.asset(
                    AssetPath.getIcon('ticket_selected.svg'),
                  ),
                  label: 'Ticket',
                ),
              ],
              onTap: (index) {
                this.selectedIndex.value = index;

                pageController.jumpToPage(index);
              },
            );
          },
        ),
      ),
    );
  }
}
