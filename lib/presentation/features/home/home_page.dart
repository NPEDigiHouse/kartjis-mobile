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
  late final ValueNotifier<String> _query;

  @override
  void initState() {
    super.initState();

    _query = ValueNotifier('');
  }

  @override
  void dispose() {
    super.dispose();

    _query.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
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
                pinned: true,
                elevation: 0,
                automaticallyImplyLeading: false,
                toolbarHeight: kToolbarHeight + 48,
                backgroundColor: scaffoldBackgroundColor.withAlpha(200),
                flexibleSpace: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                        child: Column(
                          children: <Widget>[
                            ValueListenableBuilder(
                              valueListenable: _query,
                              builder: (context, value, child) {
                                return SearchField(
                                  text: value,
                                  onChanged: (query) => _query.value = query,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: List<Text>.generate(20, (index) {
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

  @override
  bool get wantKeepAlive => true;
}
