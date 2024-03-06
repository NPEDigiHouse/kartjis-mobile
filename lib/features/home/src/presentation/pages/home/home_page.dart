import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartjis_mobile_app/cores/components/search_field.dart';
import 'package:kartjis_mobile_app/cores/core.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/features/event/src/data/concert.dart';
import 'package:kartjis_mobile_app/features/home/src/presentation/components/carousel_card.dart';
import 'package:kartjis_mobile_app/features/home/src/presentation/components/horizontal_card.dart';
import 'package:kartjis_mobile_app/features/home/src/presentation/components/vertical_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late final List<String> eventList;
  late final ValueNotifier<String> query, eventType;
  late final ValueNotifier<int> showedIndex;

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
    showedIndex = ValueNotifier(0);
  }

  @override
  void dispose() {
    super.dispose();
    query.dispose();
    eventType.dispose();
    showedIndex.dispose();
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
          
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.local_fire_department,
                        size: 32,
                        color: Palette.primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Event Populer',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Palette.primaryColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                CarouselSlider.builder(
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
                    viewportFraction: 0.7,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                    onPageChanged: (index, reason) => showedIndex.value = index,
                  ),
                ),
                const SizedBox(height: 16),
                buildTitleSection(
                  title: 'Event Terdekat',
                  onPressedShowMoreText: () {},
                ),
                const SizedBox(height: 12),
                SizedBox(
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
                ),
                const SizedBox(height: 16),
                buildTitleSection(
                  title: 'Event Terbaru',
                  onPressedShowMoreText: () {},
                ),
                const SizedBox(height: 12),
                ...concerts.map((concert) {
                  return HorizontalCard(concert: concert);
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Padding buildTitleSection({
    required String title,
    required VoidCallback? onPressedShowMoreText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Palette.primaryColor,
                  ),
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onPressedShowMoreText,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Lihat lebih banyak',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Palette.primaryColor,
                        letterSpacing: 0,
                      ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Palette.primaryColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
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
