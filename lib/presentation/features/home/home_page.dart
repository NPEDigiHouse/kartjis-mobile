import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kartjis_mobile_app/common/helpers/asset_path.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/data/dummies/concert.dart';
import 'package:kartjis_mobile_app/data/dummies/user.dart';
import 'package:kartjis_mobile_app/presentation/widgets/search_field.dart';

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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Text>[
                            const Text(
                              'Selamat Datang,',
                              style: TextStyle(
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              '${user.name}!',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: backgroundColor,
                          foregroundImage: AssetImage(
                            AssetPath.getImage('avatar1.jpg'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                automaticallyImplyLeading: false,
                toolbarHeight: kToolbarHeight + 75,
                backgroundColor: scaffoldBackgroundColor.withAlpha(200),
                flexibleSpace: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: <Widget>[
                          buildSearchField(),
                          buildChoiceChips(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.local_fire_department,
                        size: 32,
                        color: primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Event Populer',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
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
                      builder: ((context, value, child) {
                        return buildConcertCard(
                          concert: concerts[index],
                          isShowed: value == index,
                        );
                      }),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Event Terdekat',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Lihat lebih banyak',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                    letterSpacing: 0,
                                  ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: primaryColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
      child: ValueListenableBuilder(
        valueListenable: query,
        builder: (context, value, child) {
          return SearchField(
            text: value,
            onChanged: (value) => query.value = value,
          );
        },
      ),
    );
  }

  SizedBox buildChoiceChips() {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
        scrollDirection: Axis.horizontal,
        itemCount: eventList.length,
        itemBuilder: (context, index) {
          return ValueListenableBuilder(
            valueListenable: eventType,
            builder: (context, value, child) {
              final isSelected = value == eventList[index];

              return ChoiceChip(
                pressElevation: 0,
                label: Text(eventList[index]),
                labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSelected ? backgroundColor : primaryColor,
                    ),
                selectedColor: primaryColor,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: isSelected ? null : const BorderSide(color: dividerColor),
                selected: isSelected,
                onSelected: (_) => eventType.value = eventList[index],
              );
            },
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
      ),
    );
  }

  Card buildConcertCard({
    required Concert concert,
    required bool isShowed,
  }) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(.4),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {},
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                concert.posterPath,
                fit: BoxFit.cover,
                width: 234,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              width: 234,
              height: isShowed ? 184 : 0,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: buildCardContent(concert),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView buildCardContent(Concert concert) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Organized by',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: tertiaryColor,
                          letterSpacing: 0,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Image.asset(
                    concert.organizerLogoPath,
                    height: 20,
                  ),
                ],
              ),
              Expanded(
                child: RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: secondaryColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${concert.price.split(" ")[0]}\t',
                        style: const TextStyle(fontSize: 10),
                      ),
                      TextSpan(
                        text: concert.price.split(' ')[1],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            concert.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              const Icon(
                Icons.event_rounded,
                size: 16,
                color: secondaryTextColor,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  DateFormat('dd MMMM y').format(concert.date),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: secondaryTextColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(
                Icons.location_on_rounded,
                size: 16,
                color: secondaryTextColor,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  concert.place,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: secondaryTextColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
