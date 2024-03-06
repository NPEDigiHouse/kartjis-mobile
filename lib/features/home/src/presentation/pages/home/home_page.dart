import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartjis_mobile_app/cores/components/adv_column.dart';
import 'package:kartjis_mobile_app/cores/components/adv_row.dart';
import 'package:kartjis_mobile_app/cores/components/section_divider.dart';
import 'package:kartjis_mobile_app/cores/core.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/cores/styles/text_style.dart';
import 'package:kartjis_mobile_app/features/event/src/data/concert.dart';
import 'package:kartjis_mobile_app/features/home/src/presentation/components/carousel_card.dart';
import 'package:kartjis_mobile_app/features/home/src/presentation/components/horizontal_card.dart';
import 'package:kartjis_mobile_app/features/home/src/presentation/components/vertical_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  late final List<String> eventList;
  late final ValueNotifier<String> query, eventType;

  @override
  void initState() {
    super.initState();

    eventList = [
      'Semua',
      'Konser',
      'Bazar',
      'Seminar',
      'Pertandingan',
      'Lainnya',
    ];

    query = ValueNotifier('');
    eventType = ValueNotifier(eventList[0]);
  }

  @override
  void dispose() {
    super.dispose();
    query.dispose();
    eventType.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (_, __) {
            return <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Palette.scaffoldBackgroundColor.withAlpha(200),
                title: KartjisAssets.logo,
                actions: const [
                  _ReadOnlySearchField(),
                ],
              ),
            ];
          },
          body: const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
            child: AdvColumn(
              divider: SizedBox(height: 12),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: [
                    _TrendingEventBanner(),
                    SizedBox(
                      height: 16,
                    ),
                    _HomeCategoryMenu(),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
                SectionDivider(),
                _TitleSection(
                  includeMore: false,
                  text: 'Trending Near You',
                  leading: Icon(Icons.local_fire_department_rounded),
                ),
                _TrendingCarousel(),
                SectionDivider(),
                _TitleSection(
                  includeMore: true,
                  text: 'Just Added',
                ),
                _JustAddedList(),
                SectionDivider(),
                _TitleSection(
                  includeMore: true,
                  text: 'Nearest',
                ),
                _NearestList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _HomeCategoryMenu extends StatelessWidget {
  const _HomeCategoryMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: AdvRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _HomeMenuIcon(iconPath: KartjisIcons.sport, title: 'Sports'),
              _HomeMenuIcon(iconPath: KartjisIcons.sing, title: 'Music'),
              _HomeMenuIcon(iconPath: KartjisIcons.teater, title: 'Show'),
              _HomeMenuIcon(iconPath: KartjisIcons.seminar, title: 'Seminar'),
              // _HomeMenuIcon(iconPath: KartjisIcons.view, title: 'Exahibition')
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: AdvRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _HomeMenuIcon(iconPath: KartjisIcons.view, title: 'Exahibition'),
              _HomeMenuIcon(iconPath: KartjisIcons.workshop, title: 'Workshop'),
              _HomeMenuIcon(iconPath: KartjisIcons.festival, title: 'Festival'),
              _HomeMenuIcon(iconPath: KartjisIcons.online, title: 'Online'),
              // _HomeMenuIcon(iconPath: KartjisIcons.view, title: 'Exahibition')
            ],
          ),
        ),
      ],
    );
  }
}

class _TrendingEventBanner extends StatelessWidget {
  const _TrendingEventBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/img/poster1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[
                    Colors.black.withOpacity(.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 42,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Judul Event',
                  style: textTheme.bodyLarge?.copyWith(
                    color: Palette.scaffoldBackgroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Location',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Palette.scaffoldBackgroundColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '2024.3.7',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Palette.scaffoldBackgroundColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.4),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '1',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Palette.backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeMenuIcon extends StatelessWidget {
  final String title;
  final String iconPath;
  const _HomeMenuIcon({required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4 - (16 * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            color: Palette.primaryTextColor,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _NearestList extends StatelessWidget {
  const _NearestList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...concerts.map((concert) {
          return HorizontalCard(concert: concert);
        }).toList()
      ],
    );
  }
}

class _JustAddedList extends StatelessWidget {
  const _JustAddedList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return VerticalCard(concert: concerts[index]);
        },
        separatorBuilder: (_, __) {
          return const SizedBox(width: 12);
        },
        itemCount: concerts.length,
      ),
    );
  }
}

class _TrendingCarousel extends StatefulWidget {
  const _TrendingCarousel();

  @override
  State<_TrendingCarousel> createState() => _TrendingCarouselState();
}

class _TrendingCarouselState extends State<_TrendingCarousel> {
  late final ValueNotifier<int> showedIndex;
  @override
  void initState() {
    super.initState();
    showedIndex = ValueNotifier(0);
  }

  @override
  void dispose() {
    super.dispose();
    showedIndex.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: concerts.length,
      itemBuilder: (context, index, realIndex) {
        return ValueListenableBuilder(
          valueListenable: showedIndex,
          builder: (context, value, child) {
            return CarouselCard(
              index: index,
              concert: concerts[index],
              isShowed: value == index,
            );
          },
        );
      },
      options: CarouselOptions(
        height: 360,
        viewportFraction: 0.63,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        onPageChanged: (index, reason) => showedIndex.value = index,
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  final String text;
  final Widget? leading;
  final VoidCallback? onMoreTap;
  final bool includeMore;
  const _TitleSection({required this.includeMore, this.leading, required this.text, this.onMoreTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        children: <Widget>[
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Palette.primaryColor,
                ),
          ),
          const Spacer(),
          if (includeMore)
            GestureDetector(
              onTap: onMoreTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Show More',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Palette.primaryColor,
                          letterSpacing: 0,
                        ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Palette.primaryColor,
                    size: 18,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ReadOnlySearchField extends StatelessWidget {
  const _ReadOnlySearchField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: SizedBox(
        height: 40,
        width: 200,
        child: TextField(
          readOnly: true,
          textInputAction: TextInputAction.search,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.5,
                color: Palette.primaryColor,
              ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            hintText: 'Find artist, team',
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
                color: Palette.dividerColor,
              ),
            ),
            suffixIcon: Padding(
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
