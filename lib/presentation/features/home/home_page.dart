import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kartjis_mobile_app/common/helpers/asset_path.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/data/dummies.dart';
import 'package:kartjis_mobile_app/presentation/widgets/search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late final ValueNotifier<String> query;
  late final ValueNotifier<String> eventType;

  late final List<String> eventTypes;

  @override
  void initState() {
    super.initState();

    eventTypes = [
      'Semua',
      'Konser',
      'Bazar',
      'Seminar',
      'Pertandingan',
      'Lainnya',
    ];

    query = ValueNotifier('');
    eventType = ValueNotifier(eventTypes[0]);
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
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
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: backgroundColor,
                        foregroundImage: AssetImage(
                          AssetPath.getImage('avatar1.jpg'),
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
                toolbarHeight: kToolbarHeight + 72,
                backgroundColor: scaffoldBackgroundColor.withAlpha(200),
                flexibleSpace: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: <Widget>[
                          _buildSearchField(),
                          _buildChoiceChips(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: List<Text>.generate(30, (index) {
                return Text(
                  'Hello world',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildSearchField() {
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

  SizedBox _buildChoiceChips() {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
        scrollDirection: Axis.horizontal,
        itemCount: eventTypes.length,
        itemBuilder: (context, index) {
          return ValueListenableBuilder(
            valueListenable: eventType,
            builder: (context, type, child) {
              var isSelected = type == eventTypes[index];

              return ChoiceChip(
                label: Text(eventTypes[index]),
                labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: primaryColor),
                selectedColor: primaryColor.withOpacity(.2),
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: isSelected ? null : const BorderSide(color: dividerColor),
                selected: isSelected,
                onSelected: (_) => eventType.value = eventTypes[index],
              );
            },
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
